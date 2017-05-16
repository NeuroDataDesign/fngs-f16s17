Welcome to our website cloud deployment tutorial! In this walkthrough, we will cover how to launch your analyses in the cloud, without having to use the command line. We do not assume any requisite software is installed for this tutorial. If you've already setup your AWS account and have Batch and IAM users setup, you can skip to [here](#getting-data-into-bids-spec). 

# Setup of Batch

We assume that the user has set up their AWS account properly. Begin by navigating to the [AWS website](https://aws.amazon.com/), and creating a user as below:

![image](https://cloud.githubusercontent.com/assets/8883547/26090633/4335a568-39d4-11e7-909e-e591bcde33aa.png)

Follow the prompts from AWS, and you should be able to create a free-tier user. 

Next, we need to do some initial configuration of AWS Batch so that the service is available to your user. First, select the console as shown below:

![image](https://cloud.githubusercontent.com/assets/8883547/26090665/750afb7e-39d4-11e7-909a-eff8e90d80aa.png)

Make sure to set your region to N. Virginia, even if you do not actually live there by clicking the dropdown in the top right:

![image](https://cloud.githubusercontent.com/assets/8883547/26090714/b7cc07b4-39d4-11e7-814a-0f432e1b06f2.png)

Click the dropdown for all services, and then select Batch:

![image](https://cloud.githubusercontent.com/assets/8883547/26090687/96142782-39d4-11e7-9852-194089e1fa82.png)

Get started with Batch:

![image](https://cloud.githubusercontent.com/assets/8883547/26090745/e01933d6-39d4-11e7-9ac8-f61b1c3e1764.png)

Click through the getting started guide, following the remainder of the instructions as-per the Amazon Web-Services Website. 
# Creating an IAM User

After this point, we will be assuming that you have created an Amazon AWS account. If not, please navigate to their website and create an account before continuing.

Next, we need to start setting up the AWS cloud services, starting with the creation of a new user. This is because we will need an easy way to access the credentials to deploy jobs under your billing account. This is so that AWS can appropriately bill you for compute hours that you use. To start, type the following address into your address bar:

```
https://console.aws.amazon.com/iam/
```

You should be prompted with a login screen. Put your corresponding information in, and click to sign in. Next, we are going to create an IAM user. Basically, an IAM user is Amazon's secure way to allow you to make a user that has your billing credentials, but so that it can occur in a more restrictive way. AWS also allows root access keys, which grant the priviledge to do anything to you as a user, which is less favorable. You should see the following screen, and then click the boxed-out option below:

![image](https://cloud.githubusercontent.com/assets/8883547/25784042/bcdde53e-3334-11e7-9000-71a8a1abfd71.png)

Click to add a user:

![image](https://cloud.githubusercontent.com/assets/8883547/25784049/e36330ce-3334-11e7-9a6c-3ca9c45ff8e4.png)

Next, fill in appropriate user-name and access type. We want programmatic access, and a user name of your choice. Then, click next:

![image](https://cloud.githubusercontent.com/assets/8883547/25784053/032749d6-3335-11e7-802a-f47b7f896271.png)

Click to create a group on the permissions page:

![image](https://cloud.githubusercontent.com/assets/8883547/25784057/1d9eb33a-3335-11e7-87b7-c8e61d29967c.png)

On the next screen, select administrator access (giving us full control of cloud infrastructure), name your group, and create the group:

![image](https://cloud.githubusercontent.com/assets/8883547/25784065/59565e6e-3335-11e7-8b8d-4c0f97852e0c.png)

Review your choices, and then create your user. Before closing the next box, make sure to download your csv keypair and keep this safe: you will need this for the remainder of our tutorial.

![image](https://cloud.githubusercontent.com/assets/8883547/25784074/958bc806-3335-11e7-9517-987b4bde5136.png)

Great! Now your user is created, and you can continue with the actual deployment portion of the tutorial. For our purposes, note that we will assume that your keypair is found at the following directory:

```
/home/<your-user>/Downloads/accessKeys.csv
```


# Getting Data into BIDs Spec

For these purposes, I have made a small dataset available for us to play around with. First, download the following tarball in your home directory (you can download it anywhere, but we will assume the home directory here):

```
$ cd ~/
$ wget http://openconnecto.me/mrdata/share/demo_data/ndmg_func_cloud_demo.zip
```

And extract it:

```
$ unzip ndmg_func_cloud_demo.zip
```

Next, you should see that you have a folder called "DC1-demo", with the following directory structure:

```
DC1-demo/
  + sub-0027306/
  | + ses-1/
  | | + anat/
  | | | + sub-0027306_ses-1_T1w.nii.gz
  | | + dwi/
  | | | + sub-0027306_ses-1_dwi.nii.gz 
  | | | + sub-0027306_ses-1_dwi.bvec
  | | | + sub-0027306_ses-1_dwi.bval
  | | + func/
  | |   + sub-0027306_ses-1_bold.nii.gz
  | + ses-2/
  | | + anat/
  | | | + sub-0027306_ses-2_T1w.nii.gz
  | | + dwi/
  | | | + sub-0027306_ses-2_dwi.nii.gz 
  | | | + sub-0027306_ses-2_dwi.bvec
  | | | + sub-0027306_ses-2_dwi.bval
  | | + func/
  | |   + sub-0027306_ses-2_bold.nii.gz  
  + sub-0027307/
  ...
  ...
  ...
```

This format is known as the BIDs spec. For more information on how to get your data to conform to the BIDs spec, see the notes from the creators [BIDs](http://bids.neuroimaging.io/). For our purposes, what you can assume is that you must adhere to a naming convention that is similar or identical to the one above, with your own subject names. Note that we don't need the dwi directories and corresponding files here, but we include them so that this tutorial can be used for dwi as well if the user is interested.

We will use this as our BIDs spec'd data hereafter.


# Uploading Data to S3

Next, we will need to upload to S3 the data that we wish to use for processing. To accomplish this, we will use the S3 command line utilities. These can be installed with:

```
$ pip install --upgrade --user awscli
```

Next, we will navigate back to our console on AWS. Click the services tab at the top, and click S3:

![image](https://cloud.githubusercontent.com/assets/8883547/25784605/3f9b78ca-333e-11e7-8378-54a99d73fa6a.png)

*NOTE* after this step, AWS will start to bill you for space that you use. For pricing and billing information for S3, see: [AWS billing](https://aws.amazon.com/documentation/account-billing/). The S3 buckets will not be majorly expensive, but any instances you spawn could lead to significant costs if not terminated appropriately.

Create a new buckets will be the bucket in which we will place our data. 

![image](https://cloud.githubusercontent.com/assets/8883547/25784613/6da97136-333e-11e7-8d5a-ffd148646330.png)

Make sure to give yourself read and write access to objects and object permissions, and finalize the bucket.

![image](https://cloud.githubusercontent.com/assets/8883547/25784645/d26c5bd8-333e-11e7-9545-ef704003f315.png)

Click your new bucket, and then click "create folder" along the top. Then, enter a name for your new folder, and click "save". Note that in the image below, the folder name is "BNUtest", but for the purposes of using our demo data, please name the folder "DC1-demo" instead.

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
$ aws sync DC1-demo/ s3://fngs-test/DC1-demo/ --acl public-read
```

This will upload our data to S3 with the appropriate permissions.

# Setting up AWS Batch

To use the FNGS pipeline on the cloud, we will need to initialize AWS Batch. Type the following into your address bar:

```
https://aws.amazon.com/batch/
```

You may be prompted with a login screen. Put your corresponding information in, and click to sign in. Next, click on "Getting Started":

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/batch1.JPG)

This should take you to your Batch dashboard. Since you've never used Batch before, you will have to go through the first-run wizard to initialize your Batch account. Make sure that you follow the tutorial exactly and don't change any of the default options that the wizard selects for you.

# Using the FNGS Website

We are finally ready to start analyzing data. To use the FNGS website, type the following into your address bar:

```
https://cortex.jhu.edu:8003
```

You should now be on the homepage of the website. This page contains general information about the pipeline. To analyze data, click the "Submit" tab:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/home.JPG)

Fill out the form fields appropriately: 

First select the analysis level you want to perform. This can be either 'participant' or 'group'.

"S3 Bucket Name" is the name of the bucket where your data lives. This bucket should have been created using our instructions on how to properly set up S3 for FNGS.

"BIDS Directory" is the root directory of your BIDs spec'd data on the S3 bucket. If performing participant level analysis, this folder should have all the desired raw data (for example, the BIDS directory of the FNGS-provided demo data is DC1-demo). If performing group level analysis, this directory should contain the outputs of the participant level analysis (for example, after performing participant analysis on the demo data, the BIDS directory for group analysis becomes DC1-demo/ndmg_0-0-49).

"Unique Token" is any personalized unique identifier that you can later use to query information about your jobs. It's basically like your "password" for accessing information about the jobs that you submit. Try to make this as unique as possible so as to avoid possible conflicts with other users.

"AWS Credentials File" is the CSV file containing your user's access keys. Make sure you obtain these keys in the correct manner, according to our instructions on setting up an AWS user.

"Dataset Name" is the name of your dataset (used only for group analysis). For example, for the FNGS-provided demo data, this would be DC1.

"Modality" is the modality of your data. This can be either "functional" or "DWI".

"Slice Timing Method" is the manner in which the brain data slices were acquired through the fMRI scanner (used only for participant level functional analysis). The choices are none, bottom up, top down, and interleaved. 

The website also offers functionality to upload data directly through the website. To do so, you must upload a .zip of your BIDs spec'd data at the root level. For example, for the FNGS-provided demo data, the first folder inside the zip file is DC1-demo, which is the BIDS directory. If using this feature, make sure you fill in the "BIDS Directory" and "S3 bucket" field correctly. If you select the option to upload data, the website will upload the contents of the zip file to the specified S3 bucket, and will continue analysis by looking for the specified BIDS directory. So, please make sure the BIDS directory that is specified has the same name as the root folder inside the submitted zip file.

NOTE: We ask that you limit your zip sizes to 2GB in size. If your data is larger than this, you will have to upload your data to S3 using our previous instructions outlining how to do so.

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/submit1.JPG)

To start analyzing, click the "Submit Job" button. Once your data is analyzed, the outputs can be found in your specified S3 bucket, inside the specified BIDs directory root. You will see a new folder called "ndmg_0-0-49" with all your outputs.

NOTE: Click the "Submit Job" button exactly once. Once clicked, do not interfere with the page in any way. You might have to wait a bit before the page registers, especially if you choose to upload data directly.

We can also use the website to glean information about previously submitted jobs. Click the "Query" tab:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/submit2.JPG)

Here, we can do one of two things: either get the status of a job, or kill a job. To do either, simply select the option from the dropdown menu, and enter the same unique token that you used when submitting the job. Be sure to also upload your credentials CSV file:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/query.JPG)

Upon clicking "Submit Query", the page should refresh and you should see the requested information below the form.

Once your data is analyzed, the outputs can be found in your specified S3 bucket, inside the specified BIDs directory root. For example, to navigate to my bucket "fngstestbucket", I would type the following into my address bar:

```
https://console.aws.amazon.com/s3/buckets/fngstestbucket/
```

This will take me to the following page, which is the root of my bucket:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/getoutputs1.jpg)

From here, I click on my BIDS directory to get to the following page:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/getoutputs2.jpg)

Clicking the above folder takes me to my outputs!

That about wraps it up for this tutorial. You should now be well equipped to use the FNGS web service to analyze your data.
