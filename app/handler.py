import subprocess
import json
import sys
sys.path.append("/mnt/efs/65f1d0bedfe48adfa61252853de536db7306f85b8fdcf7aabfe2a37c1c75a8b9/.venv/lib/python3.6/site-packages")
import numpy as np

def hello(event, context):
    subprocess.run(["ls", "-l", "/mnt/efs/65f1d0bedfe48adfa61252853de536db7306f85b8fdcf7aabfe2a37c1c75a8b9/.venv/lib/python3.6/site-packages"])
    subprocess.run(["pwd"])

    arr = np.asarray([1,2,3])
    print(arr)

    body = {
        "message": "Go Serverless v1.0! Your function executed successfully!",
        "input": event
    }

    response = {
        "statusCode": 200,
        "body": json.dumps(body)
    }

    return response
