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
          echo 'Version $SW_VERSION, File $SW_FILE'
          sh 'printenv'
          sh 'echo Version $SW_VERSION, File $SW_FILE'
        }
        
      }
    }
  }
  environment {
    SW_VERSION = '4.1.5'
    SW_FILE1 = 'sqldeveloper-4.1.5.21.78-1.noarch.rpm'
  }
}