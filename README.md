Application Details



Instruction to run and maintain the Application

1. Firstly, we will create an Amazon Linux EC2 instance manually and set up the configuration as per our need.

2. We will Install terraform and kubernetes in the AWS by using the required installation instruction and use aws configure to connect it with AWS Account.

 3. Installed terraform in the EC2 Instance using the below command.
      “yum install -y yum-utils”
       Then we added the repo using the command “yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo”
       Then install the terraform using “yum -y install terraform”.

4. Checked if the EC2 is up-to-date or not using the command sudo yum update.

5. Now we will create a new directory in the AWS EC2 instance where we will be storing the terraform configuration file. In this folder we will create a filename “main.tf” and initialize it with the terraform code.

6. Now we have to create an AWS EKS cluster, so we will start with editing the main.tf file and add our terraform code in it. 

7. Now we will add the IAM roles and policies for the cluster and worker node by adding the code in the terraform file.

8. In the EKS node group we have desired size of 2 for our worker nodes and we have used t3.medium as our instance type.

9. Once done, we will apply the new terraform code and wait for it to get completed. If the plan is correct, we will confirm it by typing “yes” when prompted. We will see the below output once the infra creation is completed

<a href="https://drive.google.com/uc?export=view&id=1Y6UVpxT1efBHKGmsgN4KEXJkMxGYWsHj"><img src="https://drive.google.com/uc?export=view&id=1Y6UVpxT1efBHKGmsgN4KEXJkMxGYWsHj" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />


10. We can see the infrastructure created in the AWS as well.

<a href="https://drive.google.com/uc?export=view&id=1ixB2ElyaAR_O_vdw5Oq2yDzrHCE5zJeq"><img src="https://drive.google.com/uc?export=view&id=1ixB2ElyaAR_O_vdw5Oq2yDzrHCE5zJeq" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />

<a href="https://drive.google.com/uc?export=view&id=1XLaRVjDulekXefWULnQIbbpEgRPX2Xjo"><img src="https://drive.google.com/uc?export=view&id=1XLaRVjDulekXefWULnQIbbpEgRPX2Xjo" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />

<a href="https://drive.google.com/uc?export=view&id=1IaIO2LBegA4HxDn361lKGi1AH4lKZO02"><img src="https://drive.google.com/uc?export=view&id=1IaIO2LBegA4HxDn361lKGi1AH4lKZO02" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />

11. Once the infrastructure is up, we will configure the newly created cluster by running the below command. 

<a href="https://drive.google.com/uc?export=view&id=1Z9bcIusONRD-fUT0-skKmcaJd2MbAtid"><img src="https://drive.google.com/uc?export=view&id=1Z9bcIusONRD-fUT0-skKmcaJd2MbAtid" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />

This will update the kubernetes config to access our cluster.

12. Now we will check if the cluster is accessible. We will see the output as per the below image.

<a href="https://drive.google.com/uc?export=view&id=12JDDTiQv_VHepupMVgcqI8s4vt4oWHGY"><img src="https://drive.google.com/uc?export=view&id=12JDDTiQv_VHepupMVgcqI8s4vt4oWHGY" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />

13. We have downloaded EKSCTL for creating and managing clusters on EKS with the below commands.

 curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
 mv /tmp/eksctl /usr/local/bin
 eksctl version

	
After running the above command we can see the version of downloaded EKSCTL.

<a href="https://drive.google.com/uc?export=view&id=1lduAAk4zIxCfVFw6uS_-1b8-o7E3SGab"><img src="https://drive.google.com/uc?export=view&id=1lduAAk4zIxCfVFw6uS_-1b8-o7E3SGab" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />

14. Now we will create deployment configuration in the yaml format with the file name as deploy.yml for the Kubernetes with the name swordhealth-deployment using a docker image.



15. Now we will apply the above created deploy.yml to kubernetes using the below command 



16. Once everything has been set up correctly we will access the pods and we will get to see the details of the pods as below.



17. Once the pod is ready, we need to expose the application and for that we need the service resource. A Service provides a stable network endpoint (IP address and port) to access your application within the Kubernetes cluster.



18. Now we will apply the above created service.yml to kubernetes using the below command



19. Once the service.yaml file has been applied, we will check if the service is up or not.




20. We are able to access the application.




 



