## Analysis

Now that your data is all in the cloud and you have your user configured appropriately, the rest is incredibly simple, as all of the manual work has been done.


### Getting and navigating the Docker Container

Next, we will need to pull the docker container. If you don't already have docker installed, see the docker page for details [docker](https://docs.docker.com/engine/installation/). Once you have docker installed, pull the docker container:

```
docker pull ericw95/fngs:0.0.7
```

Now, we will enter the docker container. Remember where you placed your access Keys from earlier: we assume they will be at "/home/<your-user>/Downloads/accessKeys.csv", but if you placed them somewhere else, be sure to reflect that here:

```
docker run -ti --entrypoint /bin/bash -v /home/<your-user>/Downloads:/credentials ericw95/fngs:0.0.7
```

Next, we will configure the AWS CLI, this time for the docker container. Again, it may be helpful to "cat" your access key for this step:

```
cat /credentials/accessKeys.csv
```

and configure the command-line interface appropriately:

```
$ aws configure
AWS Access Key ID [None]: ****your-access-key***********
AWS Secret Access Key [None]: *******your-secret-key*********
Default region name [None]: us-east-1
Default output format [None]:
```

### Deploying your analyses

Now, all that's left to do is click "go" using our deployment utilities:

```
ndmg_cloud participant --bucket <your-bucket-name> --bidsdir <folder-in-bucket> --jobdir /test \
--credentials /credentials/accessKeys.csv --modality func
```
