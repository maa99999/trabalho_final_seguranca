Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"
    # vagrant ssh -c "ip -4 addr show | grep inet" (ver endereço da vm)
    config.vm.network "public_network"
  
    config.vm.synced_folder ".", "/vagrant"
    
    config.vm.provision "shell", inline: <<-SHELL
  
      sudo apt-get update
      sudo apt-get upgrade -y
      sudo apt-get install apt-transport-https ca-certificates curl software-properties-common wget -y
  
      echo "y" | sudo ufw enable
      sudo ufw allow OpenSSH
      sudo ufw allow 80/tcp  
      sudo ufw allow 443/tcp
      sudo ufw status
    
      # Adicionar chave GPG do Docker e configurar repositório
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
      sudo apt-get update
      sudo apt-get install docker-ce docker-ce-cli containerd.io -y
  
      sudo apt-get install docker-compose-plugin -y
    
      # permissões no Docker
      sudo usermod -aG docker vagrant
    
      sudo systemctl enable docker
      sudo systemctl start docker
    
      mkdir -p /tmp/g1_globo 
      wget -r -l1 --no-parent --no-check-certificate --convert-links --timestamping -P /tmp/g1_globo https://g1.globo.com/go/goias/
    
      # copiar  docker-compose.yml
      if [ -f /vagrant/docker-compose.yml ]; then
        echo "Arquivo docker-compose.yml encontrado. Copiando para /tmp..."
        cp /vagrant/docker-compose.yml /tmp/docker-compose.yml
        cd /tmp
        # Iniciar os containers usando
        sudo docker compose up -d
      else
        echo "Arquivo docker-compose.yml não encontrado em /vagrant. Certifique-se de que ele está na mesma pasta do Vagrantfile."
      fi
    SHELL
  end
  