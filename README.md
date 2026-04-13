Deploying Two EC2 Web Servers Behind an Application Load Balancer Using Terraform
Highly Available AWS Infrastructure using Infrastructure as Code

📋 Project Overview
This project demonstrates how to deploy a highly available web infrastructure on AWS using Terraform. It provisions a custom VPC, public subnets across multiple Availability Zones, EC2 instances running Nginx, and an Application Load Balancer (ALB) that distributes HTTP traffic between servers.
Key highlights:

Infrastructure as Code using Terraform for repeatable, version-controlled deployments
Custom VPC and public subnets across multiple Availability Zones
Two EC2 instances running Nginx as web servers
Application Load Balancer with health checks for traffic distribution
Secure networking using Security Groups
High availability architecture with cross-AZ redundancy


🛠 Technology Stack
TechnologyPurposeDetailsTerraformInfrastructure as CodeProvision and manage all AWS resourcesAWS EC2Virtual ServersTwo t2.micro instances running NginxAWS VPCNetworkingCustom VPC with public subnets in multiple AZsAWS ALBLoad BalancerALB with HTTP health checksNginxWeb ServerLightweight HTTP server on each EC2 instanceLinuxOperating SystemAmazon Linux 2 AMI on EC2 instances

🏗 Architecture
                      Internet
                          |
            Application Load Balancer (ALB)
                          |
                    Target Group
                 /               \
        EC2 (AZ-1)             EC2 (AZ-2)
     [Nginx Server 1]       [Nginx Server 2]
            |                     |
   Public Subnet-1         Public Subnet-2
            \                    /
        Route Table → Internet Gateway
                          |
                      Custom VPC
Traffic flow:

Client sends HTTP request to the ALB DNS name.
ALB distributes the request to one of the two EC2 instances via the Target Group.
Nginx on the EC2 instance serves the response ("server-1" or "server-2").
ALB health checks continuously monitor instance health.


📁 Project Structure
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── .gitignore
└── README.md
FileDescriptionmain.tfCore infrastructure definitions (VPC, EC2, ALB, Security Groups)variables.tfVariable declarations and typesterraform.tfvarsVariable values (region, AMI, instance type)outputs.tfOutput values (ALB DNS name, instance IDs).gitignoreExcludes .tfstate, .tfvars, and sensitive files from GitREADME.mdProject documentation

✅ Prerequisites
Ensure the following tools are installed before proceeding: Terraform v1.0+, AWS CLI v2.x, and Git.
Verify installations:
shterraform --version
aws --version
git --version

🚀 Installation & Setup
1. Configure AWS Credentials
shaws configure
Provide your Access Key ID, Secret Access Key, and default region when prompted.
2. Clone the Repository
shgit clone https://github.com/shivaji67/Deploying-Two-EC2-Web-Servers-Behind-an-Application-Load-Balancer-Using-Terraform-AWS.git
cd Deploying-Two-EC2-Web-Servers-Behind-an-Application-Load-Balancer-Using-Terraform
3. Create terraform.tfvars
shnano terraform.tfvars
Add the following:
hclaws_region    = "us-east-1"
ami_id        = "ami-0532be01f26a3de55"
instance_type = "t2.micro"

⚙ Deployment
Initialize Terraform — downloads required providers:
shterraform init
Validate — checks for syntax and logical errors:
shterraform validate
Plan — previews changes without applying them:
shterraform plan
Apply — provisions all AWS resources:
shterraform apply

🔍 Verify Deployment
Get the ALB DNS name:
shterraform output
Open in your browser:
http://<alb-dns-name>
Refresh the page multiple times. You should see the response alternate between server-1 and server-2, confirming the ALB is distributing traffic across both instances.

🧹 Cleanup
To destroy all provisioned resources and avoid ongoing AWS charges:
shterraform destroy

📝 Notes

Never commit terraform.tfvars or .tfstate files to version control — the .gitignore is pre-configured to exclude them.
The AMI ID ami-0532be01f26a3de55 is region-specific (us-east-1). Update it if deploying to a different region.
t2.micro is eligible for the AWS Free Tier.
ALB health checks run every 30 seconds by default; unhealthy instances are automatically removed from rotation.
