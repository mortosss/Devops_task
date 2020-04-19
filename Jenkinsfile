def SITE = env.ENVIRONMENT != null ? env.ENVIRONMENT : 'NOT_DEFINED'
pipeline {
    agent any
    parameters{
        string(name: 'DOCKER_REGISTRY', defaultValue: 'mortos/egt-devops-task', description: 'Docker registry to pull the images from.')
    }
    environment {
        REGISTRY_CREDENTIAL = 'dockerhub'
    }
    options {
        timeout(time: 10, unit: 'MINUTES')
    }
    stages {
      stage('Cloning Git') {
        steps {
          git 'https://github.com/mortosss/egt_devops_task.git'
        }
      }
      stage("Build & Push"){
        steps{
          script{
            docker.withRegistry( '', "{${REGISTRY_CREDENTIAL}" ) {
              dir("${WORKSPACE}/api/api.Dockerfile"){
                def dockerImage = docker.build("${DOCKER_REGISTRY}:${env.BUILD_ID}")
                dockerImage.push()
              }
            }
          }
        }
      }
    }
}
