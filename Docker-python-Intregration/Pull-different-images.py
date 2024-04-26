import subprocess
image = input ("Enter the image name to download")
subprocess.call("docker pull %s"%image,shell=True)





# to run this programme
# python Pull-different-images.py