## Using the NDMG Website

To use the NDMG website, type the following into your address bar:

```
https://cortex.jhu.edu:8003
```

You should now be on the homepage of the website. To analyze data, click the "Submit" tab:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/home.JPG)

Fill out the form fields appropriately: 

First select the analysis level you want to perform. This can be either 'participant' or 'group'.

"S3 Bucket Name" is the name of the bucket where your data lives. This bucket should have been created using our instructions on how to properly set up S3 for FNGS.

"BIDS Directory" is the root directory of your BIDs spec'd data on the S3 bucket. If performing participant level analysis, this folder should have all the desired raw data (for example, the BIDS directory of the FNGS-provided demo data is DC1-demo). If performing group level analysis, this directory should contain the outputs of the participant level analysis (for example, after performing participant analysis on the demo data, the BIDS directory for group analysis becomes DC1-demo/ndmg_0-0-49).

"Unique Token" is any personalized unique identifier that you can later use to query information about your jobs. It's basically like your "password" for accessing information about the jobs that you submit. Try to make this as unique as possible so as to avoid possible conflicts with other users.

"AWS Credentials File" is the CSV file containing your user's access keys. Make sure you obtain these keys in the correct manner, according to our instructions on setting up an AWS user.

"Dataset Name" is the name of your dataset (used only for group analysis). For example, for the FNGS-provided demo data, this would be DC1.

"Modality" is the modality of your data. This can be either "functional" or "DWI".

"Slice Timing Method" is the manner in which the brain data slices were acquired through the fMRI scanner (used only for participant level functional analysis). The choices are none, bottom up, top down, and interleaved. 

The website also offers functionality to upload data directly through the website. To do so, you must upload a .zip of your BIDs spec'd data at the root level. For example, for the FNGS-provided demo data, the first folder inside the zip file is DC1-demo, which is the BIDS directory. If using this feature, make sure you fill in the "BIDS Directory" and "S3 bucket" field correctly. If you select the option to upload data, the website will upload the contents of the zip file to the specified S3 bucket, and will continue analysis by looking for the specified BIDS directory. So, please make sure the BIDS directory that is specified has the same name as the root folder inside the submitted zip file.

NOTE: We ask that you limit your zip sizes to 2GB in size. If your data is larger than this, you will have to upload your data to S3 using our previous instructions outlining how to do so.

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/submit1.JPG)

To start analyzing, click the "Submit Job" button. Once your data is analyzed, the outputs can be found in your specified S3 bucket, inside the specified BIDs directory root. You will see a new folder called "ndmg_0-0-49" with all your outputs.

NOTE: Click the "Submit Job" button exactly once. Once clicked, do not interfere with the page in any way. You might have to wait a bit before the page registers, especially if you choose to upload data directly.



We can also use the website to glean information about previously submitted jobs. Click the "Query" tab:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/submit2.JPG)

Here, we can do one of two things: either get the status of a job, or kill a job. To do either, simply select the option from the dropdown menu, and enter the same unique token that you used when submitting the job. Be sure to also upload your credentials CSV file:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/query.JPG)

Upon clicking "Submit Query", the page should refresh and you should see the requested information below the form.

