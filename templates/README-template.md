# Projeto: azure-vm-lab

**Objetivo:** Criar e documentar uma VM Linux no Azure com NSG, evidências e scripts reutilizáveis para avaliação.

## Pré-requisitos
- **Azure subscription** (ou usar placeholders se não houver assinatura).
- **Azure CLI** (az) ou acesso ao **Azure Cloud Shell**.
- **SSH key** pública/privada para acesso à VM.
- **Git** para versionamento do repositório.

## Variáveis recomendadas
- **RG**: devops-na-infra
- **LOCATION**: eastus
- **VM_NAME**: vm-devops-na-infra
- **ADMIN_USER**: azureuser
- **PUBLIC_IP**: 172.203.208.189 (placeholder até gerar no Azure)

## Passos rápidos
1. Login:
   az login

2. Criar Resource Group:
   az group create --name devops-na-infra --location eastus

3. Criar Network Security Group e regra SSH:
   az network nsg create -g devops-na-infra -n nsg-devops-na-infra --location eastus
   az network nsg rule create -g devops-na-infra --nsg-name nsg-devops-na-infra -n Allow-SSH --priority 1000 --protocol Tcp --destination-port-range 22 --access Allow --direction Inbound

4. Criar VM:
   az vm create -g devops-na-infra -n vm-devops-na-infra --image UbuntuLTS --size Standard_B1s --admin-username azureuser --generate-ssh-keys --nsg nsg-devops-na-infra --public-ip-sku Standard

5. Coletar evidências
- Com Azure CLI:
  az group list --output table > outputs/az-group-list.txt
  az vm show -g devops-na-infra -n vm-devops-na-infra --show-details --output json > outputs/az-vm-create-output.txt
  az vm list-ip-addresses -g devops-na-infra -n vm-devops-na-infra --output table > outputs/az-vm-ip.txt
- Sem assinatura: execute scripts/collect_evidence.sh para gerar placeholders.

6. Limpeza:
   az vm deallocate -g devops-na-infra -n vm-devops-na-infra
   az group delete --name devops-na-infra --yes --no-wait

## Evidências esperadas (outputs)
- outputs/az-group-list.txt — saída de az group list (tabela ou JSON).
- outputs/az-vm-create-output.txt — saída de az vm show --show-details.
- outputs/az-vm-ip.txt — IP público da VM.
- outputs/cost.txt — cálculo de custo por hora e estimativas mensais.

## Evidências visuais (images) — passo a passo
As imagens devem representar cada etapa executada na ordem cronológica. Sugestão de mapeamento:
- Etapa1-nsg-Azure.png — criação do NSG (overview).
- Etapa2-nsg-Azure.png — continuação da criação do NSG (detalhes).
- Etapa3-nsg-Tags-Azure.png — configuração de tags do NSG.
- Etapa4-nsg-Revisão-Criação-Azure.png — revisão antes de criar o NSG.
- Etapa5-nsg-deploy-sucesso-Azure.png — deploy do NSG concluído.
- Etapa6-nsg-InboundSecurityRules-Azure.png — regras inbound do NSG (Allow-SSH).
- Etapa7-VM-Criacao-Azure.png — início do fluxo de criação da VM.
- Etapa8-VM-EscolhendoCriacao-Azure.png — escolha do método de criação / imagem.
- Etapa9-VM-ConfiguracaoBasic-Azure.png — configuração básica da VM (nome, usuário).
- Etapa10-VM-ConfiguracaoDisks-Azure.png — configuração de discos da VM.
- Etapa11-VM-ConfiguracaoNetworkInterface-Azure.png — interface de rede e associação ao NSG.
- Etapa12-VM-ConfiguracaoManagement-Azure.png — opções de gerenciamento.
- Etapa13-VM-ConfiguracaoMonitoring-Azure.png — configuração de monitoramento.
- Etapa14-VM-ConfiguracaoAdvanced-Azure.png — opções avançadas.
- Etapa15-VM-ConfiguracaoTags-Azure.png — tags aplicadas à VM.
- Etapa16-VM-RevisaoCriacao-Azure.png — revisão antes do deploy da VM.
- Etapa17-MV-IP-Publico-Azure.png — overview mostrando IP público.
- Etapa18-VM-TestandoIP-PowerShell.png — teste de conectividade (PowerShell).
- Etapa19-VM-Funcionamento-PowerShell.png — sessão SSH/PowerShell mostrando comando de verificação.

## Scripts incluídos
- scripts/collect_evidence.sh — gera placeholders ou coleta saídas reais quando az estiver disponível.
- scripts/cleanup.sh — instruções para desalocar ou deletar recursos.
- templates/create_resources.ps1 — modelo PowerShell para criar recursos.
- templates/post_provision.sh — script para rodar dentro da VM.

## Placeholders e substituição
Nota: Os arquivos em outputs/ e images/ podem ser placeholders gerados localmente.
- Indique no topo do README se os arquivos são placeholders e a data de geração.
- Quando tiver assinatura, substitua os placeholders executando os comandos reais e faça commit.

## Cálculo de Custo (exemplo)
- Tarifa por hora: 0.0531 BRL/hr
- Diário (24h): 0.0531 * 24 = 1.2744 BRL/dia
- Mensal (30 dias): 1.2744 * 30 = 38.232 BRL/mês

Inclua outputs/cost.txt com os cálculos e a data da verificação.

## Boas práticas e segurança
- Não inclua chaves privadas, senhas ou tokens no repositório.
- Adicione chaves privadas ao .gitignore.
- Use nomes de recursos com sufixo pessoal para evitar colisões.
- Desalocar ou deletar recursos quando não estiver usando para evitar custos.

## Checklist de entrega
- [ ] README.md preenchido com objetivo e passos.
- [ ] outputs/az-group-list.txt (real ou placeholder).
- [ ] outputs/az-vm-create-output.txt (real ou placeholder).
- [ ] outputs/az-vm-ip.txt (real ou placeholder).
- [ ] outputs/cost.txt com cálculos.
- [ ] images/Etapa1-...Etapa19.png com legendas e timestamps (ou placeholders).
- [ ] scripts/collect_evidence.sh e scripts/cleanup.sh.
- [ ] templates/ com scripts e IaC de exemplo.

## Referências e créditos
- Tutorial base: <link do vídeo ou artigo usado> (incluir timestamp).
- Autor: rogerio
- Data: 2026-02-23

## Observações finais
Substitua placeholders por saídas reais assim que tiver uma assinatura ativa. Documente qualquer divergência entre o ambiente real e os exemplos deste README.
