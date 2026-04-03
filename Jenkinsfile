pipeline {
    agent any

    stages {
        stage('Appliquer state motd') {
            steps {
                sshagent(['salt-ssh']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no root@192.168.78.129 \
                        "mgrctl exec -- salt '*' state.apply motd"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'State motd applique avec succes sur toutes les VMs'
        }
        failure {
            echo 'Erreur application state motd'
        }
    }
}

