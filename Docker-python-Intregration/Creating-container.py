import subprocess
image = input("Enter image name")
container_name = input("Enter some name for the container : ")
detach = input("Do you want to run in detached mode Y/N : ")
if detach == 'Y':
    subprocess.call ("docker run --name %s -d -P %s"%(container_name,image),shell=True)
elif detach == 'N':
    subprocess.call ("docker run --name %s -P %s"%(container_name,image),shell=True)
else:
    print("invalid option")

    
#to run this programme
# python Creating-container.py
# enter image name
# enter container name
# enter detached mode