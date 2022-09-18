# DevOps Project:
## Create CI/CD pipelines using Git, Terraform, Jenkins, Ansible, and Kubernetes on AWS

We'll go through step by step with full setup guide. Let's quickly starts with git,

### Pre-requisite:
1. Github Account
2. AWS account (free-tier would be enough)
3. Local environment with below things:
- Linux Environment (Recommended) (windows user can use wsl2 : to setup wsl follow this url: https://learn.microsoft.com/en-us/windows/wsl/install)
- configure aws-cli and IAM user account's credentials for your local environment. (create an IAM user and provide AdministrationAccess security group)
- configure github account for you local env and clone your project repository.
- Install additional softwares Terraform.(Optional)(One can use aws gui platform to interact with aws utilities.

#### Assuming developer are done with pre-requisites.
##### Let's quickly get started...

## Step-1: Setup Jenkins-Server
> Let's create an Amazon Linux Ec2-Instance using terraform or aws gui window. 
Terraform file inside Terraform folder as main.tf attached to this project repo. ( It's a basics of terraform)
> Please configure below setups:
- Give name as Jenkins-Server here on this instance
- add port range TCP 8080 additional to the security-group.
- make sure that you have downloaded the private key to login into your instance from your local. If not please create a new one and download it and move it into your     user/.ssh/ path.
- rest keep default
> Once your instance is ready. Let's get started on AWS's Jenkins-Server Instance...
Use below command to connect:
```
ssh -i <path to your private key> ec2-user@<IPv4 Address of your instance>
```
Note: 
  1. change permission for /user/.ssh/file to 600 or the aws security won't accept your connection to instance. 
  Use below command to connect:
  ```
  chmod 600 .ssh/<file-name>
  ```
Once you connected to the instance you'll something like..,
```
       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
4 package(s) needed for security, out of 11 available
Run "sudo yum update" to apply all updates.
[ec2-user@ip-172-31-3-136 ~]$
```



