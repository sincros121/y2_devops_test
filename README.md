# Posts application
The application is written in GO and it's purpose is to manage posts. <br> 
It is capable of creating, updating, deleting and listing simple posts.

### Instructions on how to deploy the application:
- A terraform workflow was created in order to be able to simply deploy the infrastructure required for the application (VPC and network, EKS, ECR).<br>
  It has the options to plan, apply or destroy the infrastructure.
- Once the infrastructure is deployed a commit push to the repo will trigger the CI-CD process which will:
  - Build the image
  - Test the image once it's succefuly built (curl to `/posts` route)
  - Push the image to ECR
  - Deploy to the cluster via Helm install/upgrade
  

### bugs/improvements in main.go and fixes:
- The handle which handles calls to `/posts` via GET used the `createPost` function which creates a new post, <br> 
  GET methods are ususally supposed to only list or get resources and not create them, so i switched the function to `getPosts`.
  
- The "main" page or "/" route was not assigned any handle, i asigned it a handle with the `getPosts` function so the base route will not reutrn a "404" error.
- The dependencies of main.go were missing, added go.mod file in order to download the dependecies during the image building.


### My work and notes
## Dockerfile
I created a multi stage Dockerfile starting from the `go:alpine` image as it was the smallest size, the only downside is that downloading the go dependecies requires git which alpine lacks, so it is installed during build, which in my opinion is worth it if there is access to the internet since it saves about 100mb of image size.
the main.go is copied only after the dependencies file(go.mod) is copied and the dependencies downloaded so in case main.go is changed the dependency layer will stay intact.
The artifact is built and copied to a new clean lightweight alpine image.


### Terraform

