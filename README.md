<<<<<<< HEAD
﻿# azure-vm-lab

**Objetivo**  
Provisionei uma VM **Ubuntu 20.04** no Azure com **VNet**, **Subnet**, **Public IP** e **NSG**. Este repositório contém templates, scripts e evidências (outputs e imagens) para reproduzir, validar e documentar o lab.

## Pré-requisitos e variáveis recomendadas

## Pré-requisitos

- Azure subscription (ou usar placeholders)
- Azure CLI (`az`) ou Azure Cloud Shell
- SSH key (não commitar a chave privada)
- Git

## Variáveis recomendadas

- **RG**: `devops-na-infra`  
- **LOCATION**: `eastus`  
- **VM_NAME**: `vm-devops-na-infra`  
- **ADMIN_USER**: `azureuser`

---

## Passos rápidos (comandos essenciais)

**1. Login**
az login

**2. Criar Resource Group**
az group create --name devops-na-infra --location eastus

**3. Criar Network Security Group (NSG) e regra SSH**
az network nsg create -g devops-na-infra -n nsg-devops-na-infra --location eastus
az network nsg rule create -g devops-na-infra --nsg-name nsg-devops-na-infra -n Allow-SSH --priority 1000 --protocol Tcp --destination-port-range 22 --access Allow --direction Inbound

**4. Criar VM (Ubuntu 20.04)**
az vm create -g devops-na-infra -n vm-devops-na-infra --image UbuntuLTS --size Standard_B1s --admin-username azureuser --generate-ssh-keys --nsg nsg-devops-na-infra --public-ip-sku Standard

**5. Coletar evidências (exemplos)**
az group list --output table > outputs/az-group-list.txt
az vm show -g devops-na-infra -n vm-devops-na-infra --show-details --output json > outputs/az-vm-create-output.txt
az vm list-ip-addresses -g devops-na-infra -n vm-devops-na-infra --output table > outputs/az-vm-ip.txt

**6. Limpeza**
az vm deallocate -g devops-na-infra -n vm-devops-na-infra
az group delete --name devops-na-infra --yes --no-wait

---

## Evidências e imagens (passo a passo)

**Arquivos esperados em `outputs/`**

- `outputs/az-group-list.txt`  saída de `az group list`  
- `outputs/az-vm-create-output.txt`  saída de `az vm show --show-details`  
- `outputs/az-vm-ip.txt`  IP público da VM  
- `outputs/cost.txt`  cálculo de custo por hora e estimativas mensais (incluir data)

**Imagens em `images/`  cada arquivo representa uma etapa**

- `Etapa1-nsg-Azure.png`  criação do NSG (overview)  
- `Etapa2-nsg-Azure.png`  detalhes do NSG após criação  
- `Etapa3-nsg-Tags-Azure.png`  configuração de tags do NSG  
- `Etapa4-nsg-Revisão-Criação-Azure.png`  revisão antes do deploy do NSG  
- `Etapa5-nsg-deploy-sucesso-Azure.png`  deploy do NSG concluído (Deployment succeeded)  
- `Etapa6-nsg-InboundSecurityRules-Azure.png`  inbound rules (ex.: Allow-SSH)  
- `Etapa7-VM-Criacao-Azure.png`  início do fluxo de criação da VM  
- `Etapa8-VM-EscolhendoCriacao-Azure.png`  escolha de imagem/método de criação  
- `Etapa9-VM-ConfiguracaoBasic-Azure.png`  configuração básica (nome, usuário)  
- `Etapa10-VM-ConfiguracaoDisks-Azure.png`  configuração de discos  
- `Etapa11-VM-ConfiguracaoNetworkInterface-Azure.png`  NIC e associação ao NSG  
- `Etapa12-VM-ConfiguracaoManagement-Azure.png`  opções de gerenciamento (auto-shutdown, backup)  
- `Etapa13-VM-ConfiguracaoMonitoring-Azure.png`  configuração de monitoramento/diagnostics  
- `Etapa14-VM-ConfiguracaoAdvanced-Azure.png`  opções avançadas (extensões, cloud-init)  
- `Etapa15-VM-ConfiguracaoTags-Azure.png`  tags aplicadas à VM  
- `Etapa16-VM-RevisaoCriacao-Azure.png`  revisão antes do deploy da VM  
- `Etapa17-MV-IP-Publico-Azure.png`  overview mostrando IP público atribuído  
- `Etapa18-VM-TestandoIP-PowerShell.png`  teste de conectividade (PowerShell / Test-NetConnection / ping)  
- `Etapa19-VM-Funcionamento-PowerShell.png`  sessão SSH/PowerShell com `uname -a` ou `uptime`

