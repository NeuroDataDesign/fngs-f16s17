## Analysis

Now that your data is in the BIDs spec, we are ready for local analysis. We will assume the root of your BIDs spec'd data is at:

```
bidsdir=/home/<your-user>/data/<dataset>
```
and we have set an environment variable appropriately so that you can replace that with any of your local directory of choice. 

### Getting and navigating the Docker Container

Next, we will need to pull the docker container. If you don't already have docker installed, see the docker page for details [docker](https://docs.docker.com/engine/installation/). Once you have docker installed, pull the docker container:

```
$ docker pull ericw95/fngs:0.0.7
```

Now, we will enter the docker container:

```
$ docker run -ti --entrypoint /bin/bash -v $bidsdir:/data ericw95/fngs:0.0.7
```

Next, we will run our subjects. We will be using the "ndmg_bids" program, which takes in four arguments: input path, output path, analysis level, and modality. Calling the command below will perform participant level analysis on the functional data in your "bidsdir" path, and store the outputs in a newly created folder inside your "bidsdir" path:

```
ndmg_bids /data /data/outputs participant func
```

Your runs will now begin. Once the runs are complete, you will be able to find the outputs in /data/outputs, as specified.
