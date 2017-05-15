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

"Unique Token" is any unique identifier that you can later use to query information about your jobs.
"AWS Credentials File" is the CSV file containing your user's access keys.
"Dataset Name" is the name of your dataset (for group level analysis)
"Modality" is the modality of your data.
"Slice Timing Method" is relevant for functional data.

The website also offers functionality to upload data directly through the website. You can upload a .zip of your BIDs spec'd data (including the root folder).
If this option is selected, the website will upload the contents of the zip to the S3 bucket specified in the form. Please make sure the "BIDS Directory" entered
into the form is the same as the root folder in the zip.

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/submit1.JPG)

To start analyzing, click the "Submit Job" button. Once your data is analyzed, the outputs can be found in your specified S3 bucket, inside the specified BIDs directory root.

NOTE: Click the "Submit Job" button exactly once. Once clicked, do not interfere with the page in any way. You might have to wait a bit before the page registers, especially if you choose to upload data directly.



We can also use the website to glean information about previously submitted jobs. Click the "Query" tab:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/submit2.JPG)

Here, we can do one of two things: either get the status of a job, or kill a job. To do either, simply select the option from the dropdown menu, and enter the same unique token that was used when the job was submitted. Be sure to also upload your credentials CSV file:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/query.JPG)

Upon clicking "Submit Query", the page should refresh and you should see the requested information below the form.

