# Terraform AWS Infrastructure for Splunk Deployment  

This Terraform project automates the creation of AWS infrastructure to deploy a Splunk instance in a VPC with a public subnet and necessary security groups. It uses a custom network setup and fetches the latest Splunk AMI for the EC2 instance.

---

## **Features**

1. **VPC Creation**  
   - Creates a Virtual Private Cloud (VPC) with a custom CIDR block.  

2. **Public Subnet**  
   - A subnet with auto-assigned public IPs in the first availability zone.  

3. **Internet Gateway**  
   - Enables public internet access for resources.  

4. **Route Table**  
   - Routes all outbound traffic (`0.0.0.0/0`) to the Internet Gateway.  

5. **Security Group**  
   - Restricts API (8089) and UI (8000) access to the user's public IP.  

6. **EC2 Instance for Splunk**  
   - Fetches the latest Splunk AMI and launches an EC2 instance in the public subnet.  
   - Assigns a static private IP and tags the instance for identification.  

---

## **Project Structure**

```plaintext
.
├── main.tf           # Combined Terraform configuration
├── variables.tf      # Input variables for the project
├── outputs.tf        # Outputs for Splunk instance IP and credentials
├── terraform.tfvars  # User-defined variable values
├── provider.tf       # AWS provider configuration
├── data.tf           # Data sources (e.g., AMI, Public IP)
├── .gitignore        # Ignore Terraform state and sensitive files
└── README.md         # Project documentation
```

---

## **Requirements**

- **Terraform**: >= 1.0.0  
- **AWS CLI**: Installed and configured with the correct credentials  
- **AWS IAM Permissions**:  
  - Ability to create VPC, subnets, route tables, Internet Gateway, Security Groups, and EC2 instances  

---

## **Usage**

### 1. Clone the Repository  
```bash
git clone <repository_url>
cd <repository_directory>
```

### 2. Initialize Terraform  
```bash
terraform init
```

### 3. Review the Plan  
```bash
terraform plan
```

### 4. Apply the Configuration  
```bash
terraform apply
```

### 5. Outputs  
After the deployment, Terraform will output:  
- **Splunk Public IP**: The public IP address of the EC2 instance  
- **Splunk Default Username**: `admin`  
- **Splunk Default Password**: Auto-generated based on the instance ID  

---

## **Example `terraform.tfvars`**

Create a `terraform.tfvars` file in the root directory with the following content:

```hcl
region        = "us-east-1"
vpc_cidr      = "10.0.0.0/16"
subnet        = "10.0.1.0/24"
private_ip    = "10.0.1.10"
instance_type = "t2.micro"
```

---

## **Outputs**

- **`splunk_public_ip`**: Public IP of the Splunk EC2 instance.  
- **`splunk_default_username`**: Default Splunk username (`admin`).  
- **`splunk_default_password`**: Default password based on the EC2 instance ID.

---

## **Cleanup**

To destroy the infrastructure and release all resources:

```bash
terraform destroy
```

---

## **Notes**

- This code is configured to use your public IP for secure API and UI access to Splunk.  
- Update `terraform.tfvars` to change network configurations.  
- Use a key-pair and IAM role with proper permissions for secure EC2 access.  

---

## **License**

This project is licensed under the MIT License.  

---

## **Author**

[**Your Name**]  
Cloud Infrastructure Automation with Terraform  

---
