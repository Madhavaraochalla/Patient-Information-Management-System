import subprocess
image = input ("Enter the image name to download")
subprocess.call("docker rmi %s"%image,shell=True)



# to run this programme
# python Delete-different-images.py