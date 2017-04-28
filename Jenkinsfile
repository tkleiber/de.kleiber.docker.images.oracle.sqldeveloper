pipeline {
  agent {
    node {
      label 'localhost_vagrant'
    }
    
  }
  stages {
    stage('Build Oracle SQL Developer Image') {
      steps {
        sh 'if [ ! -f $SW_FILE ]; then cp "$SW_DIR/$SW_FILE" sqldeveloper-4.1.5.21.78-1.noarch.rpm; fi'
        sh 'sudo docker build --tag oracle/sqldeveloper:$SW_VERSION --build-arg SW_DIR=$SW_DIR --build-arg SW_FILE=$SW_FILE .'
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
    SW_VERSION = '4.2.0'
    SW_FILE = 'sqldeveloper-4.2.0.17.089.1709-1.noarch.rpm'
    SW_DIR = '/software/Oracle/SQLDeveloper'
  }
}