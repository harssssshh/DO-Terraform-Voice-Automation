FROM ubuntu #Base Image
ENV TZ=Asia/Kolkata # Setting time-Zone for non-interactive installation
ENV DEBIAN_FRONTEND noninteractive #Specifying Non-interactive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone #For Non-Interactive 
RUN apt-get update
RUN apt-get install -y python3 sox libsox-fmt-all python3-pip alsa-base alsa-utils lsb-release curl #Installing alsa & python3 utilities
RUN apt-get install -y software-properties-common 
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - #Adding Terraform GPG Key
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" #Adding Hashicorp Repository 
RUN apt-get update && apt-get install terraform  #Installing Terraform
RUN apt-get install -y python3-gst-1.0 
RUN apt-get install -y  qjackctl pulseaudio-module-jack #Driver modules for ggts
RUN apt-get install -y libasound-dev portaudio19-dev libportaudio2 libportaudiocpp0 #Audio Modules for playback
COPY ./requirements.txt /opt/requirements.txt  
WORKDIR /opt
RUN pip3 install --no-cache-dir -r requirements.txt
COPY ./voiceautomation.py /opt/voiceautomation.py 
COPY ./terraconfig/ /opt/terraconfig/
CMD python3 voiceautomation.py 
