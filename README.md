# Posts application
The application is written in GO and it's purpose is to manage posts. <br> 
It is capable of creating, updating, deleting and listing simple posts.

### Instructions on how to deploy the application:
- A terraform workflow was created in order to be able to simply deploy the infrastructure required for the application (VPC and network, EKS, ECR).<br>
  It has the options to plan, apply or destroy the infrastructure.
- Once the infrastructure is deployed a commit push to the repo will trigger the CI-CD process which will:
  - Build the image
  - Test the image once it's succefuly built (curl to "/posts" route)
  - Push the image to ECR
  - Deploy to the cluster via Helm install/upgrade
  

### bugs/improvements in main.go and fixes:
- The handle which handles calls to "/posts" via GET used the "createPost" function which creates a new post, <br> 
  GET methods are ususally supposed to only list or get resources and not create them, so i switched the function to "getPosts".
  
- The "main" page or "/" route was not assigned any handle, i asigned it a handle with the "getPosts" function so the base route will not reutrn a "404" error.
- The dependencies of main.go were missing, added go.mod file in order to download the dependecies during the image building.


