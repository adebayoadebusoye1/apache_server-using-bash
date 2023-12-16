# apache_server-using-bash
How to create an EC2 instance and write a bash script to provision an Apache server in the EC2 instance, using terraform.
Intro: An apache server is a webserver it is a free and open-source cross-platform web server software. In the attached script, we'd be looking at how to provision an apache server using bash script.
what is bash script? A bash script is a file containing a sequence of commands that are executed by the bash program line by line. Such files will usually end with '.sh'.
Goal: The goal is to be able to browse the ip address and view the desired output, i.e. "I will never be broke in my life!".
Understanding the script:
It is vital to understand the script; the 'apache_server-using-bash' can be broken down into 4 sections; (1) the provider section
(2) The security group, (3) the instance segment and (4) the output segment.
Provider - because terraform is robust, it is compatible with several providers; which Aws is one of them. Provider must be specified so the system knows the target provider. Also, within the provider you're able to select a specific region and/or AZ where the infrastructure deployment will take place.
The security group: The security group defines the rules which governs how the infrastructure is accessed and how it is able to access the internet. By the default, no inbound traffic is enabled, while outbound is enabled. For this script, the security group configuration is set up such that (1). all incoming tcp traffic is allowed thru port 22 (ssh) connection from anywhere 0.0.0.0/0 (2). all tcp traffic is allowed thru port 80 (http) from anywhere 0.0.0.0/0 -since we're launching a webserver, we anticipate http traffic, (3). all traffic allowed thru port 443 (ssh) from anywhere 0.0.0.0/0. 
The instance section - there are several parameters here that must be provided in order for the instance to work and do what we want. 
The AMi - Amazon machine image is that option on Amazon launch profile which allows us to select our operating system of choice, virtualization and storage. We must pre-order this parameter and insert it into the script as required.
Instance type - the instance type is also a requirement...this allows you to pick the system you desire in terms of size, processor, storage and so on... for a tiny prokect like this, t2.micro should be sufficient. NB the prices vary per instance type.
key_name: another security feature that enables profile/role authentication. The keypair is a key that is base-64 encoded. The keypair must be supplied for remote connection enabling.
count = '*' this is just to specify the number of instances we desire.
userdata - the user data is the option that enables bootstrapping which is the activity or function which is performed at launch time. In this case, the command imbedded in the code will update systems and libraries, install apache service, restart and enable the service so the system is able to see it and utilize it. Let's take a good look at the commands; 
<<-EOF
    #!/bin/bash  
    sudo apt update -y
    sudo apt install apache2 -y
    systemctl restart apache2
    systemctl enable apache2
    echo "I will never be broke in my life!" > /var/www/html/index.html
    EOF 
                              Let's analyse the code:
    #!/bin/bash ----this is the command that tells the system that this is a bash script. 
    sudo apt update -y....."sudo" is a unix/linux command that elevates the user's status to root, enabling the user to be 
    able to perform root tasks.
    sudo apt install apache2 -y ....apt is a command synonymous with debian, ubuntu, linux and so on. it is used to manage package installation, deletion, or update. In this scenario, it will install apache2 service. The -y option is that which pre-authorizes the installation. By default, the system will often times ask if you're sure you want to do the installation. Because this is a script for automation, not enabling this will cause the installation not to go thru. By the way, "y" is for yes; meaning go ahead and install.
systemctl restart apache2 -----it is important to restart the system so that the system reboots and detects the change.
systemctl enable apache2 -----by this command, you're basically enabling apache service. Without enabling it, it may not work.
echo "I will never be broke in my life!" > /var/www/html/index.html ----the echo command is a standard linux command for showing output. The expected output which is displayed if all steps are followed correctly. The apache service hosts the html folder containing the web content.
Once everything is in order, it will output the content of the html file within the apache service. the content it should display should be "I will never be poor in my life!". 
The output section refers to the instruction to display a set of values on the screen (ip addresses of servers).
step-by-step:
step1 - from your source-code editor, run the terraform file ....start by using 
1. terraform init
2. terraform validate
3. terraform plan
4. terraform apply -auto-approve....
Doing this should provision the instance and you can take one of the ip addresses in the output and browse it to be able to see the display message.
