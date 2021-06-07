import requests
import shutil
from requests.auth import HTTPBasicAuth
import time
import datetime
import json

try:
    f = open("config.json", "r")
    config = json.loads(f.read())
    f.close()
except:
    print("Error reading config file.")
    exit(1)

cameras = config["camera_hostnames"]
basicauth_user = config["basic_auth_user"]
basicauth_password = config["basic_auth_password"]
output_path = config["output_directory"]
print("cameras", cameras)
print("output_path", output_path)


def get_image_from(camera_hostname):
    print("Capturing from ", camera_hostname)
    url = "http://" + camera_hostname + ":8080/?action=snapshot"
    camera_name = camera_hostname.split(".")[0]
    start = time.time()
    datestr = datetime.datetime.now().strftime("%d-%m-%Y-%H-%M-%S")
    r = requests.get(
        url, auth=HTTPBasicAuth(basicauth_user, basicauth_password), stream=True
    )
    print("status code", r.status_code)
    if r.status_code == 200:
        with open(output_path + camera_name + "-" + datestr + ".png", "wb") as out_file:
            shutil.copyfileobj(r.raw, out_file)
    else:
        print("Failed. Status code", r.status_code)
    print(f"Time taken: {time.time() - start}")


for camera in cameras:
    get_image_from(camera)
