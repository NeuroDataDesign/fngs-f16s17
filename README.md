Welcome to the FNGS repository! In this markdown, we will go over some strategies for how to use the FNGS webservice effectively for many of the deployment common use-cases users might have. They may include:

+ Local Deployment of the Pipeline on a Local Machine
+ Local Deployment of the Pipeline on the Cloud
+ Website Deployment of the Pipeline on the Cloud
+ Local Deployment of a Simple Demo

Note that for many steps we assume that the user has pre-installed docker, which can be installed following the tutorial provided [by docker](https://docs.docker.com/engine/installation/). 

If you are interested in trying a small-scale demonstration of the FNGS pipeline that takes under five minutes, see the [basic tutorial](#basic-tutorial) for a self-contained, 5 minute tutorial that should give you visualizable results in under 5 minutes (guaranteed with a 3 GHz processor and at least 4 gigs of RAM). 

# Required for all Use-Cases

# Getting Data in the BIDs specification

# Local Deployment of the Pipeline on a Local Machine

# On the Cloud

## Local Cloud Usage

### Getting data into the Cloud

Next, we will need S3 to have the data that we wish to use for processing. To accomplish this, we will use the S3 command line utilities. These can be installed with:

```
$ pip install --upgrade --user awscli
```

Nxt, we will navigate back to our console on AWS. Click the services tab at the top, and click S3:

![image](https://cloud.githubusercontent.com/assets/8883547/25784605/3f9b78ca-333e-11e7-8378-54a99d73fa6a.png)

*NOTE* after this step, AWS will start to bill you for space that you use. For pricing and billing information for S3, see: [AWS billing](https://aws.amazon.com/documentation/account-billing/). The S3 buckets will not be majorly expensive, but any instances you spawn could lead to significant costs if not terminated appropriately.

Create a new buckets will be the bucket in which we will place our data. 

![image](https://cloud.githubusercontent.com/assets/8883547/26030203/c07b302c-3819-11e7-84df-e7f58d1201e9.png)

Your user will already have read and write access to objects and object permissions, so just click through the "nexts" to finalize the bucket.

Click your new bucket, and then click "create folder" along the top. Then, enter a name for your new folder, and click "save".

![image](https://cloud.githubusercontent.com/assets/8883547/26030210/05ae28c0-381a-11e7-820a-147ca99615fa.png)

Now, bring up your terminal window. Type:

```
$ docker pull ericw95/fngs:0.0.7
$ docker run -ti --entrypoint /bin/bash -v </path/to/your/credentials/folder/>/:/credentials -v </path/to/your/bids/data/>:/data ericw95/fngs:0.0.7
```

Next, we need to configure AWS to accept your docker container as a user with your credentials. Type:

```
$ cat /credentials/accessKeys.csv
```

to see your access key id and secret access key. Keep this information ultra-secret! Anybody with these keys can spawn instances and wreak madness on your billing account. AWS is generally relatively nice about these things, but it is still more hassle than it is worth to let these keys get public. Be especially sure to NEVER place these keys in a repository. Not only will AWS kill them as soon as they notice, leaving you with a broken key, but you will also risk somebody finding your keys and spawning instances for their own jobs (a friend just had this happen and received 10k in bills!). So proceed at your own risk. 

Now that you have your access key and secret key in front of you, type the following:

```
$ aws configure
AWS Access Key ID [None]: ****your-access-key***********
AWS Secret Access Key [None]: *******your-secret-key*********
Default region name [None]: us-east-1
Default output format [None]:
```

Noting particularly to make sure the region name says "us-east-1". 

Next, let's check out our bucket. Type the following:

```
$ aws s3 ls
2017-05-07 20:04:50 fngs-test
```

As we can see, the bucket "fngs-test" we made earlier is there. Now, we will upload data to it:

```
$ cd ~/
$ aws sync /data/ s3://fngs-test/DC1-test/ --acl public-read
```

This will upload our data to S3 with the appropriate permissions.

Now, you are ready to analyze your scans on the cloud.

### Launching local cloud analysis

Now that you have data in the cloud on S3, you are ready to deploy your analyses.

*NOTE* after this step, AWS will start to bill you for using EC2 instances. For pricing and billing information for S3, see: [AWS billing](https://aws.amazon.com/documentation/account-billing/). The instances you spawn can be pricey, so make sure to kill them as necessary after your runs have concluded. The amount you will be billed can vary, but if you leave instances running, you can easily rack several thousands of dollars in bills in a small fraction of time. The FNGS team takes no responsibility for any of your AWS billing costs, including when you leave instances running, so be warned. 

Now that we have that disclaimer out of the way, we can get our analysis up and running.

Assuming you are still in your docker container (if you have exited, please reconfigure your instance using the preceving tutorial [Getting data into the Cloud](###getting-data-into-the-cloud)

# Basic Tutorial

In this basic tutorial, we will cover everything that is needed for you to do a basic analysis of your 
