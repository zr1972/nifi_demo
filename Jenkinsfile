// if you have other code in a repo, it's often good pratice to have the jenkinsfile in the same repo as well

pipeline {
    agent any
    
    stages {
        
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
                bat 'dir' // sh step is not supported on the Windows, use bat instead
            }
        }

        // stage('Deploy to EC2') {
        //     steps {
        //         echo 'connecting to ec2...'
        //         withCredentials([sshUserPrivateKey(credentialsId: 'ec2_pem', keyFileVariable: 'EC2_PRIVATE_KEY')]) {
        //             bat 'scp -i ${EC2_PRIVATE_KEY} generate_flows.xml ec2-44-204-38-89.compute-1.amazonaws.com:/'
        //         }
        //     }
        // }
        // having problems using just sshAgent, keeps telling me file doesn't exist
        // could be that bat and scp don't run together

        stage('Deploy to EC2') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: "ec2",
                            transfers: [
                                sshTransfer(
                                    sourceFiles: "generate_flows.xml", "setup.sh"
                                    remoteDirectory: "/"
                                )
                            ]
                        )
                    ]
                )
            }
        }
  
    }
}
