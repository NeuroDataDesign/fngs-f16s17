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

Now, we will enter the docker container. Remember where you placed your access Keys from earlier: we assume they will be at "/home/<your-user>/Downloads/accessKeys.csv", but if you placed them somewhere else, be sure to reflect that here:

```
$ docker run -ti --entrypoint /bin/bash -v $bidsdir:/data ericw95/fngs:0.0.7
```

Next, we will run our subjects:

```
ndmg_bids /data /data/outputs participant func
```

And your runs will begin.
