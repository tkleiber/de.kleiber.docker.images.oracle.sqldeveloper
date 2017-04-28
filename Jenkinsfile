pipeline {
  agent {
    node {
      label 'localhost_vagrant'
    }
    
  }
  stages {
    stage('Build Oracle SQL Developer Image') {
      steps {
        dir(path: 'Oracle/SQL Developer') {
          sh 'echo Version $SW_VERSION, File $SW_FILE'
          sh 'if [ ! -f $SW_FILE ]; then cp "/software/Oracle/SQL Developer/$SW_FILE" $SW_FILE; fi'
          sh 'sudo docker build -t oracle/sqldeveloper:$SW_VERSION .'
        }
        
      }
    }
    stage('Push Docker Image to Local Registry') {
      steps {
        sh 'docker tag oracle/sqldeveloper:$SW_VERSION localhost:5000/oracle/sqldeveloper:$SW_VERSION'
        sh 'docker push localhost:5000/oracle/sqldeveloper:$SW_VERSION'
      }
    }
    stage('Cleanup') {
      steps {
        sh 'docker rmi --force localhost:5000/oracle/sqldeveloper:$SW_VERSION'
        sh 'docker rmi --force oracle/sqldeveloper:$SW_VERSION'
      }
    }
  }
  environment {
    SW_VERSION = '4.1.5'
    SW_FILE = 'sqldeveloper-4.1.5.21.78-1.noarch.rpm'
  }
}