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
                  /bin/bash -c "npm-cli-login -u ${NPM_USERNAME} -p ${NPM_PASSWORD} -e test@example.com; npm version minor; npm publish"
                """)
              }
            }
          }
        }
      }
