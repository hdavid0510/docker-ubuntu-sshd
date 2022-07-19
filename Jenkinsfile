pipeline{
	agent any

	environment {
		REGISTRY="hdavid0510/ubuntu-sshd"
		REGISTRY_CREDENTIALS='dockerhub-credential'
		TAG='jammy'
	}

	stages {

		stage('Build') {
			steps {
				script {
					docker.image('ubuntu:22.04').inside("""--entrypoint=''""") {
							def buildingimage = docker.build(REGISTRY+":"+TAG, "-f Dockerfile ./")
					}
				}
			}
		}

		stage('Push') {
			steps {
				script {
					docker.withRegistry('', REGISTRY_CREDENTIALS){
						buildingimage.push(TAG)
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
