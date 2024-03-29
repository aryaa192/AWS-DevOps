## SETUP JENKINS SERVER on EC2 INSTANCE
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
### *** INSIDE EC2 INSTANCE ***
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
  ### TADA :) Welcome to Jenkins Dashboard

Now, Let's Setup Maven on same ec2 instance and integrate it on jenkins gui.
### *** INSIDE EC2 Instance - Jenkins-Server ***
#### install git in your ec2 instance.
command:
```
yum install git
```
> Go to Jenkins Dashboard...
> install plugin github and setup git configuration.
> create a job for pulling the code from your github respository.
> Run Build.

### install maven on same ec2 instance
one can follow the instruction for installing maven from this url: **https://maven.apache.org/install.html**
or
### run below command:
```
$ cd /opt
$ wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
$ tar -xvfz <apache-maven-tar-file-name>
$ mv <apache-maven-file> maven
```
Now, Let's set path for maven to be run from anywhere.
Note: We'll be setting this for root user.
Go to : root home directory
Look for hidden file .bash_profile by **ls -al** command
> Edit the .bash_profile file using vi editor.
Add below configuration path:
```
M2_HOME=/opt/maven
M2=/opt/maven/bin
JAVA_HOME=<find where jdk is installed in ec2 instance set that path>

PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2
```
Note: use this command: **find / -name java-11*** (in your case parameter may differ.)
after configuration it should look like this..
![image](https://user-images.githubusercontent.com/22274075/190923936-80b6de4d-79e4-4ddd-b917-5260d368ab36.png)

Let's verify it..

```
$ mvn -v
Apache Maven 3.8.6 (84538c9988a25aec085021c365c560670ad80f63)
Maven home: /opt/maven
Java version: 11.0.16, vendor: Red Hat, Inc., runtime: /usr/lib/jvm/java-11-openjdk-11.0.16.0.8-1.amzn2.0.1.x86_64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.10.135-122.509.amzn2.x86_64", arch: "amd64", family: "unix"
[root@ip-172-31-3-136 ~]# vi .bash_profile
[root@ip-172-31-3-136 ~]# mvn -v
Apache Maven 3.8.6 (84538c9988a25aec085021c365c560670ad80f63)
Maven home: /opt/maven
Java version: 11.0.16, vendor: Red Hat, Inc., runtime: /usr/lib/jvm/java-11-openjdk-11.0.16.0.8-1.amzn2.0.1.x86_64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.10.135-122.509.amzn2.x86_64", arch: "amd64", family: "unix"
```
TADA... :) maven installed and configured.

Now, Let's go to Jenkins Gui portal
### *** On Jenkins-Server GUI Dashboard ***
> Install maven plugins
> goto global configs:
> set java home path installed on ec2 instance.
> set maven path : /opt/maven

Let's create another job called FirstMavenProject.
provide two inputs:
1. github repository url to pull the code
2. under Build/ Goals & Option : clean install
> Apply and save | run build.

Now, Let see the final output:
Go to:
```
cd /var/lib/jenkins/workspace/<project-name>/webapp/target/webapp.war
```
Here, this webapp.war is nothing but your artifacts and this is what we get as final output build from maven. Next we're going to deploy this artifact to Tomcat-Server.
Let's go to Tomcat Directory.

