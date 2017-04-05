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
[Building the Docker Container](#building)  
[Pulling the Existing Docker Container](#pulling)  
[Running the Web Service](#webserver)  

NOTE: If you are in the NeurodataDesign class, I would recomment doing the "Building the Docker container" tutorial. 

<a name="pipeline"></a>
### Pipeline Use
```
$ git clone https://github.com/ebridge2/FNGS_website.git
$ cd FNGS_website
$ docker build --no-cache -t <your-handle>/fngs .

# -v argument allows your container to use data that is only available locally. Ie, in this case, the data in
# /local/path/to/your/data/ would be visible inside the docker container at /data
$ docker run -ti -v /local/path/to/your/data/:/data --entrypoint /bin/bash <your-handle>/fngs
# otherwise, you can just skip the -v flag entirely if you plan to use the demo data
$ docker run -ti --entrypoint /bin/bash <your-handle>/fngs

# takes you into the docker container
$ cd /ndmg/ndmg/scripts/
# runs the demo
$ ./ndmg_demo-func.sh
```

<a name="building"></a>
### Building Docker Container for Web Use

Note that this guide is very similar to the preceeding guide, except now we need to forward ports when we use the docker container.
```
$ git clone https://github.com/ebridge2/FNGS_website.git
$ cd FNGS_website
$ docker build --no-cache -t <your-handle>/fngs .

$ docker run -ti -p <portnum>:8000 <your-handle>/fngs

System check identified some issues:

WARNINGS:
?: (urls.W001) Your URL pattern '^$' uses include with a regex ending with a '$'. Remove the dollar from the regex to avoid problems including URLs.

System check identified 1 issue (0 silenced).
December 07, 2016 - 20:33:52
Django version 1.10.4, using settings 'fngs.settings'
Starting development server at http://localhost:8000/ # NOTE: this is NOT the actual web address. This is the host local web address
Quit the server with CONTROL-C.

# Note: if you are on cortex, your address will be cortex.jhu.edu:<port-num>.
# if you are only deploying locally, your address will be 
0.0:<port-num>.
# proceed to tutorial below about setting up the server
```

<a name="pulling"></a>
### Pulling Docker Container from Remote
```
$ docker pull ericw95/fngs:0.1.1

# from the host system with the docker container properly working
$ docker run -ti -p <portnum>:8000 ericw95/fngs:0.1.1

System check identified some issues:

WARNINGS:
?: (urls.W001) Your URL pattern '^$' uses include with a regex ending with a '$'. Remove the dollar from the regex to avoid problems including URLs.

System check identified 1 issue (0 silenced).
December 07, 2016 - 20:33:52
Django version 1.10.4, using settings 'fngs.settings'
Starting development server at http://localhost:8000/ # NOTE: this is NOT the actual web address. This is the host local web address
Quit the server with CONTROL-C.
# navigate to the IP of your host, and type host_IP:port 

# Note: if you are on cortex, your address will be cortex.jhu.edu:<port-num>.
# if you are only deploying locally, your address will be 0.0.0.0:<port-num>.
# proceed to tutorial below about setting up the server
```
<a name="local"></a>
### Local Setup Tutorial

Note that in order for this to work, you need to have FSL version 0.5.9 configured on your local machine (non-intuitive for non Red Hat distributions). This path is not recommended unless you have experience installing FSL on non-RH Linux distributions. 

```
$ git clone https://github.com/neurodata/ndmg.git
$ cd ndmg/
$ python setup.py install
$ cd ndmg/scripts
# confirm that the pipeline runs without error
$ ./ndmg_demo-func.sh

$ cd ../../../
$ git clone git@github.com:ebridge2/FNGS_website.git /desired/path

$ mkdir /FNGS_server # the server expects this directory
$ cd /FNGS_server
$ wget http://openconnecto.me/mrdata/share/demo_data/less_small_atlases.zip
$ unzip less_small_atlases.zip # puts atlases we expect to have in the correct spot

$ cd /desired/path/FNGS_website/fngs
$ python manage.py runserver (desired_ip):<port_num>

```
<a name="webserver"></a>
## Website Tutorial
This tutorial requires around 4-6 gigs of ram. 
Following the link given by the service will take you to the home page:
![FNGS Homepage](https://cloud.githubusercontent.com/assets/8883547/20985816/12fabc48-bc94-11e6-90d8-d74aa0e1bf70.png)
Click the link above to take you to the "Analyze" Tab.

Let's run through a quick demonstration of how the web service can be used with a real example. You should see that no datasets are available for viewing. To begin, let's click the add-dataset button. 
![Add Dataset](https://cloud.githubusercontent.com/assets/8883547/20985885/5a9c76d6-bc94-11e6-9233-40a213f95f38.png)

I've added some text for the Dataset's ID as well as the collection site name. Once we've added this information, add the dataset.
![Add new dataset](https://cloud.githubusercontent.com/assets/8883547/20985939/91cdee96-bc94-11e6-964f-5418486149dc.png)

Next, let's upload a subject for analysis:
![Add subject](https://cloud.githubusercontent.com/assets/8883547/20985966/ae843946-bc94-11e6-9bfa-2e299a859e6b.png)

Before we add any information here, let's return to a new terminal window and download some demo data.

```
cd /tmp/
$ wget http://openconnecto.me/mrdata/share/demo_data/ndmg_demo.zip # this might take a few seconds to download
$ unzip ndmg_demo.zip
```
This gives us a subject's worth of DTI and fMRI data to play around with. I chose subject 0025864, scan 1, for this demo. As you can see, we will need to include the functional scan and the structural scan, which can be found at the path "/tmp/full_func/BNU1/sub-0025864/session-1/func/sub-0025864_session-1_bold.nii.gz" and "/tmp/full_func/BNU1/sub-0025864/session-1/anat/sub-0025864_session-1_T1w.nii.gz" respectively  (assuming you downloaded the .zip file to the /tmp/ directory):

![Choosing Functional Scan](https://cloud.githubusercontent.com/assets/8883547/21088391/9543aee2-bffc-11e6-89c4-0d9e42adcd80.png)
![Choosing Anatomical Scan](https://cloud.githubusercontent.com/assets/8883547/21088401/b6c6d6ca-bffc-11e6-912d-f3281e7b88ab.png)
![Choosing DTI Image](https://cloud.githubusercontent.com/assets/8883547/21088425/db91b70e-bffc-11e6-974e-9b55d3eaa5c7.png)
![Choosing Bvalues file](https://cloud.githubusercontent.com/assets/8883547/21088432/ea95033c-bffc-11e6-861c-1edd2690bc49.png)
![Choosing DTI bvecs file](https://cloud.githubusercontent.com/assets/8883547/21088437/f8d4e80e-bffc-11e6-8a3d-65cceaee09f1.png)

Note that I also went ahead and selected the Structural scan type (T1w) and the Slice Timing Method (Interleaved). Information about the structural scan type is necessary to ensure that when we segment our anatomical image into different brain tissues for nuisance correction, we know what sorts of intensities to look for (ie, white matter looks different in T1w than T2w). Slice timing acquisition is a measure of the acquisition sequence in which the image is acquired. This is unique to the individual dataset, so see the dataset release information if you are not sure which to choose (or, just leave this blank and select "None" in which slice timing correction will not be performed). 

Finally, once you have the entire form filled out, click to add the subject, and wait a few seconds while the upload commences (should take approximately one minute). If you add any information wrong, just delete the subject and readd (haven't gotten editing in the site yet; it's easy for the user-defined fields, not as easy for the file paths, but that seemed past minimally viable). 

Note that the web service does not yet have a queuing system, so the next steps require care when uploading your scans for analysis. Take great care not to click the analyze button twice (before the previous analysis is completed and the results are vieweable and downloadable) or delete while an analysis is taking place. This is because the lack of a queuing system means that jobs are just spawned in process modules (a naive, short term solution), so processes are run disconnected from the python session, and analyzing again will spawn new processes over the existing ones (leading to processes being overallocated, and probably crashing the program), and in the case of deletes, leading to processes spontaneously crashing (and probably also crashing the program). Additionally, there is not yet a feature to update your subjects after you upload the data, so if you upload something mistakenly, just delete it and start over. These features are already on the backlog for second semester, so hopefully it will be a lot smoother in the near future.

Next, click to analyze your data (ONCE).
![Analyze Your data](https://cloud.githubusercontent.com/assets/8883547/20987602/4f9297aa-bc9b-11e6-83cc-d72b646275da.png)

Note that it may be tempting to reload this page because it looks like nothing happened. DON'T (I've done it a bunch of times; the fix if you accidentally do this is below to reset the database)! You will notice that the URL at the top will end with "/analyze/". This means that reloading the page will cause analysis to begin a second time, which will cause the two analyses (as they will be attempting to run on one thread in parallel, which is impossible) to conflict and could lead to epic-fail as described above. Give the program a little bit of time, and maybe in the meantime, check out the algorithms section to look at the workflow and pseudo code provided.

Note that you can check on the progress of your run by keeping the terminal you used to start the server open on the side. When the run is finished, you will see a screen something like the one below:
![Run Complete](https://cloud.githubusercontent.com/assets/8883547/20987885/56b9bc2e-bc9c-11e6-8c00-0556af08d168.png)

Now, navigate over to the "explore" tab and we can see all of the cool stuff our pipeline made. Click the dataset, and you should see the subject as below. Feel free to download the data, but for now we'll look at the pretty QC page. If this information isn't present or you are taken to a 404 page, something probably went wrong during the processing (ie, you mistsakenly pressed "go" twice, or the host computer ran out of memory, note that fMRI processing is ~8 gigs so fluctuations can be disasterous); don't sweat, just delete the subject and start the subject-add and analysis procedure over again. 

![View Data](https://cloud.githubusercontent.com/assets/8883547/20987934/84544d98-bc9c-11e6-9b81-3fec18f226bc.png)

And voila! This tutorial is now complete. Feedback can be left in the form of git issues, and if you have any recommendations or things that you'd like to see incorporated into the pipeline (anything from specific fMRI processing techniques to helpful web dev frameworks) I'm all ears. Thanks!

### Expected Outputs
** Note: for the purposes of this tutorial, the registration atlases have been replaced with heavily downsampled versions so that this can be checked faster. As such, many steps (particularly, registration and nuisance) lose much of their precision, as they rely on the brains being higher resolution than ~6mm like they presently are for anatomical landmarking.

The total runtime for the tutorial should be approximately 10-15 minutes. If you are curious as to what the outputs should look like, I have included some sample quality control below, found in the "explore" tab on the website, clicking the subject you just analyzed, and then clicking to "view".

The first key quality control figure is the motion correction plot, which can be found in the "motion" tab at the bottom (note that several of these quality control images may appear vertical or horizontal, depending on your monitor width):
![Motion Correction Jitter](https://cloud.githubusercontent.com/assets/8883547/21097735/00eb080c-c034-11e6-950d-d31ced00193b.png)

The next quality control figure to be concerned with is the registration plot, which can be found at the bottom of the "reg" tab:
![Registration](https://cloud.githubusercontent.com/assets/8883547/21097773/37a633bc-c034-11e6-9fe1-33bc7b8273d5.png)

Next, we want to check out the singular values of each of our principal components in our scree plot, found at the bottom of the "nuis" tab:
![Scree](https://cloud.githubusercontent.com/assets/8883547/21097812/636738e8-c034-11e6-9148-398db29f0c72.png)

Finally, we'll want to look at the timeseries and correlation plots, found at the bottom of the "timeseries" tab:
![Timeseries](https://cloud.githubusercontent.com/assets/8883547/21097853/9b23bd10-c034-11e6-9431-d898ca1324c4.png)
![Correlation](https://cloud.githubusercontent.com/assets/8883547/21097872/ab2778c8-c034-11e6-957f-a1bec6f2b886.png)

If you download the results from the "explore" tab, select the dataset, and then select the subject, the downloaded "zip" archive will include a summary figure for the DTI processing in the "ndmgresults/qc" directory. If you open this page in your web browser, you will see:

![DTI results](https://cloud.githubusercontent.com/assets/8883547/21120077/8f15881e-c093-11e6-8b62-b1fb8ca74e3e.png)

Once you are finished, you can go ahead and close out (CTRL + C) on your terminal window to quite the web service.

### For people who felt the need to reload the analysis page (I did it a bunch of times, and I built the thing, so no shame :P)

If you accidentally reload the analysis page or something gets screwed up, I've had the best luck instead of trying to figure out how messed up it is and going from there, just resetting the service entirely. Go to the directory where you have the website installed:
```
$ cd /FNGS_website/fngs # if on the docker container, it will be right here
$ python manage.py flush # Removes all data from the database, but does not touch the existing tables
$ rm -rf /FNGS_server/input_data # deletes the existing data... goodbye! 
$ rm -rf /FNGS_server/output_data
$ cd /FNGS_website/fngs
$ python manage.py 0.0.0.0:8000 # should be back up and good to go again
```

If you want to just freshly build the database with all migrations, follow this:
```
$ cd /FNGS_website/fngs # if on the docker container, it will be right here
$ python manage.py flush # Removes all data from the database, but does not touch the existing tables
# deletes old tables
$ rm -rf /FNGS_website/fngs/analyze/migrations
$ cd /FNGS_website/fngs
$ rm db.sqlite3
# make the migrations and apply to new database
$ python manage.py makemigrations analyze
$ python manage.py migrate
$ rm -rf /FNGS_server/input_data # deletes the existing data... goodbye! 
$ rm -rf /FNGS_server/output_data
$ cd /FNGS_website/fngs
$ python manage.py runserver 0.0.0.0:8000 # should be back up and good to go again
```
