#!/usr/bin/env groovy
 
node {
    withEnv(["LT_USERNAME=Your LambdaTest UserName",
    "LT_ACCESS_KEY=Your LambdaTest Access Key",
    "LT_TUNNEL=true"]){
 
    echo env.LT_USERNAME
    echo env.LT_ACCESS_KEY 
    
   stage('setup') { 
   
      // Get some code from a GitHub repository
    try{
      git 'https://github.com/kostyanius/the-example-app.py.git'
 
      //Download Tunnel Binary
      sh "wget https://s3.amazonaws.com/lambda-tunnel/LT_Linux.zip"
    }
    catch (err){
      echo err
   }
    
   }
   stage('build') {
      sh 'docker build . -t contentful'
    }

    stage('run') {
       sh 'docker run --name contentful -p 0.0.0.0:3000:3000 -d contentful'
       sh 'docker-compose -f docker-compose.yml up -d'

   }
   
    stage('status') {
       sh 'sleep 10 && curl  --request GET http://localhost:4444/status'
       sh 'curl -I http://localhost:4444/wd/hub/status'
   }
   
   stage('test') {
       sh 'docker exec contentful /usr/bin/bash -c "cd / && python3 -m nose --verbosity=3 -x --with-xunit"'
   }
   
   stage('webhook.dite') {
       sh 'docker exec contentful /usr/bin/bash -c "curl -X POST -d @/nosetests.xml https://webhook.site/aeeb7a47-a527-4150-bc65-627be9fe93a2"'
   }
   
 }
}
