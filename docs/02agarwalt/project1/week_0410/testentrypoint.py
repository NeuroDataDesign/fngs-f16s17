import os
import boto3
from argparse import ArgumentParser
import csv
import sys
sys.path.insert(0, '../')

if __name__ == "__main__":
    bucket = sys.argv[1]
    data = sys.argv[2]
    
    s3 = boto3.client('s3')
    s3.download_file(bucket, data, data)
    with open(data, "r") as f:
        outputFile = open("testdataoutput.txt", "w")
        outputFile.write(str(f.readline()) + " hello world")
        outputFile.close()
    key = "testdataoutput.txt"
    s3.upload_file("testdataoutput.txt", bucket, key)
    
    