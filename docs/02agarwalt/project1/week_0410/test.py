import os
import boto3
from argparse import ArgumentParser
import csv
import sys
sys.path.insert(0, '../')

def uploadS3(bucket, data, public_access_key, secret_access_key):
    s3 = boto3.client('s3', aws_access_key_id=public_access_key, aws_secret_access_key=secret_access_key)
    s3.upload_file(data, bucket, data)
    
def submitJob(bucket, data, public_access_key, secret_access_key, myJobName):
    batch = boto3.client('batch', aws_access_key_id=public_access_key, aws_secret_access_key=secret_access_key)
    myJobQueue = 'testqueue'
    myJobDefinition = 'testfngswithtestentrypoint'
    myCommandOverride = [bucket, data]
    myEnvironmentOverride = [{'name':'AWS_ACCESS_KEY_ID', 'value':public_access_key}, {'name':'AWS_SECRET_ACCESS_KEY', 'value':secret_access_key}, {'name':'AWS_DEFAULT_REGION', 'value':'us-east-1'}]
    response = batch.submit_job(jobName=myJobName, jobQueue=myJobQueue, jobDefinition=myJobDefinition, containerOverrides={'command':myCommandOverride, 'environment':myEnvironmentOverride}) 
    return response
    
def checkJobStatus(public_access_key, secret_access_key, jobId):
    batch = boto3.client('batch', aws_access_key_id=public_access_key, aws_secret_access_key=secret_access_key)
    return batch.describe_jobs(jobs=[jobId])['jobs'][0]['status']

def main():
    parser = ArgumentParser(description="This is a test")
    parser.add_argument('--bucket', help='The S3 bucket with the input dataset formatted according to the BIDS standard.')
    parser.add_argument('--credentials', help='AWS formatted csv of credentials.')
    parser.add_argument('--data', help='The data file to upload to the specified S3 bucket')
    result = parser.parse_args()
    
    bucket = str(result.bucket)
    credentials = str(result.credentials)
    data = str(result.data)
    
    credfile = open(credentials, 'rb')
    reader = csv.reader(credfile)
    rowcounter = 0
    for row in reader:
        if rowcounter == 1:
            public_access_key = str(row[0])
            secret_access_key = str(row[1])
        rowcounter = rowcounter + 1
    
    uploadS3(bucket, data, public_access_key, secret_access_key)
    response = submitJob(bucket, data, public_access_key, secret_access_key, "testjob")
    
    jobId = response['jobId']    
    print("JobID = " + jobId)
    while(checkJobStatus(public_access_key, secret_access_key, jobId) != 'SUCCEEDED'):
        pass
    print("Job successful!")
    
    
if __name__ == "__main__":
    main()