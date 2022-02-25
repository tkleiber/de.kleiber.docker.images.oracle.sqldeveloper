pipeline {
  agent {
    label 'docker_in_docker'
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '1', artifactNumToKeepStr: '1'))
  }

  stages {
    stage('Build Oracle SQL Developer Image') {
      steps {
        sh 'if [ ! -f $SW_FILE ]; then cp "$SW_DIR/$SW_FILE" $SW_FILE; fi'
        withCredentials(bindings: [usernamePassword(credentialsId: 'store.docker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh '''docker login --username $USERNAME --password $PASSWORD
docker build --tag oracle/sqldeveloper:$SW_VERSION --build-arg SW_FILE=$SW_FILE .'''
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
    SW_VERSION = '21.4.2'
    SW_FILE = 'sqldeveloper-21.4.2-018.1706.noarch.rpm'
    SW_DIR = '/software/Oracle/SQL Developer'
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }
}