pipeline {
    agent any
	environment { 
		registry = "9398607064/nginx-docker" 
		registryCredential = 'dockerhub_id' 
	}
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
	stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        app.push() 
                    }
                } 
            }
        } 
	/*stage('Docker Push') {
        	agent any
	        steps {
			withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'password', usernameVariable: '9398607064')]) {
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
	}*/
    }
post {
        failure {
              mail to: 'jyotidash246@gmail.com',
                 cc : 'prasenjit.m4u@gmail.com'
                subject: "FAILED: Build ${env.JOB_NAME}", 
                body: "Build failed ${env.JOB_NAME} 
		       build no: ${env.BUILD_NUMBER}.
		  \n\n
		       View the log at:\n ${env.BUILD_URL}
		  \n\n
		       Blue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
    
		success {
            mail to: 'jyotidash246@gmail.com',
                 cc : 'prasenjit.m4u@gmail.com'
                subject: "SUCCESSFUL: Build ${env.JOB_NAME}", 
                body: "Build Successful ${env.JOB_NAME} build no: ${env.BUILD_NUMBER}\n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
        
        aborted {
            mail to: 'jyotidash246@gmail.com',
                 cc : 'prasenjit.m4u@gmail.com'
                subject: "ABORTED: Build ${env.JOB_NAME}", 
                body: "Build was aborted ${env.JOB_NAME} build no: ${env.BUILD_NUMBER}\n\nView the log at:\n ${env.BUILD_URL}\n\nBlue Ocean:\n${env.RUN_DISPLAY_URL}"
        }
	}
}
