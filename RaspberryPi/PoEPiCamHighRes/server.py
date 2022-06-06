from picamera2 import Picamera2
from io import BytesIO
from PIL import Image
from flask import Flask, redirect, request, make_response, send_file
from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash
import threading
from Focuser import Focuser
import os
import time

import argparse

parser = argparse.ArgumentParser(
    description="Start a static server for the Raspberry Pi camera."
)
parser.add_argument("--port", type=int, default=8080, help="Port to listen on")
parser.add_argument(
    "--username", type=str, default="MY_USER", help="Username for basic auth"
)
parser.add_argument(
    "--password", type=str, required=True, help="Password for basic auth"
)
parser.add_argument("--quality", type=int, default=90, help="JPEG quality")
parser.add_argument("--width", type=int, default=4656, help="Width of the image")
parser.add_argument("--height", type=int, default=3496, help="Height of the image")

args = parser.parse_args()
username = args.username
password = args.password
QUALITY = args.quality
PORT = args.port
WIDTH = args.width
HEIGHT = args.height

FOCUS_SUBDEV = "/dev/v4l-subdev1"
FOCUS_FILE = "/home/pi/focus.txt"

START_FOCUS = 1000
if not os.path.exists(FOCUS_FILE):
    with open(FOCUS_FILE, "w") as f:
        f.write("1000")
else:
    with open(FOCUS_FILE, "r") as f:
        START_FOCUS = int(f.read())

def write_focus(focus):
    with open(FOCUS_FILE, "w") as f:
        f.write(str(focus))

users = {username: generate_password_hash(str(password))}

class camera:
    def __init__(self):
        self.camera = Picamera2()
        self.config = self.camera.still_configuration()
        # self.config["main"]["size"] = (4056, 3040)
        self.config["main"]["size"] = (WIDTH, HEIGHT)

        self.camera.configure(self.config)
        self.capture_array = None
        self.img_io = BytesIO()
        self.pil_image = None

    def start(self):
        self.camera.start()

    def stop(self):
        self.camera.stop()

    def capture(self):
        self.capture_array = self.camera.capture_array()
        if self.capture_array is None:
            return False
        return True

    def get_as_jpeg(self, quality=QUALITY):
        t0 = time.time()
        Image.fromarray(self.capture_array).save(self.img_io, "JPEG", quality=quality)
        self.img_io.seek(0)
        print("Time taken to conf jpg: ", time.time() - t0)
        return self.img_io

    def get_as_pil(self):
        self.pil_image = Image.fromarray(self.capture_array)
        return self.pil_image

    def clear_buffer(self):
        self.img_io = BytesIO()
        self.pil_image = None

sem = threading.Semaphore()

focuser = Focuser(FOCUS_SUBDEV)
print("Setting focuser to {}".format(START_FOCUS))
focuser.set(Focuser.OPT_FOCUS, START_FOCUS)

cam = camera()
cam.start()

def serve_pil_image(pil_img, quality=QUALITY):
    img_io = BytesIO()
    pil_img.save(img_io, "JPEG", quality=quality)
    img_io.seek(0)
    return send_file(img_io, mimetype="image/jpeg")

app = Flask(__name__)
auth = HTTPBasicAuth()

@auth.verify_password
def verify_password(uname, passwd):
    if uname in users and check_password_hash(users.get(username), passwd):
        return uname


@app.route("/snapshot", methods=["GET"])
@auth.login_required
def capture():
    sem.acquire()
    t0 = time.time()

    cam.clear_buffer()
    if not cam.capture():
        sem.release()
        print("Capture failed")
        return "Failed to capture image", 500
    print("Capture took {} seconds".format(time.time() - t0))
    sem.release()
    return send_file(cam.get_as_jpeg(), mimetype="image/jpeg")


@app.route("/center", methods=["GET"])
@auth.login_required
def center():
    args = request.args
    quality = args.get("quality", QUALITY)
    try:
        quality = int(quality)
    except:
        quality = QUALITY
    sem.acquire()
    if not cam.capture():
        print("Capture failed")
        sem.release()
        return make_response(None, 408)
    pil_img = cam.get_as_pil()
    sem.release()
    # crop the center of the image
    w, h = pil_img.size
    pil_img = pil_img.crop((w / 4, h / 4, 3 * w / 4, 3 * h / 4))
    return serve_pil_image(pil_img, quality=quality)


@app.route("/setfocus", methods=["POST"])
@auth.login_required
def setfocus():
    print(request.form)
    focus = int(request.form["focus"])
    focuser.set(Focuser.OPT_FOCUS, focus)
    write_focus(focus)
    return redirect("/focus")


@app.route("/focus", methods=["GET"])
@auth.login_required
def focus_view():
    focus = focuser.get(Focuser.OPT_FOCUS)
    return """
    <body>
      <center>
        <h1>Focus</h1>
        <h4>Current focus: {}</h4>
        <form action="/setfocus" method="post">
            <input type="number" min="0" max="4095" step="5" name="focus" value="{}" />
            <input type="submit" value="Set Focus" />
        </form>
        <br />
        <a href="/center" target="_blank">Center preview</a>
      </center>
   </body>""".format(
        focus, focus
    )


@app.route("/", methods=["GET"])
@auth.login_required
def index():
    args = request.args
    print(args)
    if "action" in args:
        action = args["action"]
        if action == "snapshot":
            return capture()
    return """<html>
                <body>
                    <h1>PiCam2</h1>
                    <h3>Configuration</h3>
                    <p>Resolution: {}x{}</p>
                    <p>Quality: {}</p>
                    <h3>Actions</h3>
                    <a href=/snapshot target="_blank">Snapshot</a>
                    <br />
                    <a href=/focus target="_blank">Focus</a>
                    <br />
                    <a href=/center target="_blank">Center preview</a>
                </body>
            </html>""".format(
        WIDTH, HEIGHT, QUALITY)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT, debug=False)
cam.stop()
