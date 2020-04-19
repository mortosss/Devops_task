def SITE = env.ENVIRONMENT != null ? env.ENVIRONMENT : 'NOT_DEFINED'
pipeline {
    agent any
    parameters{
        string(name: 'DOCKER_REGISTRY', defaultValue: 'mortos/egt-devops-task', description: 'Docker registry to pull the images from.')
        string(name: 'DOCKERFILE', defaultValue: 'api.Dockerfile', description: 'Docker filename')
        string(name: 'DOCKERPATH', defaultValue: 'api', description: 'Path to the dockerfile')
        
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
          git branch: jenkins, url: 'https://github.com/mortosss/egt_devops_task.git'
        }
      }
      stage("Build & Push"){
        steps{
          script{
            docker.withRegistry( '', "${REGISTRY_CREDENTIAL}" ) {
              dir("${WORKSPACE}/${params.DOCKERPATH}"){
                def dockerImage = docker.build("${params.DOCKER_REGISTRY}:${env.BUILD_ID}", "-f ${params.DOCKERFILE} .")
                dockerImage.push()
              }
            }
          }
        }
      }
    }



}
