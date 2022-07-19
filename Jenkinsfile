pipeline{
	agent any

	environment {
		REGISTRY="hdavid0510/ubuntu-sshd"
		REGISTRY_CREDENTIALS='dockerhub-credential'
		TAG='bionic'
	}

	stages {
		stage('Build') {
			steps {
				script {
					docker.image('ubuntu:18.04').inside("""--entrypoint=''""") {
						buildingimage = docker.build(REGISTRY+":"+TAG, "-f Dockerfile ./")
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
