# fngs

# Methods

![Schematic](https://neurodatadesign.github.io/fngs/ewalke31/tutorials/week_0410/img/schematic.png)

For a single subject, the pipeline is to be provided with the path to a 4d (fMRI) image, the path to a 3d (anatomical) image, the path to a reference atlas, the path to a reference atlas w/ brain extracted, the path to a reference brain mask, the path to the lateral ventricles mask, a list of labels files, the base output directory to place outputs, a flag whether or not to clean out directories once finished (defaults to False), slice timing arguments (defaults to None), and the format for produced graphs (either gpickle or graphml, defaults to gpickle).

## Preprocessing

During the first step of preprocessing, if slice timing arguments were provided, slice timing correction occurs. Valid slice timing correction arguments include a path to a single-column file listing TR shifts per slice where a value of 0.5 corresponds to no shift and valid values range from 0 to 1 inclusive, the strings 'up' or 'down' indicating slice indexing direction (defaults to 'up'), or the string 'interleaved' indicating the slices are interleaved. The fMRI image volume is then run through FSL's slicetimer command with the appropriate options. Slice timing correction occurs via Hanning-windowed sinc interpolation used to independently shift each voxel's timeseries by an appropriate fraction of a TR relative to the middle of the TR period. The fMRI image volume then undergoes motion correction using MCFLIRT, where it is self-aligned to a specified index (currently the zero slice) or is self-aligned to the mean volume if no index is specified. MCFLIRT works by registering the brain scan at each timestep to the reference scan using FLIRT, which works by applying combinations of transformations (rigid transformations such as rotations and translations in the case of MCFLIRT) to the input brain scan in order to minimize a cost function (which measures the similarity between the input and reference brain scans, defaults to normcorr in the case of MCFLIRT) until it reaches a global optimum, finding the best fit in an 8mm search grid.

## Registration

## Nuisance Correction

## Timeseries Extraction

# Tutorial

![Flowchart](https://neurodatadesign.github.io/fngs/02agarwalt/project1/week_0327/flowchart5.jpeg)

## Getting the Pipeline Running

[Using the Pipeline Only](#pipeline)  

First, we will pull the docker container from dockerhub:
```
$ docker pull ericw95/fngs:0.0.3
```

Next, we want to enter the docker container, making sure to specify that we want to enter to a terminal session (ie, we want a bash shell; we do NOT want to use the default entrypoint, which is a script!). Also, we note that ew might want to pass data, or run the demo. For demo purposes, the script runs and analyzes using the tmp/ directory of the computer, so to visualize our results afterwards, we will want to call as follows:
```
$ docker run -ti --entrypoint /bin/bash -v /tmp:/tmp ericw95/fngs:0.0.3
```
What this does is essentially provides a link between the /tmp directory and our local machine with the /tmp directory of our docker container. This means that any outputs placed here by the docker container will be in the /tmp folder on the local machine as well.

Next, we will have a terminal session. From here, just type:

```
$ ndmg_demo_func
```

and you will see that the data is automatically downloaded and unpacked from openconnecto.me (along with all dependencies), and begins to run.

## Outputs:

### Preprocessing

Next, we will look at some motion statistics. These correspond to the motion parameters used by MCFLIRT for motion-realignment



## Motion QA

[displacement mc](https://neurodatadesign.github.io/fngs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/reg/func/preproc/sub-0025864_session-1_bold_small_mc_disp.html)
[rotational mc](https://neurodatadesign.github.io/fngs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/reg/func/preproc/sub-0025864_session-1_bold_small_mc_rot.html)
[translational mc](https://neurodatadesign.github.io/fngs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/reg/func/preproc/sub-0025864_session-1_bold_small_mc_trans.html)

## Registration QA

### Self Reg

![self-alignment](https://github.com/NeuroDataDesign/fngs/blob/master/docs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/reg/func/align/self/final_score_817/sub-0025864_session-1_bold_small_preproc_self-aligned.png)

### Template Reg
![temp-alignment](https://github.com/NeuroDataDesign/fngs/blob/master/docs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/reg/func/align/temp/final_score_857/sub-0025864_session-1_bold_small_aligned.png)
![cnr](https://github.com/NeuroDataDesign/fngs/blob/master/docs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/reg/func/align/temp/final_score_877/sub-0025864_session-1_bold_small_aligned_cnr.png)
![snr](https://github.com/NeuroDataDesign/fngs/blob/master/docs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/reg/func/align/temp/final_score_877/sub-0025864_session-1_bold_small_aligned_snr.png)
![bet quality](https://github.com/NeuroDataDesign/fngs/blob/master/docs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/reg/func/align/temp/final_score_877/sub-0025864_session-1_bol_smalld_preproc_temp-aligned_nonlinear_bet_quality.png)

## Timesries QA
### Labelled tlas alignment
![atlas](https://github.com/NeuroDataDesign/fngs/blob/master/docs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/ts_roi/desikan-4mm/sub-0025864_session-1_T1w_small_aligned.png)

### Timeseries
[timeseries](https://neurodatadesign.github.io/fngs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/ts_roi/desikan-4mm/sub-0025864_session-1_bold_small_desikan-4mm_timeseries.html)

### Connectome
![aal-atlas-connectome](https://github.com/NeuroDataDesign/fngs/blob/master/docs/ebridge2/fngs_documentation/week_0410/sub-0025864_session-1_bold_small/ts_roi/desikan-4mm/sub-0025864_session-1_bold_small_desikan-4mm_corr.png)
