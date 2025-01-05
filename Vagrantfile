Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  
  # Configuração de rede pública
  config.vm.network "public_network"

  # Sincronização da pasta atual com a VM
  config.vm.synced_folder ".", "/vagrant"
  
  # Provisionamento com script shell
  config.vm.provision "shell", inline: <<-SHELL
    # Atualizar pacotes e instalar dependências
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common wget xinetd docker-compose-plugin

    # Configuração do firewall UFW
    echo "y" | sudo ufw enable
    sudo ufw allow OpenSSH
    sudo ufw allow 80/tcp  
    sudo ufw allow 443/tcp
    sudo ufw allow 9090/tcp
    sudo ufw status verbose

    # Adicionar chave GPG do Docker e configurar repositório
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    # Configuração de permissões e inicialização do Docker
    sudo usermod -aG docker vagrant
    sudo systemctl enable docker
    sudo systemctl start docker

    # Baixar conteúdo de exemplo
    mkdir -p /tmp/g1_globo 
    wget -r -l1 --no-parent --no-check-certificate --convert-links --timestamping -P /tmp/g1_globo https://g1.globo.com/go/goias/
  
    # Configuração do Docker Compose
    if [ -f /vagrant/docker-compose.yml ]; then
      echo "Arquivo docker-compose.yml encontrado. Copiando para /tmp..."
      cp /vagrant/docker-compose.yml /tmp/docker-compose.yml
      cd /tmp
      sudo docker compose up -d
    else
      echo "Arquivo docker-compose.yml não encontrado em /vagrant. Certifique-se de que ele está na mesma pasta do Vagrantfile."
    fi

    # Copiar o script sysinfo.sh para o local apropriado
    if [ -f /vagrant/sysinfo.sh ]; then
      echo "Script sysinfo.sh encontrado. Copiando para /usr/local/bin..."
      sudo cp /vagrant/sysinfo.sh /usr/local/bin/sysinfo.sh
      sudo chmod +x /usr/local/bin/sysinfo.sh
    else
      echo "Script sysinfo.sh não encontrado em /vagrant. Certifique-se de que ele está na mesma pasta do Vagrantfile."
    fi

    # Configurar o serviço no Xinetd
    echo 'service sysinfo' > /etc/xinetd.d/sysinfo
    echo '{' >> /etc/xinetd.d/sysinfo
    echo '    disable         = no' >> /etc/xinetd.d/sysinfo
    echo '    socket_type     = stream' >> /etc/xinetd.d/sysinfo
    echo '    protocol        = tcp' >> /etc/xinetd.d/sysinfo
    echo '    wait            = no' >> /etc/xinetd.d/sysinfo
    echo '    user            = nobody' >> /etc/xinetd.d/sysinfo
    echo '    server          = /usr/local/bin/sysinfo.sh' >> /etc/xinetd.d/sysinfo
    echo '    port            = 9090' >> /etc/xinetd.d/sysinfo
    echo '}' >> /etc/xinetd.d/sysinfo

    # Reiniciar o serviço Xinetd
    sudo systemctl restart xinetd
  SHELL
end
