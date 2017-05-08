## Setting Up Your AWS Account

To begin, we will need an easy way to access the credentials to deploy jobs under your billing account. This is so that AWS can appropriately bill you for compute hours that you use. To start, type the following address into your address bar:

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
