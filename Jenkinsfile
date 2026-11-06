node{
    
    def tag, dockerHubUser, containerName, httpPort = ""
    
    stage('Prepare Environment'){
        echo 'Initialize Environment'
        tag="3.0"
	withCredentials([usernamePassword(credentialsId: 'dockerHubAccount', usernameVariable: 'dockerUser', passwordVariable: 'dockerPassword')]) {
		dockerHubUser="$dockerUser"
        }
	containerName="bankingapp"
	httpPort="8989"
    }
    
    stage('Code Checkout'){
        try{
            checkout scm
        }
        catch(Exception e){
            echo 'Exception occured in Git Code Checkout Stage'
            currentBuild.result = "FAILURE"
        }
    }
    stage('Maven Build'){
        echo '--- Diagnosing Maven Build ---'
        echo '1. Current Working Directory:'
        sh 'pwd'
        echo '2. Contents of pom.xml:'
        sh 'cat pom.xml' // CRITICAL: This will show us what pom.xml Jenkins is actually using
        echo '3. Java Version on Jenkins Agent:'
        sh 'java -version' // CRITICAL: Confirm the JDK version
        echo '4. Running Maven with debug logging:'
        sh 'mvn clean package -X' // CRITICAL: This will provide verbose output
        echo '--- End Diagnosis ---'
    }
    /*stage('Maven Build'){
        sh "mvn clean package"        
    }*/
    
    stage('Docker Image Build'){
        echo 'Creating Docker image'
        sh "docker buildx build --platform linux/amd64 -t $dockerHubUser/$containerName:$tag --load ."
    }  
	
    stage('Local Docker Deployment'){
    echo 'Deploying application locally'
    sh "docker rm -f $containerName || true"
    sh "docker run -d --name $containerName -p $httpPort:$httpPort $dockerHubUser/$containerName:$tag"
    sh "docker ps"
}

}
