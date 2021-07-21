import os
from PIL import Image
from flask import Flask, request, render_template, send_from_directory, redirect
from flask.helpers import send_file
from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
from io import BytesIO, StringIO
import socket

HOSTNAME = socket.gethostname()
base_directory = "/mnt/elements"

BASIC_AUTH_PASSWORD = os.environ.get("IMAGEPREVIEW_PASSWORD")

users = {"mitwelten": generate_password_hash(str(BASIC_AUTH_PASSWORD))}

app = Flask(__name__)
auth = HTTPBasicAuth()
APP_ROOT = os.path.dirname(os.path.abspath(__file__))


# width of the preview image
basewidth = 512

# create the preview image
def resize(filepath):
    print(filepath)
    img = Image.open(filepath)
    wpercent = basewidth / float(img.size[0])
    hsize = int((float(img.size[1]) * float(wpercent)))
    img = img.resize((basewidth, hsize), Image.ANTIALIAS)
    img_io = BytesIO()
    img.save(img_io, "JPEG", quality=70)
    img_io.seek(0)
    return send_file(img_io, mimetype="image/jpeg")

@auth.verify_password
def verify_password(username, password):
    if username in users and check_password_hash(users.get(username), password):
        return username

@app.route("/favicon.ico")
@auth.login_required
def favicon():
    return send_file("favicon.ico")

@app.route("/")
@auth.login_required
def index():
    dirs = []
    directories = os.listdir(base_directory)
    for item in directories:
        if os.path.isdir(base_directory + "/" + item):
            if not item.startswith("."):
                dirs.append(item)
    return render_template("index.html", title=HOSTNAME, directory_list=dirs)


# camera selected, select date
@app.route("/<camera_id>/")
@auth.login_required
def get_date(camera_id):
    dirs = []
    camera_id = secure_filename(camera_id)
    directories = os.listdir(base_directory + "/" + camera_id)
    for item in directories:
        if os.path.isdir(base_directory + "/" + camera_id + "/" + item):
            dirs.append(item)
    return render_template("selectday.html", camera_id=camera_id, directory_list=dirs)

# camera and date selected, select time
@app.route("/<camera_id>/<date>/")
@auth.login_required
def get_hour(camera_id, date):
    dirs = []
    camera_id = secure_filename(camera_id)
    date = secure_filename(date)
    directories = os.listdir(base_directory + "/" + camera_id + "/" + date)
    for item in directories:
        if os.path.isdir(base_directory + "/" + camera_id + "/" + date + "/" + item):
            dirs.append(item)
    return render_template(
        "selecthour.html", camera_id=camera_id, date=date, directory_list=dirs
    )

# preview page
@app.route("/<camera_id>/<date>/<hour>/")
@auth.login_required
def get_images(camera_id, date, hour):
    dirs = []
    camera_id = secure_filename(camera_id)
    date = secure_filename(date)
    hour = secure_filename(hour)
    image_names = os.listdir(base_directory + "/" + camera_id + "/" + date + "/" + hour)
    return render_template(
        "preview.html",
        file_names=image_names,
        camera_id=camera_id,
        date=date,
        hour=hour,
    )

# sends full size image
@app.route("/<camera_id>/<date>/<hour>/<filename>")
@auth.login_required
def send_image(camera_id, date, hour, filename):
    camera_id = secure_filename(camera_id)
    date = secure_filename(date)
    hour = secure_filename(hour)
    filename = secure_filename(filename)

    return send_from_directory(
        base_directory + "/" + camera_id + "/" + date + "/" + hour, filename
    )

# sends preview image
@app.route("/small/<camera_id>/<date>/<hour>/<filename>")
@auth.login_required
def send_imagesmall(camera_id, date, hour, filename):
    camera_id = secure_filename(camera_id)
    date = secure_filename(date)
    hour = secure_filename(hour)
    filename = secure_filename(filename)

    return resize(
        base_directory + "/" + camera_id + "/" + date + "/" + hour + "/" + filename
    )


if __name__ == "__main__":
    app.run(port=5000, debug=False)
