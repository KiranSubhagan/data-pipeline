import json
import os
import time
import boto3
from confluent_kafka import Producer

sqs = boto3.client("sqs")

QUEUE_URL = os.environ["QUEUE_URL"]
BOOTSTRAP_SERVERS = os.environ["MSK_BOOTSTRAP_SERVERS"]
TOPIC = os.environ["MSK_TOPIC"]

producer = Producer({
    "bootstrap.servers": BOOTSTRAP_SERVERS
})


def publish_to_kafka(message_body):
    producer.produce(TOPIC, value=message_body.encode("utf-8"))
    producer.flush()


while True:
    response = sqs.receive_message(
        QueueUrl=QUEUE_URL,
        MaxNumberOfMessages=10,
        WaitTimeSeconds=20,
    )

    messages = response.get("Messages", [])

    for msg in messages:
        body = msg["Body"]

        publish_to_kafka(body)

        sqs.delete_message(
            QueueUrl=QUEUE_URL,
            ReceiptHandle=msg["ReceiptHandle"]
        )

    time.sleep(2)
