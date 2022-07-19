pipeline{
	agent any

	environment {
		REGISTRY="hdavid0510/ubuntu-sshd"
		REGISTRY_CREDENTIALS='dockerhub-credential'
	}

	stages {

		stage('Build') {
			steps {
				script {
					def imagebionic = docker.build(REGISTRY + ":bionic", "-f Dockerfile.bionic ./")
					def imagefocal = docker.build(REGISTRY + ":focal", "-f Dockerfile.focal ./")
					def imagejammy = docker.build(REGISTRY + ":jammy", "-f Dockerfile.jammy ./")
				}
			}
		}

		stage('Push') {
			steps {
				script {
					docker.withRegistry('', REGISTRY_CREDENTIALS ){
						imagebionic.push('bionic')
						imagefocal.push('focal')
						imagejammy.push('jammy')
						imagejammy.push('latest')
					}
				}
			}
		}
		
	}

	post {
		always {
			sh "docker rmi $REGISTRY:latest"
			sh "docker rmi $REGISTRY:bionic"
			sh "docker rmi $REGISTRY:jammy"
			sh "docker rmi $REGISTRY:focal"
		}
	}
}
