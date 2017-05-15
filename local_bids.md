Welcome to our local bids tutorial! In this tutorial, we will cover how to run the pipeline on a BIDs-spec'd directory on a local machine using the FNGS Docker container. 

# Getting Data in BIDs Spec

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

# Analyzing Data

We are now ready to start analyzing data using FNGS. To do so, we will first need to pull the docker container. If you don't already have docker installed, see the docker page for details [docker](https://docs.docker.com/engine/installation/). Once you have docker installed, pull the docker container:

```
$ docker pull ericw95/fngs:0.0.7
```

Now, we will enter the docker container.

```
$ docker run -ti --entrypoint /bin/bash -v /home/:/home ericw95/fngs:0.0.7
```

Next, we will run our subjects. We will use the "ndmg_bids" program, which requires several arguments. Below is a template call, followed by explanations of the arguments:

```
ndmg_bids <analysis-level> --bucket <bucket> --bidsdir <bidsdir> --jobdir <jobdir> --credentials <creds> --modality <mod> --stc <stc> --dataset <dataset-name>
```

"analysis-level" is the analysis level you want to perform. This can be either 'participant' or 'group'.

"bucket" is the name of the S3 bucket where your data lives. This bucket should have been created using our instructions on how to properly set up S3 for FNGS.

"bidsdir" is the root directory of your BIDs spec'd data on the S3 bucket. If performing participant level analysis, this folder should have all the desired raw data (for example, the BIDS directory of the FNGS-provided demo data is DC1-demo). If performing group level analysis, this directory should contain the outputs of the participant level analysis (for example, after performing participant analysis on the demo data, the BIDS directory for group analysis becomes DC1-demo/ndmg_0-0-49).

"jobdir" is any personalized unique identifier that you can later use to query information about your jobs. It's basically like your "password" for accessing information about the jobs that you submit. Try to make this as unique as possible so as to avoid possible conflicts with other users.

"creds" is the CSV file containing your user's access keys. Make sure you obtain these keys in the correct manner, according to our instructions on setting up an AWS user.

"dataset-name" is the name of your dataset (used only for group analysis). For example, for the FNGS-provided demo data, this would be DC1.

"mod" is the modality of your data. This can be either "functional" or "DWI".

"stc" is the slice-timing method, or the manner in which the brain data slices were acquired through the fMRI scanner (used only for participant level functional analysis). The choices are none, bottom up, top down, and interleaved.

Below is an example call for participant level analysis on the FNGS-provided demo data:

```
ndmg_cloud participant --bucket fngstestbucket --bidsdir DC1-demo --jobdir demo1234 --credentials /home/Downloads/accessKeys.csv --modality func --stc interleaved
```

The above command will start the cloud deployment process. Once your data is analyzed, the outputs can be found in your specified S3 bucket, inside the specified BIDs directory root. You will see a new folder called "ndmg_0-0-49" with all your outputs.

Once the participant level analysis is complete, you can also run group level analysis. Below is an example call for our demo data:

```
ndmg_cloud group --bucket fngstestbucket --bidsdir DC1-demo/ndmg_0-0-49 --jobdir demo1234 --credentials /home/Downloads/accessKeys.csv --modality func --stc None --dataset DC1
```
We can also obtain information about our submitted jobs. Using "ndmg_cloud", we can either get the status of jobs or kill them. Below is the template for queries:

```
ndmg_cloud <query-type> --jobdir <jobdir> --credentials <creds>
```

"query-type" is the action you want to perform. This can be "status" or "kill".

"jobdir" is the unique identifier you used when submitting the jobs.

"creds" is your AWS credentials file.

Below is an example call to kill our previously created jobs:

```
ndmg_cloud kill --jobdir demo1234 --credentials /home/Downloads/accessKeys.csv
```

The above query will print the relevant information to your terminal screen.

That about wraps it up for this tutorial. You should now be well equipped to use the FNGS docker container to analyze your data.

