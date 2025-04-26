# Strapi Deployment with GitHub Actions + Terraform

This project automates the deployment of a Strapi application using GitHub Actions for CI/CD and Terraform for infrastructure management. The process includes building a Docker image, pushing it to AWS ECR, and deploying it on an EC2 instance.

## Project Overview

This project automates the following:

1. **CI Pipeline (GitHub Actions)**:
   - On pushing code to the `main` branch, the pipeline builds the Docker image of the Strapi application and pushes it to AWS ECR.
   
2. **CD Pipeline (Terraform)**:
   - The CD pipeline is triggered manually to deploy the Docker image onto the EC2 instance using Terraform.

3. **Deployment Verification**:
   - After the Strapi application is deployed to EC2, it is verified by accessing the public IP address of the EC2 instance.

## Step-by-Step Workflow

### CI Pipeline

The first part of the process involves the Continuous Integration (CI) pipeline. This is triggered when changes are pushed to the `main` branch of the repository.

1. **GitHub Actions Workflow**:
   - The workflow runs the Docker build process and then pushes the image to AWS ECR or Docker Hub, depending on your configuration.
  
    
     ![ci](https://github.com/user-attachments/assets/a73aa7cf-fde6-4217-8241-9264748353de)


     

### CD Pipeline

Once the Docker image is pushed to the container registry (Docker Hub or ECR), the Continuous Deployment (CD) pipeline is triggered. The CD pipeline deploys the image to the EC2 instance using Terraform.

1. **GitHub Actions for Terraform Workflow**:
   - The CD pipeline is manually triggered. This step runs `terraform init`, `terraform plan`, and `terraform apply` to deploy the Docker container to the EC2 instance.
  
   
       ![cd](https://github.com/user-attachments/assets/af550677-93f4-490a-ba72-3a9eb68ed1ec)


    

### Docker Image Push to ECR

After the Docker image is successfully built, it is pushed to AWS ECR (or Docker Hub).

1. **Docker Image Push to ECR**:
   - The image is pushed to AWS ECR for storage and future use during deployment.


   
     ![ecr](https://github.com/user-attachments/assets/de498313-9705-4dc3-ab09-ff111f13dc7e)
 
     

### Docker Container Running

To ensure the image is running correctly in the EC2 instance, we use the `docker ps` command to list the running Docker containers.

1. **Running Docker Container**:
   - The `docker ps` command is executed to verify that the container is up and running on the EC2 instance.

2. **Docker Image Listing**:
   - The `docker images` command is used to show all the available Docker images on the EC2 instance.


     ![docker ps](https://github.com/user-attachments/assets/592f27e4-6ac7-4287-9514-2de30ec62166)
  
     

### Strapi Application Running on EC2

Once the Docker container is deployed, the Strapi application can be accessed via the EC2 instance’s public IP address.

1. **Strapi Application Running**:
   - After deploying the container, the Strapi application can be accessed by visiting the public IP of the EC2 instance in a web browser.

     
     ![strapi deployed successfully](https://github.com/user-attachments/assets/d264ea8f-56c7-4b9b-ab77-8a992754e478)


     

## Conclusion

This project successfully automates the deployment of a Strapi application using GitHub Actions for CI/CD and Terraform for infrastructure management. With Docker, AWS ECR, and EC2, the application is built, pushed, and deployed seamlessly. This setup ensures efficient and continuous deployment with minimal manual intervention.

