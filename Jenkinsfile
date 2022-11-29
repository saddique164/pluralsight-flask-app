// Uses Declarative syntax to run commands inside a container.
pipeline {
   agent { node { label "master" } }
    environment{
       
		NAME_DEPLOY  = "flask-app"
		NAMESPACE = "apps"
		my_image =  "saddique164/flask"
		build = "${env.BUILD_ID}"
}
    stages {
        stage('check repo connection') {
            steps {
               git credentialsId: 'd243402c-7f0e-4879-b2ec-b2252033b77a', url: 'https://github.com/saddique164/pluralsight-flask-app.git'
              script {

              GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%h'", returnStdout: true)
              echo "${GIT_COMMIT_HASH}"
                  
              }
            }      
        }
        stage ('build the python code'){
        steps { 
            git credentialsId: 'd243402c-7f0e-4879-b2ec-b2252033b77a', url: 'https://github.com/saddique164/pluralsight-flask-app.git'
            sh 'pip3 install -r ${WORKSPACE}//app//requirements.txt'
        }
        
    }

    stage ("build and push docker image") {steps{
         
        script {
    
           docker.withRegistry('https://registry.hub.docker.com', 'd243402c-7f0e-4879-b2ec-b2252033b77a') {
           def customImage = docker.build("saddique164/flask:v-${build}")

        /* Push the container to the custom Registry */
           customImage.push()
		}
		sh 'docker rmi -f  saddique164/flask:v-${build}'
		
}}}
    stage ("deploy on kubernetes"){steps{
        
        sh  '''
        echo "${my_image}"      
        PATCH_TO_DEPLOY={\\"metadata\\":{\\"labels\\":{\\"version\\":\\"${build}\\"}},\\"spec\\":{\\"template\\":{\\"metadata\\":{\\"labels\\":{\\"version\\":\\"${build}\\"}},\\"spec\\":{\\"containers\\":[{\\"name\\":\\"$NAME_DEPLOY\\",\\"image\\":\\"${my_image}:v-${build}\\"}]}}}}
                    
        kubectl patch deployment $NAME_DEPLOY  -n $NAMESPACE -p $PATCH_TO_DEPLOY 

    '''
        }}
}
}