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
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build("9398607064/nginx-docker")
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
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
