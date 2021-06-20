import requests
import shutil
from requests.auth import HTTPBasicAuth
import time
import datetime
import json
import os

try:
    f = open("config.json", "r")
    config = json.loads(f.read())
    f.close()
except:
    print("Error reading config file.")
    exit(1)

camera_ids = config["camera_ids"]
basicauth_user = config["basic_auth_user"]
basicauth_password = config["basic_auth_password"]
output_path = config["output_directory"]
print("camera_ids", camera_ids)
print("output_path", output_path)


def get_image_from(camera_id):
    print("Capturing from ", camera_id)
    url = "http://cam-" + camera_id + ".local:8080/?action=snapshot"
    start = time.time()
    utc_time = datetime.datetime.utcnow()
    filename = camera_id + "_" + utc_time.strftime("%Y-%m-%dT%H-%M-%SZ") + ".jpg"
    savepath = (
        output_path + camera_id + "/" + utc_time.strftime("%Y-%m-%d") + "/" + filename
    )
    os.makedirs(os.path.dirname(savepath), exist_ok=True)  # create path if not exists
    r = requests.get(
        url, auth=HTTPBasicAuth(basicauth_user, basicauth_password), stream=True
    )
    print("status code", r.status_code)
    if r.status_code == 200:
        with open(savepath, "wb") as out_file:
            shutil.copyfileobj(r.raw, out_file)
    else:
        print("Failed. Status code", r.status_code)
    print(f"Time taken: {time.time() - start}")


for camera in camera_ids:
    get_image_from(camera)