## Boas práticas para capturas

- Inclua **timestamp** no nome do arquivo ou na legenda.  
- Capture contexto (barra do Portal com subscription) sem expor segredos.  
- Recorte para destacar a área relevante, mantendo algum contexto visual.  
- Antes de commitar, revise imagens para remover dados sensíveis.

**Placeholders**  
Se não houver assinatura, gere placeholders em `outputs/` e imagens simples em `images/` e documente no README a data e que são placeholders.

---

## Scripts, templates e segurança

## Scripts incluídos (exemplos)

- `scripts/collect_evidence.sh`  gera placeholders ou coleta saídas reais quando `az` estiver disponível  
- `scripts/cleanup.sh`  desaloca ou deleta recursos (opcional)  
- `templates/create_resources.ps1`  modelo PowerShell para criar recursos  
- `templates/post_provision.sh`  script para rodar dentro da VM (instala utilitários e coleta info)  
- `templates/terraform/`  exemplo mínimo de Terraform (opcional)

**.gitignore recomendado**
.vscode/
id_rsa
id_rsa.pub
outputs/
images/
*.log
*.env

**Importante:** nunca commite chaves privadas. Se uma chave privada já foi comitada, rotacione a chave imediatamente e remova-a do histórico do Git.

---

## Cálculo de custo (exemplo)

- **Tarifa por hora (exemplo):** `0.0531 BRL/hr`  
- **Diário (24h):** `0.0531 * 24 = 1.2744 BRL/dia`  
- **Mensal (30 dias):** `1.2744 * 30 = 38.232 BRL/mês`  

Inclua `outputs/cost.txt` com os cálculos e a **data** da verificação. Preferível capturar print do Portal de Billing em `images/`.

---

## Checklist de entrega (mínimos)

- [X] `README.md` (raiz) atualizado e claro  
- [X] `templates/README-template.md` (detalhado) disponível  
- [X] `outputs/az-group-list.txt` (real ou placeholder)  
- [X] `outputs/az-vm-create-output.txt` (real ou placeholder)  
- [X] `outputs/az-vm-ip.txt` (real ou placeholder)  
- [X] `outputs/cost.txt` com data  
- [X] `images/Etapa1-...-Etapa19.png` (ou placeholders) com legendas/timestamps  
- [X] `scripts/collect_evidence.sh` e `scripts/cleanup.sh`  
- [X] `.gitignore` configurado corretamente  
- [X] `LICENSE` (ex.: MIT) adicionado

---

## Como usar este repositório (rápido)

1. Clone o repositório.  
2. Ajuste variáveis no topo dos scripts/templates conforme necessário.  
3. Execute os comandos essenciais listados na seção **Passos rápidos**.  
4. Rode `scripts/collect_evidence.sh` para gerar outputs (ou cole as saídas reais em `outputs/`).  
5. Substitua placeholders por evidências reais e faça commit.

---

## Referências e contato

- **Autor:** rogerio  
- **Data:** 2026-02-24  
- **Tutorial base / referência:** inclua link e timestamp do vídeo/artigo usado (se aplicável)

---

**Observação final**  
Mantenha `templates/README-template.md` como documento mestre e `README.md` na raiz como a versão executável e enxuta. Substitua placeholders por evidências reais assim que tiver acesso à subscription e documente qualquer divergência.
=======
# azure-vm-lab
Projeto de laboratório: provisionamento de VM no Azure (Ubuntu 22.04). Inclui scripts, template CLI e evidências para entrega DIO.
>>>>>>> b8c0ee74904c71c65d35d4ae9b058a54ea3d4bd7
