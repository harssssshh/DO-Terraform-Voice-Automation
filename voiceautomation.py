import speech_recognition as sr
from gtts import gTTS
import os
import subprocess
import shutil
import time
import base64

r = sr.Recognizer()

def  take_input():
    with sr.Microphone() as source:
        text = r.listen(source, timeout=10)
        try:
            recognized_text = r.recognize_google(text)
        except sr.UnknownValueError:
            print("Unknown Resource")
        except sr.RequestError:
            print("Request Error")
        return recognized_text


def respond_audio(audio):
    tts = gTTS(audio, lang='en')
    tts.save('cluster.mp3')
    subprocess.call('play cluster.mp3', shell=True)


def isbase64(token):
    try:
        base64.b64encode(base64.b64decode(token)) == token
        respond_audio(audio="Token seems to be fine")
        setenv(token)
    except Exception:
        respond_audio(audio="Incorrect Token ! Please enter correct token")
        token_input()
        

def token_input():
    token = input("Enter Digitalocean Personal Access Token: ")
    isbase64(token)

def setenv(token):
    do_token = "export TF_VAR_DO_TOKEN=" + token + '\n'
    tfvartoken = 'do_pat =  "{}" \n'.format(token)
    os.chdir("terraconfig")
    tfvar = open("terraform.tfvars", "w")
    tfvar.write(tfvartoken)
    tfvar.close()
    subprocess.call(['chmod', '0777', 'getkubeconfig.sh'])
    src = open("getkubeconfig.sh", "r")
    oline =  src.readlines()
    oline.insert(0, do_token)
    src.close()
    src=open("getkubeconfig.sh","w") 
    src.writelines(oline) 
    src.close()


def logic():
    answer = take_input()
    print(answer)
    if "cluster" in answer:
        respond_audio(audio="Creating Environment, Hold on for a while")
        time.sleep(2)
        respond_audio(audio="First Copy Your Digitalocean Personal Access Token Please") 
        token_input()
    else:
        terraconfig(answer)


def terraconfig(answer):
    if "tu" or "2 notes" or "two notes" or "2 nodes" or "two nodes" in answer:
            print("Creating 2 Nodes Cluster")
            f = open("terraform.tfvars",  "a")
            f.write("nodes_count = " + "2")
            f.close()
    elif "tree" or  "3 notes" or "three notes" or "3 nodes" or "three nodes" or "free" or "free notes" or "free nodes" in answer:
            print("Creating 3 Nodes Cluster")
            f = open("terraform.tfvars",  "a")
            f.write("nodes_count = " + "3")
            f.close()
    else:
            print("Error")
            exit(1)
    subprocess.call(["terraform init"], shell=True )
    subprocess.call(["terraform apply -auto-approve"], shell=True )
    time.sleep(2)
    subprocess.call(["./getkubeconfig.sh"], shell=True )
    respond_audio(audio="Congrats ! Your Kubernetes cluster has been  created")
    
def main():
    respond_audio(audio="Hey ! What would you like me to do ?")
    logic()
    respond_audio(audio="Alright ! How many nodes do you want in your cluster")
    logic()
    print("Copy config file from volume to host using this command")
    print("sudo cp /var/lib/docker/volumes/botcredentials/_data/config ~/.kube/config")

main()
