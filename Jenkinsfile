pipeline{
	agent any

	environment {
		IMAGE_NAME="hdavid0510/ubuntu-sshd"
		REGISTRY_CREDENTIALS='dockerhub-credential'
		IMAGE_TAG='jammy'
	}

	stages {
		stage('Init') {
			steps {
				echo 'Initializing.'

				echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
				echo "Building ${IMAGE_NAME} on branch ${IMAGE_TAG}"
			}
		}
		stage('Build/Push') {
			steps {
				echo 'Building image and pushing to DockerHub.'

				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
				sh 'docker buildx build --push --platform linux/amd64,linux/i386,linux/arm64,linux/arm/v7,linux/arm/v6 -t $IMAGE_NAME:$IMAGE_TAG .'
			}
		}
		stage('Cleanup') {
			steps {
				echo 'Removing image built.'

				// keep intermediate images as cache, only delete the final image
				sh 'docker rmi $IMAGE_NAME:$IMAGE_TAG'
			}
		}
	}
	post {
		always {
			sh 'docker logout'
		}
	}
}
