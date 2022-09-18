# DevOps Project:
## Create CI/CD pipelines using Git, Terraform, Jenkins, Ansible, and Kubernetes on AWS

We'll go through step by step with full setup guide.

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
tada..!! you're into amazon-linux-2 instance.
Now it's time to play inside the insatnce. Let's get started...
### *** INSIDE AMAZON-LINUX-2 INSTANCE ***
Run:
```
sudo yum update
```
Now, Let's install jdk and Jenkins-Server
Follow the url: https://pkg.jenkins.io/redhat-stable/
or
run these command:
```
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
```
Note: If you've previously imported the key from Jenkins, the rpm --import will fail because you already have a key. Please ignore that and move on.
```
  yum install fontconfig java-11-openjdk
  yum install jenkins
```
Note: If you're not able to download jdk from above command specially in Amazon-Linux Instance use below command:
```
amazon-linux-extras 
```
> You'll get list of packages available. Download jdk and epel (relevent to jenkins)
```
amazon-linux-extras install java-openjdk11
amazon-linux-extras install epel
```
Let's confirm the status by running:
```
service jenkins status
```
if the output looks like this: assume all good! :) tada...
```
● jenkins.service - Jenkins Continuous Integration Server
   Loaded: loaded (/usr/lib/systemd/system/jenkins.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
```
Let's start the service jenkins by running,
```
service jenkins start
```
Let's confirm the status of jenkins..
```
 service jenkins status
● jenkins.service - Jenkins Continuous Integration Server
   Loaded: loaded (/usr/lib/systemd/system/jenkins.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2022-09-18 06:29:16 UTC; 40s ago
 Main PID: 14199 (java)
   CGroup: /system.slice/jenkins.service
           └─14199 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenki...
Sep 18 06:28:39 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: This may...
Sep 18 06:28:39 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: ********...
Sep 18 06:28:39 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: ********...
Sep 18 06:28:39 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: ********...
Sep 18 06:29:16 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: 2022-09-...
Sep 18 06:29:16 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: 2022-09-...
Sep 18 06:29:16 ip-172-31-3-136.ap-south-1.compute.internal systemd[1]: Started Jenk...
Sep 18 06:29:16 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: 2022-09-...
Sep 18 06:29:16 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: 2022-09-...
Sep 18 06:29:16 ip-172-31-3-136.ap-south-1.compute.internal jenkins[14199]: 2022-09-...
Hint: Some lines were ellipsized, use -l to show in full.
```
tada.. :D good to go!!
Now, Let's go on <ec2-instance-ip address>:8080 (make sure that you have added this port number in your instance security group.) (If not please go to aws-portal and open this port by modifying your security group.)

Hoping that you're on jenkins login page..
![image](https://user-images.githubusercontent.com/22274075/190889247-21a28d0c-46e1-4b99-bfe0-8f151c5ea415.png)

Oops!! It's asking for the password :>
As you can see above highlighted path!!
run it in your instance:
  ```
  cat /var/lib/jenkins/secrets/initialAdminPassword
  ```
you'll get some longggg.... string that's your password!!! 
  let's go next..
  > The next page is about installing plugins (one can skip this for later on by clicking cross x icon)
  > start using jenkins 
  ## TADA :) Welcome to Jenkins Dashboard
