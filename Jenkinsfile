pipeline {
    agent any
    
    stages {
        // stage('Pull from GitHub') {
        //     steps {
        //         echo 'pulling from github'
        //     }
        // }
        
        // stage('Test NiFi workflow') {
        //     steps {
        //         // Add steps here to test your NiFi workflows, if any.
        //         echo 'testing nifi workflow'
        //     }
        // }

        stage('Checkout') {
            steps {
                // Checkout your NiFi workflow code from GitHub
                echo 'checking out git code?'
                git branch: 'main', url: 'https://github.com/zr1972/nifi_demo.git'
            }
        }

        stage('List Files') {
            steps {
                sh 'ls -l'
            }
        }

        stage('Deploy to EC2') {
            steps {
                echo 'connecting to ec2...'
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2_pem', keyFileVariable: 'EC2_PRIVATE_KEY')]) {
                    sh 'scp -i ${EC2_PRIVATE_KEY} generate_flows.xml ec2-44-204-38-89.compute-1.amazonaws.com:/'
                }
            }
        }
  
    }
}
