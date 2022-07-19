pipeline{
	agent{
		dockerfile true
	}

	environment {
		REGISTRY="hdavid0510/ubuntu-sshd"
		REGISTRY_CREDENTIALS='dockerhub-credential'
		TAG='jammy'
	}

	stages {

		stage('Build') {
			steps {
				script {
					def image = docker.build(REGISTRY+":"+TAG, "-f Dockerfile ./")
				}
			}
		}

		stage('Push') {
			steps {
				script {
					docker.withRegistry('', REGISTRY_CREDENTIALS){
						image.push(TAG)
					}
				}
			}
		}
	}
	// post {
	// 	always {
	// 		sh "docker rmi $REGISTRY:$TAG"
	// 	}
	// }
}
