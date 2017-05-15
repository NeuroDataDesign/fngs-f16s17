Welcome to our local cloud tutorial! In this walkthrough, we will cover what is required to go step-by-step through getting your BIDs spec'd data onto the could, so that you can launch your analyses in the cloud from the command line. 

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

# Pulling the Docker Container

# Setting up IAM User

# Getting Data onto S3 Manually

# Running Docker Container
