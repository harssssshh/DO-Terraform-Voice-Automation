FROM ubuntu
ENV TZ=Asia/Kolkata
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y python3 sox libsox-fmt-all python3-pip alsa-base alsa-utils lsb-release curl 
RUN apt-get install -y software-properties-common
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install terraform
RUN apt-get install -y python3-gst-1.0
RUN apt-get install -y  qjackctl pulseaudio-module-jack
RUN apt-get install -y libasound-dev portaudio19-dev libportaudio2 libportaudiocpp0 
COPY ./requirements.txt /opt/requirements.txt
WORKDIR /opt
RUN pip3 install --no-cache-dir -r requirements.txt
COPY ./voiceautomation.py /opt/voiceautomation.py 
COPY ./terraconfig/ /opt/terraconfig/
CMD python3 voiceautomation.py 
