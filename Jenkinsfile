    def remote = [:]
    remote.name = 'HP'
    remote.host = '192.168.1.224'
    remote.user = 'vikram'
    remote.password = 'ubuntu'
    remote.allowAnyHosts = true

	pipeline {
    agent any
tools{
    maven "Maven3"
}
    stages {
        stage('Hello') {
            steps {
                git branch: 'main', url: 'https://github.com/vikramshanbogar/CustomersService.git'
            }
        }
            stage('build') {
            steps {
                sh 'mvn clean install'
            }
        }
		stage('Copy file to Remote SSH') {
		     steps {
			sshCommand remote: remote, command: "ls -lrt"
			sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
			writeFile file: 'abc.sh', text: 'ls -lrt'
			sshPut remote: remote, from: '/var/jenkins_home/workspace/HP-SSH1/target/customers-0.0.1-SNAPSHOT.jar', into: '/home/vikram/codebase'
		     }
    }
    		stage('Run app on Remote SSH server') {
		     steps {
			sshCommand remote: remote, command: "ls /home/vikram/codebase"
				sshCommand remote: remote, command: "java -jar /home/vikram/codebase/customers-0.0.1-SNAPSHOT.jar"
		     }
    }
    }
}
