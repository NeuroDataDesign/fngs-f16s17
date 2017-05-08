# FNGS Cloud Tutorial

## Deployment Setup

### Getting Data in BIDs spec

Next, we will go through the deployment phase of beginning a job. For these purposes, I have made a small dataset available for us to play around with. First, download the following tarball in your home directory (you can download it anywhere, but we will assume the home directory here):

```
$ cd ~/
$ wget http://openconnecto.me/mrdata/share/demo_data/ndmg_func_cloud_demo.tar.gz
```

And extract it:

```
$ tar -xvzf ndmg_func_cloud_demo.tar.gz
```

Next, you should see that you have a folder called "BNUtest", with the following directory structure:

```
BNUtest/
  + sub-0025864/
  | + ses-1/
  | | + anat/
  | | | + sub-0025865_ses-1_T1w.nii.gz
  | | + dwi/
  | | | + sub-0025865_ses-1_dwi.nii.gz 
  | | | + sub-0025865_ses-1_dwi.bvec
  | | | + sub-0025865_ses-1_dwi.bval
  | | + func/
  | |   + sub-0025865_ses-1_bold.nii.gz
  | + ses-1/
  | | + anat/
  | | | + sub-0025865_ses-1_T1w.nii.gz
  | | + dwi/
  | | | + sub-0025865_ses-1_dwi.nii.gz 
  | | | + sub-0025865_ses-1_dwi.bvec
  | | | + sub-0025865_ses-1_dwi.bval
  | | + func/
  | |   + sub-0025865_ses-1_bold.nii.gz  
  + sub-0025865/
  | + ses-1/
  | | + anat/
  | | | + sub-0025865_ses-1_T1w.nii.gz
  | | + dwi/
  | | | + sub-0025865_ses-1_dwi.nii.gz 
  | | | + sub-0025865_ses-1_dwi.bvec
  | | | + sub-0025865_ses-1_dwi.bval
  | | + func/
  | |   + sub-0025865_ses-1_bold.nii.gz
```

This format is known as the BIDs spec. For more information on how to get your data to conform to the BIDs spec, see the notes from the creators [BIDs](http://bids.neuroimaging.io/). For our purposes, what you can assume is that you must adhere to a naming convention that is similar or identical to the one above, with your own subject names. Note that we don't need the dwi directories and corresponding files here, but we include them so that this tutorial can be used for dwi as well if the user is interested.

We will use this as our BIDs spec'd data hereafter.

### Uploading Data to S3

Next, we will need S3 to have the data that we wish to use for processing. To accomplish this, we will use the S3 command line utilities. These can be installed with:

```
$ pip install --upgrade --user awscli
```

Nxt, we will navigate back to our console on AWS. Click the services tab at the top, and click S3:

![image](https://cloud.githubusercontent.com/assets/8883547/25784605/3f9b78ca-333e-11e7-8378-54a99d73fa6a.png)

*NOTE* after this step, AWS will start to bill you for space that you use. For pricing and billing information for S3, see: [AWS billing](https://aws.amazon.com/documentation/account-billing/). The S3 buckets will not be majorly expensive, but any instances you spawn could lead to significant costs if not terminated appropriately.

Create a new buckets will be the bucket in which we will place our data. 

![image](https://cloud.githubusercontent.com/assets/8883547/25784613/6da97136-333e-11e7-8d5a-ffd148646330.png)

Make sure to give yourself read and write access to objects and object permissions, and finalize the bucket.

![image](https://cloud.githubusercontent.com/assets/8883547/25784645/d26c5bd8-333e-11e7-9545-ef704003f315.png)

Click your new bucket, and then click "create folder" along the top. Then, enter a name for your new folder, and click "save".

![image](https://cloud.githubusercontent.com/assets/8883547/25784657/07088dee-333f-11e7-8da2-635e8c17c56a.png)

Now, bring up your terminal window. Type:

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
$ aws sync BNUtest/ s3://fngs-test/BNUtest/
```

This will upload our data to S3.

### Getting and navigating the Docker Container

Next, we will need to pull the docker container. If you don't already have docker installed, see the docker page for details [docker](https://docs.docker.com/engine/installation/). Once you have docker installed, pull the docker container:

```
docker pull ericw95/fngs:0.0.7
```

Now, we will enter the docker container. Remember where you placed your access Keys from earlier: we assume they will be at "/home/<your-user>/Downloads/accessKeys.csv", but if you placed them somewhere else, be sure to reflect that here:

```
docker run -ti --entrypoint /bin/bash -v /home/<your-user>/Downloads:/credentials ericw95/fngs:0.0.7
```

Next, we will configure the AWS CLI, this time for the docker container:

```
$ aws configure
AWS Access Key ID [None]: ****your-access-key***********
AWS Secret Access Key [None]: *******your-secret-key*********
Default region name [None]: us-east-1
Default output format [None]:
```

Now, you are ready to analyze your scans. 

## Analysis

