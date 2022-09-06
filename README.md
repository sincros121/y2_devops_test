# Home Exercise
• The purpose of the following tasks is to gain familiarity with your way of thinking, your approach to new problems, and your ability to design and implement cloud solutions.

• Please spend only as much time as you are able and willing to in order to finish the exercises as efficiently as possible. Don't be concerned with minor elements that you believe are irrelevant to the exercise; but, keep in mind that we want to see efficient, readable, and well-designed code.

• You can provide an architecture document or complement your code with comments to help us understand why you chose to implement things the way you did.

• Please implement with AWS cloud vendor


## **Exercise**:

Design and implement an environment with an EKS cluster.

The running service should be this simple go web application containerized.

### **Task 1 - IaC**
Create all of the neccessry cloud resorces in order to build the EKS cluster using Terraform.
### **Task 2 - Dockerize**
Create a `Dockerfile` for this simple go web application.

### **Task 3 - Kubernetes Integration**
Create all of the neccessry objects in order to run the application in a working kubernetes cluster.

### **Task 4 - Create a simple CI/CD script**
Edit `.github/actions/pipeline/entrypoint.sh` with the following steps:
* build docker image
* tag the new image as `<branch_name>-<sha>`
* optional - test the image before pushing (only `/posts` on GET)
* push
* deploy


## **Submissions:**
1. Link to a git repository with the source code and any other relevant and
supporting information.
2. Screenshots of the following:
    1. Running cluster instance in AWS console
    2. Running pods


TIPs:
* IaC code can be in a different git repository
* The script will run after each commit
* Build is running on a fresh ubuntu image so docker must be installed
* You can check it in `Actions` tab
