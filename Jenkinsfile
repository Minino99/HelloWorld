pipeline {
    agent { label 'jenkins-slave-dind-php' }
    parameters {
        booleanParam(name: 'DO_DEPLOY', defaultValue: false, description: 'Deploy')
    }
    environment {
        DOCKER_HOST = "tcp://192.168.56.10:4243"
        NOMAD_ADDR = "http://192.168.56.10:4646"
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'bin/setup.sh'
            }
        }
        stage('Test') {
            steps {
                sh 'bin/test.sh'
            }
        }
        stage('Package') {
            steps {
                sh 'docker build -t registry.ws.so/apps-hello-world-php .'
                sh 'docker push registry.ws.so/apps-hello-world-php'
            }
        } 
        stage('Deploy') {
        	agent { label 'docker-nomad' }
            when {
		        expression { params.DO_DEPLOY == true }
	        }
            steps {
                echo "requested: ${params.DO_DEPLOY}"
		        sh 'nomad job run helloworld.nomad'
            }
        }
    }
    
    post {
        always {
            junit 'results.xml'
        }
    }
}
