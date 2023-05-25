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
        
        // stage('Deploy') {
        //     steps {
        //         // Deploy NiFi workflows to EC2 instance
        //         echo 'copying files to ec2'
        //         sshagent(['ec2_pem']) {
        //             // starting of a shell command block
        //             sh """ 
        //             scp -o StrictHostKeyChecking=no -i /path/to/your/keys my-nifi-flow.xml ec2-user@your-ec2-instance.com:/target/directory/on/ec2
        //             """
        //         }
        //     }
        // }

        stage('Deploy to EC2') {
            steps {
                echo 'connecting to ec2...'
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2_pem', variable: 'EC2_PRIVATE_KEY')]) {
                    sh '''
                        scp -o StrictHostKeyChecking=no -i ${EC2_PRIVATE_KEY} generate_flows.xml ec2-44-204-38-89.compute-1.amazonaws.com:/target/directory/on/ec2
                    '''
                }
            }
}
  
    }
}
