def runTests() {
    echo "Testing the application ..."
    echo "Executing the piplein for branch $BRANCH_NAME"
    sh 'mvn test'
}

def buildJar() {
    echo "building the application ..."
    sh 'mvn package'
}

def buildImage() {
    echo "building the docker image ..."
    withCredentials([usernamePassword(credentialsId: 'dockerhub-pat', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) 
        {
             sh 'docker build -t $DOCKERHUB_USERNAME/demo-app:jma-1.2 .'
             sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
             sh 'docker push $DOCKERHUB_USERNAME/demo-app:jma-1.2'
        }
}

def deployApp() {
    echo "deploying the application.... "
}

return this