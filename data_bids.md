
## Getting Data in BIDs spec

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
