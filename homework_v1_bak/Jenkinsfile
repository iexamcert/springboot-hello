node('test-jnlp') {
    stage('Clone') {
        echo "1.Clone Stage"
        git url: "https://github.com/iexamcert/springboot-hello.git"
        script {
            build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
        }
    }
    def mvnHome = tool 'maven3.5.3'
    env.PATH = "${mvnHome}/bin:${env.PATH}"
    stage('Mvn') {
        sh "mvn clean install -Dmaven.test.skip=true"
    }
    JAR_BASE_NAME = sh(label: '', returnStdout: true, script: 'grep artifactId pom.xml |awk -F ">" \'{print $2}\' | awk -F "<" \'{print $1}\'|head -1').trim()
    JAR_VERSION = sh(label: '', returnStdout: true, script: 'grep version pom.xml |awk -F ">" \'{print $2}\' | awk -F "<" \'{print $1}\'|sed -n \'2p\'').trim()

    String JAR_NAME = "${JAR_BASE_NAME}" + "-" + "${JAR_VERSION}" + ".jar"
    stage('Build') {
        echo "3.Build Docker Image Stage"
        sh "cp Dockerfile.bak Dockerfile"
        sh "sed -i  's#JAR_NAME#${JAR_NAME}#g' Dockerfile"
        sh "docker build -t iexamcert/springboot-hello:${build_tag} ."
    }
    stage('Push') {
        echo "4.Push Docker Image Stage"
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
            sh "docker login -u ${dockerHubUser} -p ${dockerHubPassword}"
            sh "docker push iexamcert/springboot-hello:${build_tag}"
        }
    }
    stage('Deploy') {
        echo "5. Deploy Stage"
        // def userInput = input(
        //     id: 'userInput',
        //     message: 'Choose a deploy environment',
        //     parameters: [
        //         [
        //             $class: 'ChoiceParameterDefinition',
        //             choices: "Dev\nQA\nProd",
        //             name: 'Env'
        //         ]
        //     ]
        // )
        // echo "This is a deploy step to ${userInput}"
        // sh "sed -i 's/<BUILD_TAG>/${build_tag}/' k8s.yaml"
        // if (userInput == "Dev") {
        //     // deploy dev stuff
        //     sh "sed -i 's/<BRANCH_NAME>/Dev/' k8s.yaml"
        // } else if (userInput == "QA"){
        //     // deploy qa stuff
        //     sh "sed -i 's/<BRANCH_NAME>/QA/' k8s.yaml"
        // } else {
        //     // deploy prod stuff
        // }
        sh "sed -i 's/<BUILD_TAG>/${build_tag}/' k8s.yaml"
        sh "cat k8s.yaml"
        sh "curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin/kubectl"
        sh "kubectl apply -f k8s.yaml"
    }
}
