import subprocess
subprocess.call("docker network create --driver bridge madhav",shell=True)
                     # Here this command create network called madhav in this programme
subprocess.call("docker run --name -d -e MYSQL_ROOT_PASSWORD=password --network madhav mysql:5",shell=True)
                     # Here this command create docker container under madhav Network called bridge network
subprocess.call("docker run --name w1 -d -P --network=madhav wordpress",shell=True)
                     # Here also creates wordprees container under madhav Network


 # To run this programme 
 # python Multi-container-architure.py                 