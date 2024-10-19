pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // ID de las credenciales de Docker Hub configuradas en Jenkins
        DOCKER_IMAGE = 'pedro2044/muface:1.0.1' // Imagen que se subirá a Docker Hub
    }

    stages {
        stage('Checkout') {
            steps {
                // Clonar el repositorio
                git 'https://github.com/pdulce/holamundo'
            }
        }
        
        stage('Build') {
            steps {
                // Compilar el proyecto y crear el fat jar
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Crear la imagen Docker
                sh "docker build -t ${DOCKER_IMAGE} --build-arg SPRING_PROFILE=prod ."
            }
        }

        stage('Push Docker Image') {
            steps {
                // Iniciar sesión en Docker Hub
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                }
                // Subir la imagen a Docker Hub
                sh "docker push ${DOCKER_IMAGE}"
            }
        }

        stage('Deploy to Minikube') {
            steps {
                // Desplegar la imagen en Minikube
                sh "kubectl run muface --image=${DOCKER_IMAGE} --port=8081 --restart=Always"
                // Exponer el servicio
                sh "kubectl expose deployment muface --type=NodePort --port=8082"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
