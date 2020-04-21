
  stage ('Build') {
    steps {
      script {
            def pom = readMavenPom file: 'pom.xml'            
            // Raw version string in pom.version
            // Based on your versioning scheme, automatically calculate the next one            
            VERSION = pom.version.replaceAll('SNAPSHOT', BUILD_TIMESTAMP + "." + SHORTREV)
      }      
      // We never build a SNAPSHOT
      // We explicitly set versions.
      sh """
          mvn -B org.codehaus.mojo:versions-maven-plugin:2.5:set -DprocessAllModules -DnewVersion=${VERSION}  $MAVEN_OPTIONS
      """
      sh """
        mvn -B clean compile $MAVEN_OPTIONS
      """
    }
  
  stage('Unit Tests') {
    steps {
      sh """
        mvn -B test $MAVEN_OPTIONS
      """
    }
    post {
      always {
        junit '**/target/surefire-reports/*.xml'
      }
    }    
  }
  
  stage('Deploy') {
    steps {
      // Finally deploy all your jars, containers, 
      // deliverables to their respective repositories
      sh """
        mvn deploy:deploy-file \
             -DpomFile=<path-to-pom> \
             -Dfile=<path-to-file> \
             -DrepositoryId=<id-to-map-on-server-section-of-settings.xml> \
             -Durl=<url-of-the-repository-to-deploy>
      """
    }
  }
}
