pipeline {
    agent any
	environment { 
		registry = "9398607064/nginx-docker" 
		/*registry = "9398607064/nginx-dockerv1"*/
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
		/*    app = docker.build("9398607064/nginx-dockerv1")*/
                }
            }
        }
	stage('docker-compose') {
           steps {
           /* sh "docker-compose build"*/
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
    
post {  
         success {  
             sh "echo This will run only if successful"
	     mail to:"jyotidash246@gmail.com, prasenjit.m4u@gmail.com",
		     subject:"SUCCESS:${currentBuild.fullDisplayName}",
		     body:"yaa we pass..."
		 
         }  
	failure {  
             sh "echo This will run only if successful"
	     mail to:"jyotidash246@gmail.com",
		     subject:"FAILURE:${currentBuild.fullDisplayName}",
		     body:"failll..."
         }  
         
 }
}
