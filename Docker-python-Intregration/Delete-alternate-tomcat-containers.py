# Delete-alternate-tomcat-containers
import subprocess
subprocess.call ('docker container ls | grep #paste-repeted-image-name | cut "" -f 1 > file2', shell=True)
f = open("file2","r")
cont_id = f.readlines()
i = 0
while i < len (cont_ids):
    subprocess.call ("docker rm-f %s"%cont_ids[i],shell=True)
    i = 1+2





#to run this programme 
# python Delete-alternate-tomcat-containers
