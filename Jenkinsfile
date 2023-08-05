pipeline {
    agent any

    stages {
        stage('1. Git Cloning') {
            steps {
                sh "echo 'Cloning the latest version of the application'"
                git branch: 'master', credentialsId: 'gitCred3', url: 'https://github.com/DinmaMerciBoi/Test.git'
            }
        }
        stage('2. Docker image build') {
            steps {
                sh "echo 'Building Docker Image'"
                sh "docker build -t userapp:$BUILD_ID ."
                sh "echo 'Docker Image build completed successfully'"
            }
        }
        stage('3. Push Docker image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerCred', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh "echo 'Pushing Docker Image to our private DockerHub Repository'"
                    sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
                    sh "docker tag userapp:$BUILD_ID $DOCKER_USER/userapp:$BUILD_ID"
                    sh "docker push $DOCKER_USER/userapp:$BUILD_ID"
                    sh "echo 'Docker Image push completed successfully'"
                }
            }
        }
        stage ('4. SSH Jenkins') {
            steps{
                sshagent(['SSHKube']) {
                    sh 'ssh -o StrictHostKeyChecking=no adminuser@52.170.17.0'
                    sh 'ssh -v adminuser@52.170.17.0'
                }
                withKubeConfig(credentialsId: 'kubernetes-config') {
                    sh ' curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'
                    sh 'chmod u+x ./kubectl'  
                    sh './kubectl apply -f ./test.yml'
                    sh './kubectl get pods'
                }
            }
        }
    }
}

