import requests
from requests.auth import HTTPBasicAuth
from concurrent.futures import ThreadPoolExecutor, as_completed
import time
import os
import datetime
import shutil
import json


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
capture_interval = config["capture_interval"]
start_hour = config["start_hour"]
stop_hour = config["stop_hour"]
print("camera_ids", camera_ids)
print("output_path", output_path)


def check_time_of_day():
    utc_time = datetime.datetime.utcnow()
    if (utc_time.hour >= start_hour) and (utc_time.hour <= stop_hour):
        return True
    else:
        return False


def get_image_from(camera_id):
    # print("Capturing from ", camera_id)
    url = "http://cam-" + camera_id + ".local:8080/?action=snapshot"
    utc_time = datetime.datetime.utcnow()
    filename = camera_id + "_" + utc_time.strftime("%Y-%m-%dT%H-%M-%SZ") + ".jpg"
    savepath = (
        output_path + camera_id + "/" + utc_time.strftime("%Y-%m-%d") + "/" + filename
    )
    try:
        os.makedirs(
            os.path.dirname(savepath), exist_ok=True
        )  # create path if not exists
        r = requests.get(
            url, stream=True, auth=HTTPBasicAuth(basicauth_user, basicauth_password)
        )
        # print("Camera",camera_id,": status code=", r.status_code)
        if r.status_code == 200:
            with open(savepath, "wb") as out_file:
                shutil.copyfileobj(r.raw, out_file)
        else:
            print("Failed. Status code", r.status_code)
        return camera_id + " : " + str(r.status_code)
    except Exception as e:
        print(e)


def capture_all():
    start = time.time()
    processes = []
    with ThreadPoolExecutor(max_workers=10) as executor:
        for camera_id in camera_ids:
            processes.append(executor.submit(get_image_from, camera_id))

    for task in as_completed(processes):
        print(task.result())
    print(f"Time taken: {time.time() - start}")


while True:
    if check_time_of_day():
        capture_all()
    time.sleep(capture_interval)
