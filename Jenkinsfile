pipeline {
    agent any
	
    stages {
	stage('Clone repository'){
            steps {
                echo 'Running build step'
                echo 'Build step completed'
		checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build("9398607064/nginx-docker")
                }
            }
        }
	stage('docker-compose') {
           steps {
              sh "docker-compose build"
              sh "docker-compose up -d"
              echo 'Running container'
           }
       }

	stage('Docker Push') {
        	agent any
	        steps {
			withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'jyoti@123', usernameVariable: '9398607064')]) {
			sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
			sh 'docker push 9398607064/nginx-docker:latest'
		}
	}
	}
	stage("Deploy") {
            steps {
                sh "sudo rm -rf /usr/share/nginx/html/"
                sh "sudo cp -r ${WORKSPACE}/build/ /usr/share/nginx/html/"
            }
	}
    }
}
