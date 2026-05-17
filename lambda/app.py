import base64
import json
import boto3


glue = boto3.client("glue")

SCHEMA_REGISTRY_NAME = "event-registry"
SCHEMA_NAME = "event-schema"


def lambda_handler(event, context):
    for topic, records in event["records"].items():
        for record in records:
            payload = base64.b64decode(record["value"])
            data = json.loads(payload)

            print("Received:", data)

            # Validate or register schema logic goes here
            # For simplicity we just log the payload.

    return {
        "statusCode": 200,
        "body": "Processed"
    }
