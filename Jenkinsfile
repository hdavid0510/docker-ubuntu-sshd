pipeline{
	agent any
	options {
		parallelsAlwaysFailFast()
	}
	environment {
		IMAGE_NAME="hdavid0510/ubuntu-sshd"
		REGISTRY_CREDENTIALS=credentials('dockerhub-credential')
		IMAGE_TAG='focal'
	}

	stages {
		stage('Build images') {
			parallel {
				stage('linux/amd64') {
					steps {
						echo 'Building linux/amd64'
						sh 'docker buildx build --platform linux/amd64 -t $IMAGE_NAME:$IMAGE_TAG-amd64 .'
					}
				}
				stage('linux/arm/v7') {
					steps {
						echo 'Building linux/arm/v7'
						sh 'docker buildx build --platform linux/arm/v7 -t $IMAGE_NAME:$IMAGE_TAG-armv7 .'
					}
				}
				stage('linux/arm64') {
					steps {
						echo 'Building linux/arm64'
						sh 'docker buildx build --platform linux/arm64 -t $IMAGE_NAME:$IMAGE_TAG-arm64 .'
					}
				}
				stage('linux/ppc64le') {
					steps {
						echo 'Building linux/ppc64le'
						sh 'docker buildx build --platform linux/ppc64le -t $IMAGE_NAME:$IMAGE_TAG-ppc64le .'
					}
				}
				stage('linux/s390x') {
					steps {
						echo 'Building linux/s390x'
						sh 'docker buildx build --platform linux/s390x -t $IMAGE_NAME:$IMAGE_TAG-s390x .'
					}
				}
			}
		}
		stage('Push multiarch image') {
			steps {
				echo 'Dockerhub login'
				sh 'echo $REGISTRY_CREDENTIALS_PSW | docker login -u $REGISTRY_CREDENTIALS_USR --password-stdin'
				echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
				echo "Building ${IMAGE_NAME} on branch ${IMAGE_TAG}"
				
				echo 'Pushing image to Dockerhub'
				sh 'docker buildx build --push --platform linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le,linux/s390x -t $IMAGE_NAME:$IMAGE_TAG .'
			}
		}
	}
	post {
		always {
			sh 'docker logout'
		}
	}
}
