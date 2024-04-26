import subprocess
i=1
while i<= 5:
    subprocess.call("docker network create -- deriver bridge madhav%d",shell=True)
               # creates 5 Networks and its naming comming like 1,2,3,4,5.
    subprocess.call("docker run --name n%d -d -P --network madhav%d nginx" %(i,i),shell=True)
               # creates 5 Container under those Networks and its naming comming like 1,2,3,4,5.





# to run this programme 
# python while-loop.py