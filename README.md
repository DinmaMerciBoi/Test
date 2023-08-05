# BUILDING AND DEPLOYING A TEST PYTHON APPLICATION

Within this repository is the code for deploying this python application, which includes a `Dockerfile` and a `Jenkinsfile`.

To deploy this application, take the following steps:

## Step 1
Clone/fork this repository. This repository is Public, so you would not require any authentication to clone or fork it.
Login to your Jenkins server, and ensure that Jenkins is able to run docker commands to run this project.
For the purpose of this project, you may find a custom Jenkins-Docker image here:
```bash
https://hub.docker.com/repository/docker/chydinma/jenkins-docker/general
```
Install suggested plugins, and two other plugins - `SSH Agent` and `Kubernetes CLI`
Create `Secret File` type of credential for the Kubernetes CLI, and add the kubeConfig file only.

## Step 2
Create a pipeline project and add the `Jenkinsfile` to run the pipeline.
Configure the required variables and credentials, and edit the script as required to fit your environment.

## Step 3
Before you run the build, edit the file `test.yml` (included inthe repository) to the specified image version at the build.
You may configure a GitHub Webhook to trigger the build and deploy as configured.

## Step 4
Once the application is running, You may begin operations on the application.

# USING THE APPLICATION

## 1. Log into the `mysql` pod
```bash
kubectl exec -it <pod-ID> -- bash
```

## 2. Login to mysql server, and run these commands in this order
```bash
mysql -u root -p root

SHOW DATABASES;

USE test;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    user_password VARCHAR(255) NOT NULL
);

DESCRIBE users;
```

## 3. Add content to the table as desired with the following methods

   * While still logged into the mysql server, run this command
```bash
INSERT INTO users VALUE ("1", "name", "someemail@gmail.com", "password1");
```

   * On the CLI from a different terminal or command prompt, using the cURL command
```bash
curl -X POST -H "Content-Type: application/json" -d '{"name":"John Doe","email":"john@example.com","pwd":"password123"}' http://IPAddress/create
```

   * On the GUI using the Postman Software
     - Using Postman (GUI Tool):
     - Download and install Postman from https://www.postman.com/downloads/.
     - Launch Postman and create a new request.
     - Set the request method to POST.
     - Enter the URL http://IPAddress/create.
     - Go to the "Body" tab.
     - Select "raw" and choose "JSON" from the dropdown.
     - Enter the JSON data in the request body:
```bash
{
    "name": "John Doe",
    "email": "john@example.com",
    "pwd": "password123"
}
```
    - Click the "Send" button to send the POST request.
    - Likewise, you can retrieve and update information on the table.

   * Other mysql server commands can also be used to perform respective operations - Create, Read, Update and Delete.

