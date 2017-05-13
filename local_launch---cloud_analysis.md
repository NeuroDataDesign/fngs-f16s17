## Analysis

Once your data is uploaded onto S3 in BIDs spec and you have completed the tutorial to set up Batch, we are ready for cloud analysis. We will assume the root of your BIDs spec'd data in the S3 bucket is called:

```
bidsdir=<your-root-BIDs-directory>
```
and we have set an environment variable appropriately so that you can replace that with any name as appropriate. We will also set some more variables as follows:

```
bucket=<your-S3-bucket>
jobdir=<your-unique-token> # for querying job status later
```

### Getting and navigating the Docker Container

Next, we will need to pull the docker container. If you don't already have docker installed, see the docker page for details [docker](https://docs.docker.com/engine/installation/). Once you have docker installed, pull the docker container:

```
$ docker pull ericw95/fngs:0.0.7
```

Now, we will enter the docker container. Remember where you placed your access keys from earlier: we assume they will be at "/home/Downloads/accessKeys.csv", but if you placed them somewhere else, be sure to reflect that here:

```
$ docker run -ti --entrypoint /bin/bash -v /home/:/home ericw95/fngs:0.0.7
```

Next, we will run our subjects. Below is an example call:

```
ndmg_cloud participant --bucket bucket --bidsdir bidsdir --jobdir jobdir --credentials /home/Downloads/accessKeys.csv --modality func --stc interleaved
```

The above command will start the cloud deployment process. Once the jobs are complete, the outputs will be placed inside your BIDs root directory on your S3 bucket.
