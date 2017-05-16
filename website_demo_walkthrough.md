# Setup of Batch

For the website demo, we assume that the user has set up their AWS account properly. Begin by navigating to the [AWS website](https://aws.amazon.com/), and creating a user as below:

![image](https://cloud.githubusercontent.com/assets/8883547/26090633/4335a568-39d4-11e7-909e-e591bcde33aa.png)

Follow the prompts from AWS, and you should be able to create a free-tier user. 

Next, we need to do some initial configuration of AWS Batch so that the service is available to your user. First, select the console as shown below:

![image](https://cloud.githubusercontent.com/assets/8883547/26090665/750afb7e-39d4-11e7-909a-eff8e90d80aa.png)

Make sure to set your region to N. Virginia, even if you do not actually live there by clicking the dropdown in the top right:

![image](https://cloud.githubusercontent.com/assets/8883547/26090714/b7cc07b4-39d4-11e7-814a-0f432e1b06f2.png)

Click the dropdown for all services, and then select Batch:

![image](https://cloud.githubusercontent.com/assets/8883547/26090687/96142782-39d4-11e7-9852-194089e1fa82.png)

Get started with Batch:

![image](https://cloud.githubusercontent.com/assets/8883547/26090745/e01933d6-39d4-11e7-9ac8-f61b1c3e1764.png)

Click through the getting started guide, following the remainder of the instructions as-per the Amazon Web-Services Website. 

# Creating an IAM User

After this point, we will be assuming that you have created an Amazon AWS account and have completed setup as above. 

Next, we need to start setting up the AWS cloud services, starting with the creation of a new user. This is because we will need an easy way to access the credentials to deploy jobs under your billing account. This is so that AWS can appropriately bill you for compute hours that you use. To start, type the following address into your address bar:

```
https://console.aws.amazon.com/iam/
```

You should be prompted with a login screen. Put your corresponding information in, and click to sign in. Next, we are going to create an IAM user. Basically, an IAM user is Amazon's secure way to allow you to make a user that has your billing credentials, but so that it can occur in a more restrictive way. AWS also allows root access keys, which grant the priviledge to do anything to you as a user, which is less favorable. You should see the following screen, and then click the boxed-out option below:

![image](https://cloud.githubusercontent.com/assets/8883547/25784042/bcdde53e-3334-11e7-9000-71a8a1abfd71.png)

Click to add a user:

![image](https://cloud.githubusercontent.com/assets/8883547/25784049/e36330ce-3334-11e7-9a6c-3ca9c45ff8e4.png)

Next, fill in appropriate user-name and access type. We want programmatic access, and a user name of your choice. Then, click next:

![image](https://cloud.githubusercontent.com/assets/8883547/25784053/032749d6-3335-11e7-802a-f47b7f896271.png)

Click to create a group on the permissions page:

![image](https://cloud.githubusercontent.com/assets/8883547/25784057/1d9eb33a-3335-11e7-87b7-c8e61d29967c.png)

On the next screen, select administrator access (giving us full control of cloud infrastructure), name your group, and create the group:

![image](https://cloud.githubusercontent.com/assets/8883547/25784065/59565e6e-3335-11e7-8b8d-4c0f97852e0c.png)

Review your choices, and then create your user. Before closing the next box, make sure to download your csv keypair and keep this safe: you will need this for the remainder of our tutorial.

![image](https://cloud.githubusercontent.com/assets/8883547/25784074/958bc806-3335-11e7-9517-987b4bde5136.png)

Great! Now your user is created, and you can continue with the actual deployment portion of the tutorial. For our purposes, note that we will assume that your keypair is found at the following directory:

```
/home/<your-user>/Downloads/accessKeys.csv
```

Now, you can navigate back to the website and just use these as your credentials and the provided data to complete the tutorial. 

# Retrieving Outputs

Once your data is analyzed, the outputs can be found in your specified S3 bucket, inside the specified BIDs directory root. For example, to navigate to my bucket "test-fngs", I would type the following into my address bar:

```
https://console.aws.amazon.com/s3/buckets/test-fngs/
```

This will take me to the following page, which is the root of my bucket:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/getoutputs1.jpg)

From here, I click on my BIDS directory to get to the following page:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/getoutputs2.jpg)

Clicking the above folder takes me to my participant level outputs! To get to my graph level outputs, I can go to the "qa" folder:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/getoutputs3.jpg)

Here, I have the quality assurance results for the participant and group level analyses. The boxed folders in the image below are the group outputs, and the rest are participant outputs:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/getoutputs4.jpg)

That about wraps it up for this tutorial. You should now be well equipped to use the FNGS web service to analyze your data.

# Avoiding Phantom AWS Batch Charges

Since AWS Batch is still a relatively new service, there are many bugs. It is possible for you to incur costs even if you aren't using Batch! This happens because the compute environments and job queues can sometimes spawn instances for no reason. Below, we show you how to avoid these charges by deleting your FNGS compute environment and job queue once you are done analyzing your data.

To start, first go to your Batch console dashboard by using the following url:

```
https://console.aws.amazon.com/batch/home?region=us-east-1#/dashboard
```

This will take you to the dashboard. Click on "Job Queues" as shown below:

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/delete1.jpg)

Here you will see a list of your queues. The one we are interested in is called "ndmg-fmri-queue". Select this queue and click "Disable":

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/delete2.jpg)

Now you must wait for the queue to be disabled. Refresh the page occasionally until the queue becomes "DISABLED" and stops "UPDATING". Now, select the queue again and click "Delete":

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/delete3.jpg)

This can take some time. Refresh the page occasionally until the queue disappears. Now, click on "Compute Environments":

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/delete4.jpg)

Here we are interested in "ndmg-fmri-env". Select this environment and click "Disable":

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/delete5.jpg)

Now you must wait for the environment to be disabled. Refresh the page occasionally until the environment becomes "DISABLED" and stops "UPDATING". Now, select the environment again and click "Delete":

![image](https://raw.githubusercontent.com/NeuroDataDesign/fngs/master/docs/02agarwalt/project1/week_0424/delete6.jpg)

This can take some time. Refresh the page occasionally until the environment disappears. You are done! Now you can rest assured that you won't incur random costs due to buggy Batch services.
