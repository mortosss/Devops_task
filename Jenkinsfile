pipeline {
    agent any
    parameters{
        string(name: 'DOCKER_REGISTRY', defaultValue: 'mortos/', description: 'Docker registry to pull the images from.')
        string(name: 'DOCKERFILE', defaultValue: '.Dockerfile', description: 'Docker filename')
        string(name: 'DOCKER_NETWORK', defaultValue: 'appNetwork', description: 'Docker Network')
        
    }
    environment {
        REGISTRY_CREDENTIAL = 'dockerhub'
    }
    options {
        timeout(time: 10, unit: 'MINUTES')
    }
    stages {
      stage('Try Removing containers') {
        steps{
         script{
         try {
           sh(returnStdout: true, script:  
           """
             docker stop db && docker rm db && docker stop NodeJSWeb && docker rm NodeJSWeb && docker stop springBootApi && docker rm springBootApi
            """)
         } catch(Exception RemoveContainers) {
            println("Removing all containers failed. Some might not exist");
          }
         }
        }
      }
      stage('Cloning Git') {
        steps {
          git branch: 'master', url:'https://github.com/mortosss/egt_devops_task.git'
        }
      }
      stage("Build & Push the API"){
        steps{
          script{
            docker.withRegistry( '', "${REGISTRY_CREDENTIAL}" ) {
              dir("${WORKSPACE}/api"){
                def dockerImage = docker.build("${params.DOCKER_REGISTRY}\"springbootapi\":${env.BUILD_ID}", "-f api${params.DOCKERFILE} .")
                dockerImage.push()
              }
            }
          }
        }
      }
      stage("Build & Push the Web"){
        steps{
          script{
            docker.withRegistry( '', "${REGISTRY_CREDENTIAL}" ) {
              dir("${WORKSPACE}/web"){
                def dockerImage = docker.build("${params.DOCKER_REGISTRY}\"nodejsweb\":${env.BUILD_ID}", "-f web${params.DOCKERFILE} .")
                dockerImage.push()
              }
            }
          }
        }
      }
      stage("Push the NPM package"){
        steps{
          script{
            withCredentials([usernamePassword(credentialsId: 'NPM', usernameVariable: 'NPM_USERNAME', passwordVariable: 'NPM_PASSWORD')]) {
              dir("${WORKSPACE}/web"){
                sh(returnStdout: true, script:  
                """
                  docker run                   \
                  --entrypoint=''              \
                  ${params.DOCKER_REGISTRY}\"nodejsweb\":${env.BUILD_ID} \
                  /bin/bash -c "npm-cli-login -u ${NPM_USERNAME} -p ${NPM_PASSWORD} -e test@example.com; npm publish"
                """)
              }
            }
          }
        }
      }
      stage("Create Docker Network"){
        steps{
         script{
            try{
             sh(returnStdout: true, script:  
             """
               docker network create ${params.DOCKER_NETWORK}  
              """)}
            catch(Exception CreateNetwork){
            println("Network Creation failed, the network might already exist");
          }
            }
         }
        }
      stage("Start the DB"){
        steps{
            sh "docker run -d \
                    --network=${params.DOCKER_NETWORK}             \
                    --name=\"db\"                                  \
                    -p 3306:3306                                   \
                    -e MYSQL_RANDOM_ROOT_PASSWORD=true             \
                    -e MYSQL_DATABASE=\'springboot_mysql_example\' \
                    -e MYSQL_USER=\'newuser\'                      \
                    -e MYSQL_PASSWORD=\'password\'                 \
                    -v my-db:/var/lib/mysql mysql:5.7 "
            }
      }
      stage("Start the API"){
        steps{
            sh "docker run -d                                                 \
                    --network=${params.DOCKER_NETWORK}                        \
                    --name=\"springBootApi\"                                  \
                    -v $HOME/.m2:/root/.m2                                    \
                    -p 8080:8080                                              \
                    -e SPRING_DATASOURCE_URL=\"jdbc:mysql://db:3306/springboot_mysql_example?autoReconnect=true&useSSL=false\" \
                    ${params.DOCKER_REGISTRY}\"springbootapi\":${env.BUILD_ID}"
            }
      }
      stage("Start the Web"){
        steps{
            sh "docker run -d                                               \
                    --network=${params.DOCKER_NETWORK}                      \
                    --name=\"NodeJSWeb\"                                    \
                    -p 3000:3000                                            \
                    -e API_HOST=\"http://springBootApi:8080\"               \
                    ${params.DOCKER_REGISTRY}\"nodejsweb\":${env.BUILD_ID}"
            }
      }
      }
          }
