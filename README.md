# Devops Web App

## This is a Test NodeJS FrontEnd + Java Spring API Backend Application.

### The Java Backend part is hosted in the __api__ folder
You need Java8 (works fine with openJDK) and latest MAVEN.

To build the application, you must execute:

```sh
 mvn clean install -Dmaven.test.skip=true
 ```
In order for the __API__ service to start, it needs to have a _MySQL Database Resource_ created

### The NodeJS FrontEnd part is hosted in the __web__ folder

You need NodeJS to compile and run the _WEB_ part, install is done with:
```sh
npm install
```
Running the _WEB_ application happens with __npm start__

In order for the Applcation to run, you must set the *API_HOST* environment variable to NodeJS, prior to running:
```sh
npm start
```

### Expected Results:

If you have done everything right - the result would be a nyan cat showing on the screen, when you visit http://127.0.0.1:3000

## The Task:
0. Clone the repository locally
1. Do a presentation on building CI and CD solution for the application, note the fact that we are deploying on Bare-Metal, thus the deployment should happen with Ansible or BASH
2. Add in the presentation some info on implementing monitoring solution to servers, where the application will be deployed
3. Prepare a running Docker-Compose recipe for local development environment
4. Prepare a sample workflow with Jenkins, using groovy on building the application and storing its artifacts to either Nexus NPM and Maven repositories
5. Prepare a small guide, intended for the developers/qa engineers, what do they have on their machines, to work with the application
6. Commit the presentation, the docker-compose recipe, the Jenkinsfile and the guide to the local repository
7. Provide us with a copy of the repository via email and present a working solution on the technical interview

### Time needed: ~5days
