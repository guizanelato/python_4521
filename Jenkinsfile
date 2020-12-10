pipeline {
    
    agent{
        label "vm-developer"
    }
    
    environment {
        registry = "guizanelato/flask_ex"
        registryCredentials = 'docker_registry'
    }
    
    stages{
        stage('checkout repo'){
            steps{
                cleanWs()
                git "https://github.com/guizanelato/python_4521.git"
            }
        }
        
        stage('build da imagem'){
            steps{
                script{
                    imagem = docker.build(registry + "$BUILD_NUMBER")
                }
                
            }
        }
        stage('testes'){
            steps{
             script{
                 imagem.inside("--name pyapp --network=review03_novarede --ip=200.100.50.88"){
                     sh "python -m unittest tests/teste_rota.py"
                 }             
                 
             }   
            }
            
        }
        
        stage('subir no dockerhub'){
            steps{
                script{
                    docker.withRegistry("", registryCredentials){
                        imagem.push()
                    }
                }
            }
        }

    }

    post{
        cleanup{
            sh "docker image rmi $registry:$BUILD_NUMBER"
        }
    }
    
    
}
