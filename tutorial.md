# FNGS Cloud Tutorial

## Setting Up Your AWS Account

### IAM User

To begin, we will need an easy way to access the credentials to deploy jobs under your billing account. This is so that AWS can appropriately bill you for compute hours that you use. To start, type the following address into your address bar:

```
https://console.aws.amazon.com/iam/
```

You should be prompted with a login screen. Put your corresponding information in, and click to sign in. Next, we are going to create an IAM user. Basically, an IAM user is Amazon's secure way to allow you to make a user that has your billing credentials, but so that it can occur in a more restrictive way. AWS also allows root access keys, which grant the priviledge to do anything to you as a user, which is less favorable. You should see the following screen, and then click the boxed-out option below:

