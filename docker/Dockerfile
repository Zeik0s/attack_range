FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && \
    apt-get install --no-install-recommends -y python3 git gpg gpg-agent openssh-client lsb-release python3-pip unzip curl vim software-properties-common && \
    rm -rf /var/lib/apt/lists/* && apt clean

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install

RUN curl -s https://releases.hashicorp.com/terraform/1.4.5/terraform_1.4.5_linux_amd64.zip -o terraform.zip && \
         unzip terraform.zip && \
         mv terraform /usr/local/bin/

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/hashicorp.gpg
RUN apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt update && apt install packer

RUN git clone https://github.com/splunk/attack_range.git
RUN echo 'alias python=python3' >> ~/.bashrc

WORKDIR /attack_range

RUN cd terraform/aws && terraform init
RUN cd terraform/azure && terraform init
RUN pip3 install poetry
RUN poetry install 
RUN pip3 install --upgrade requests
RUN pip3 install azure-cli

COPY docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh
CMD ["./docker-entrypoint.sh"]
