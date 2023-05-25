pipeline {
    agent any
    
    stages {
        stage('Pull from GitHub') {
            steps {
                echo 'pulling from github'
            }
        }
        
        stage('Test NiFi workflow') {
            steps {
                // Add steps here to test your NiFi workflows, if any.
                echo 'testing nifi workflow'
            }
        }
        
        stage('Deploy to EC2') {
            steps {
                // Add steps here to deploy your NiFi workflows to EC2.
                echo 'deploying to ec2'
            }
        }
    }
}
