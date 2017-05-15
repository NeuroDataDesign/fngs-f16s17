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

Now that your data is in the BIDs spec, we are ready for local analysis. We will assume the root of your BIDs spec'd data is at:

```
bidsdir=/home/<your-user>/data/<dataset>
```

and we have set an environment variable appropriately so that you can replace that with any of your local directory of choice.

We are now ready to start analyzing data using FNGS. To do so, we will first need to pull the docker container. If you don't already have docker installed, see the docker page for details [docker](https://docs.docker.com/engine/installation/). Once you have docker installed, pull the docker container:

```
$ docker pull ericw95/fngs:0.0.7
```

Now, we will enter the docker container.

```
$ docker run -ti --entrypoint /bin/bash -v $bidsdir:/data ericw95/fngs:0.0.7
```

Next, we will run our subjects. We will use the "ndmg_bids" program, which requires several arguments. Below is a template call, followed by explanations of the arguments:

```
ndmg_bids <input-dir> <output-dir> <analysis-level> <modality> --stc <stc> --atlas <atlas>
```

"input-dir" is the root directory of your BIDs spec'd data. If performing participant level analysis, this folder should have all the desired raw data (for example, the BIDS directory of the FNGS-provided demo data is DC1-demo). If performing group level analysis, this directory should contain the outputs of the participant level analysis.

"output-dir" is the directory where we want the outputs to be stored.

"analysis-level" is the analysis level you want to perform. This can be either 'participant' or 'group'.

"modality" is the modality of your data. This can be either "functional" or "DWI".

"stc" is the slice-timing method, or the manner in which the brain data slices were acquired through the fMRI scanner (used only for participant level functional analysis). The choices are none, bottom up, top down, and interleaved.

"atlas" is the specific atlas you want to use (only for group analysis). The choices are "aal-2mm", "brodmann-2mm", "desikan-2mm", "pp264-2mm", and "HarvardOxford-cort-maxprob-thr25-2mm".

Below is an example call for participant level analysis. Note that when entering the Docker container, we mapped the "bidsdir" path to "/data" inside the container:

```
ndmg_bids /data /data/outputs participant func --stc interleaved
```

The above command will start the analysis process. Once your data is analyzed, the outputs can be found in your specified output folder.

Once the participant level analysis is complete, you can also run group level analysis. Below is an example call that follows from our previous participant level analysis:

```
ndmg_bids /data /data/outputs group func --atlas aal-2mm
```

Once the group analysis is complete, you will be able to see the outputs in the specified output folder.

That about wraps it up for this tutorial. You should now be well equipped to use the FNGS docker container to analyze your data.

