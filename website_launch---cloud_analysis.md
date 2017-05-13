## Using the NDMG Website

To use the NDMG website, type the following into your address bar:

```
https://cortex.jhu.edu:8003
```

You should now be on the homepage of the website. To analyze data, click the "Submit" tab:

![image]()

Fill out the form fields appropriately. 
First select the analysis level you want to perform.
"S3 Bucket Name" is the name of the bucket where your data lives.
"BIDS Directory" is the root directory of your BIDs spec'd data on the S3 bucket.
"Unique Token" is any unique identifier that you can later use to query information about your jobs.
"AWS Credentials File" is the CSV file containing your user's access keys.
"Dataset Name" is the name of your dataset (for group level analysis)
"Modality" is the modality of your data.
"Slice Timing Method" is relevant for functional data.

![image]()

The website also offers functionality to upload data directly through the website. You can upload a .zip of your BIDs spec'd data (including the root folder).
If this option is selected, the website will upload the contents of the zip to the S3 bucket specified in the form. Please make sure the "BIDS Directory" entered
into the form is the same as the root folder in the zip.

![image]()

To start analyzing, click the "Submit Job" button. Once your data is analyzed, the outputs can be found in your specified S3 bucket, inside the specified BIDs directory root.



We can also use the website to glean information about previously submitted jobs. Click the "Query" tab:

![image]()

Here, we can do one of two things: either get a job status, or kill a job. To do either, simply select the option from the dropdown menu, 
and enter the same unique token that was used when the job was submitted. Be sure to also upload your credentials CSV file:

![image]()

Upon clicking "Submit Query", the page should refresh and you should see the relevant information as requested:

![image]()


