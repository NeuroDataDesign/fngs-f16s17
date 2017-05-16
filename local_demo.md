In this demo, we will walkthrough the basic single-scan demonstration of the pipeline. This tutorial uses a downsampled dataset at 4mm resolution, so outputs will be worse than the 2mm registration of the normal pipeline, but the outputs are good enough to give users a feel for how each step should work, while offering outputs in just 5 minutes time. We assume that the user has installed docker, which can be installed following the [installation guide](https://docs.docker.com/engine/installation/). 

# Pulling the Docker Container

To begin, pull the FNGS docker container:

```
$ docker pull ericw95/fngs:0.0.7
```

# Running the Mini-Demo

Next, we will enter the docker container, passing in our "tmp" directory so that the outputs of our demo will be available to the user:

```
$ docker run -ti --entrypoint /bin/bash -v /tmp:/tmp ericw95/fngs:0.0.7
```

The outputs of our mini-demo will be placed in the tmp directory, so offering our tmp directory locally to the docker container will let us find our outputs once we have run the mini-demo. Next, type the following line into your docker container:

```
root@12318$ ndmg_demo_func
```

And the mini-demo data will be downloaded (requiring an internet connection) and then analyzed locally. 

# Viewing your Results

Here, we will walk through some of the quality control images, so the user can get comfortable with our output format. 

First navigate to the directory in a new terminal window (different from the one with the docker container open in it) and go to your tmp directory:

```
$ cd /tmp/ndmg_demo_func/outputs
$ ls
connectomes  nuis  qa  reg  tmp  ts_roi  ts_voxel
$ cd qa/sub-0025864_session-1_bold_small/
```

These are the basic output folders produced by the FNGS pipeline. You can find the derivatives yourselves, but here we will take a look at some qa images. We assume the user has 'xdg-open' installed to open pngs and html images. 


For motion correction qa, we may want to take a look at the motion parameters estimated:
```
$ xdg-open /func/preproc/sub-0025864_session-1_bold_small_mc_rot.html 
```

![image](https://cloud.githubusercontent.com/assets/8883547/26093844/7f2a2268-39e5-11e7-8da2-d73abb3b59b5.png)

For registration, we may wish to examine the overlap of our registered image with our template:

```
$ xdg-open reg/func/align/temp/final_score_868/sub-0025864_session-1_bold_small_aligned.png
```

![image](https://cloud.githubusercontent.com/assets/8883547/26093905/bfd60354-39e5-11e7-9f76-fc185b17bc1f.png)

Here, we want to see that our registered image in green is approximately overlapping with the brain portion of our template in purple.

For nuisance correction, we may want to look at the CNR:

```
$ xdg-open ts_voxel/sub-0025864_session-1_bold_small_nuis_cnr.png 
```

![image](https://cloud.githubusercontent.com/assets/8883547/26093956/f4b722ce-39e5-11e7-99cd-52385d1f2140.png)

Our brain at this point has been mean centered, so while we would not expect the image itself in a nifti viewer to look special, we should still retain signal. The CNR measures the contrast to noise ratio over time, so we expect that the brain regions are still heavily distinguishable from the background.

Finally, we may want to check out some of our downsample timeseries. First, we will check how well the atlas overlapped with our nuisance-corrected voxel timecourse:

```
$ xdg-open ts_roi/desikan-4mm/sub-0025864_session-1_T1w_small_aligned.png
```
![image](https://cloud.githubusercontent.com/assets/8883547/26094042/52d077b6-39e6-11e7-9bff-c63c9d4dba9f.png)

and we should see that the purple parcellation overlaps well with our registered T1w brain.

Next, we may want to look at the timeseries:

```
$ xdg-open ts_roi/desikan-4mm/sub-0025864_session-1_bold_small_desikan-4mm_timeseries.html
```

![image](https://cloud.githubusercontent.com/assets/8883547/26094316/7c2ff68a-39e7-11e7-96a9-cfd43390bcea.png)


where we want to see that we have retained our periodic HRFs. 

Finally, we want to see the correlation matrix:

```
$ xdg-open ts_roi/desikan-4mm/sub-0025864_session-1_bold_small_desikan-4mm_corr.png
```
![image](https://cloud.githubusercontent.com/assets/8883547/26094259/3c90952a-39e7-11e7-86be-c256f1c2c120.png)



the pattern observed here will be highly dependent on the parcellation chosen.
