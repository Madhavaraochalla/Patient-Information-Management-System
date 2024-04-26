import subprocess
subprocess.call ('docker rm-f $(docker container ls | grep catalina | cut -d "" f1)',shell=True)



#to run this programme 
# python Delete-all-tomcat-containers.py


# This programme will delete only tomcat container 