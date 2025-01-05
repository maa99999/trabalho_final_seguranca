#  Trabalho Final de Segurança da Informação - Planejamento e Configuração de Hardware e Software para Servidor com Hospedagem de Portal de Notícias  

A estimativa de acesso para portais de notícias no Estado de Goiás é próximo de 17 milhões  visualizações de páginas por mês, de acordo com o Jornal Opção. Contabilizando a estimativa por segundo, chega próximo a 16 requisições por segundo. Para realizar o planejamento do hardware necessário para fornecer esse serviço, é necessário utilizar as especificações que serão mencionadas na próxima seção.

## 1. Planejamento de Hardware  

### Estimativa de Acessos  
- **Acesso mensal**: Aproximadamente 17 milhões visualizações.  
- **Requisições por segundo**: Cerca de 16, com base na divisão média.  

### Especificações do Hardware  

#### **Servidor Dell PowerEdge T360**  
- **Tipo**: Servidor torre.  
- **Processador**: Intel® Xeon® E-2400, ideal para alto desempenho em aplicativos com uso intenso de dados.  
- **Memória**: DDR5 com 4.400 MT/s para maior velocidade.
               32GB UDIMM, 4800MT/s, Dual Rank, BCC 
- **Armazenamento**: NVMe BOSS-N1 para menor latência e excelente escalabilidade.  
- **Outros recursos**:  
  - Fonte de alimentação eficiente.  
  - Armazenamento hot plug.  
  - Ventiladores de refrigeração a ar.  
- **Aplicações típicas**:  
  - Hospedagem web.  

**Valor estimado**: R$ 9.499,00  

---

## 2. Instalação e Configuração do Sistema Operacional  

### Sistema Operacional Utilizado  

- **SO**: Ubuntu 22.04.5 LTS
- **Como**: A box do vagrant é responsável por instalar o sistema operacional e criar a máquina virtual

## 3. Implementação de Hardening no Servidor

## **Firewall**: 

## Papel do UFW
O **Uncomplicated Firewall (UFW)** é uma ferramenta de firewall no Linux que facilita o gerenciamento de regras de segurança, oferecendo uma interface simples para controlar o tráfego de rede.

### Funções principais:
- Configurar regras para tráfego de entrada e saída.
- Simplificar o uso do iptables.
- Garantir a segurança de servidores e redes com comandos intuitivos.

## Comandos úteis:

```bash
sudo ufw status



