## Analysis

Once your data is uploaded onto S3 in BIDs spec and you have completed the tutorial to set up Batch, we are ready for cloud analysis.

### Getting and navigating the Docker Container

Next, we will need to pull the docker container. If you don't already have docker installed, see the docker page for details [docker](https://docs.docker.com/engine/installation/). Once you have docker installed, pull the docker container:

```
$ docker pull ericw95/fngs:0.0.7
```

Now, we will enter the docker container. Remember where you placed your access keys from earlier: we assume they will be at "/home/Downloads/accessKeys.csv", but if you placed them somewhere else, be sure to reflect that here:

```
$ docker run -ti --entrypoint /bin/bash -v /home/:/home ericw95/fngs:0.0.7
```

Next, we will run our subjects. We will use the "ndmg_cloud" program, which requires several arguments. Below is a template call, followed by explanations of the arguments:

```
ndmg_cloud <analysis-level> --bucket <bucket> --bidsdir <bidsdir> --jobdir <jobdir> --credentials <creds> --modality <mod> --stc <stc> --dataset <dataset-name>
```

<analysis-level> is the analysis level you want to perform. This can be either 'participant' or 'group'.

<bucket> is the name of the S3 bucket where your data lives. This bucket should have been created using our instructions on how to properly set up S3 for FNGS.

<bidsdir> is the root directory of your BIDs spec'd data on the S3 bucket. If performing participant level analysis, this folder should have all the desired raw data (for example, the BIDS directory of the FNGS-provided demo data is DC1-demo). If performing group level analysis, this directory should contain the outputs of the participant level analysis (for example, after performing participant analysis on the demo data, the BIDS directory for group analysis becomes DC1-demo/ndmg_0-0-49).

<jobdir> is any personalized unique identifier that you can later use to query information about your jobs. It's basically like your "password" for accessing information about the jobs that you submit. Try to make this as unique as possible so as to avoid possible conflicts with other users.

<creds> is the CSV file containing your user's access keys. Make sure you obtain these keys in the correct manner, according to our instructions on setting up an AWS user.

<dataset-name> is the name of your dataset (used only for group analysis). For example, for the FNGS-provided demo data, this would be DC1.

<mod> is the modality of your data. This can be either "functional" or "DWI".

<stc> is the slice-timing method, or the manner in which the brain data slices were acquired through the fMRI scanner (used only for participant level functional analysis). The choices are none, bottom up, top down, and interleaved.

Below is an example call for participant level analysis:

```
ndmg_cloud participant --bucket bucket --bidsdir bidsdir --jobdir jobdir --credentials /home/Downloads/accessKeys.csv --modality func --stc interleaved
```

The above command will start the cloud deployment process. Once the jobs are complete, the outputs will be placed inside your BIDs root directory on your S3 bucket.
