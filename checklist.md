# Checklist de Entrega — azure-vm-lab

**Projeto:** azure-vm-lab  
**Autor:** rogerio  
**Data:** 2026-02-24

---

## 1. Preparação do ambiente

- [ ] Criar pasta do projeto `azure-vm-lab`
- [ ] Configurar `.gitignore` com: `.vscode/`, `id_rsa`, `id_rsa.pub`, `outputs/`, `images/`
- [ ] Gerar ou ter disponível SSH key (não commitar a chave privada)
- [ ] Ter Azure CLI instalado ou acesso ao Cloud Shell
- [ ] Verificar login no Azure: `az login`

---

## 2. Provisionamento (execução dos passos)

- [ ] Criar Resource Group
  - Comando: `az group create --name devops-na-infra --location eastus`
- [ ] Criar Network Security Group (NSG) e regra SSH
  - Comando: `az network nsg create ...`
  - Comando: `az network nsg rule create ... --destination-port-range 22`
- [ ] Criar VM
  - Comando: `az vm create -g devops-na-infra -n vm-devops-na-infra --image UbuntuLTS --generate-ssh-keys --nsg nsg-devops-na-infra`
- [ ] Executar `templates/post_provision.sh` dentro da VM (se aplicável)

---

## 3. Coleta de evidências e validação

- [ ] Gerar arquivos em `outputs/` (reais ou placeholders)
  - `outputs/az-group-list.txt` — saída de `az group list`
  - `outputs/az-vm-create-output.txt` — saída de `az vm show --show-details`
  - `outputs/az-vm-ip.txt` — saída de `az vm list-ip-addresses`
  - `outputs/cost.txt` — tarifa por hora e cálculos (incluir data)
- [ ] Capturar imagens em `images/` seguindo o passo a passo (cada imagem com legenda e timestamp)
  - Ex.: `Etapa1-nsg-Azure.png`, …, `Etapa19-VM-Funcionamento-PowerShell.png`
- [ ] Testar conectividade SSH e salvar saída (ex.: `uname -a`, `uptime`) em `outputs/` ou `images/`
- [ ] Validar regras do NSG (inbound/outbound) e registrar em `outputs/` ou screenshot
- [ ] Verificar status da VM (`Running`) e IP público visível no Portal ou via `az`

---

## 4. Segurança e conformidade

- [ ] Confirmar que **nenhuma chave privada** foi commitada
- [ ] Adicionar `id_rsa` ao `.gitignore` e remover do índice se já foi commitado (`git rm --cached id_rsa`)
- [ ] Revisar imagens para remover qualquer dado sensível antes de commitar
- [ ] Documentar no README se algum arquivo é *placeholder*

---

## 5. Limpeza e economia

- [ ] Desalocar VM quando não estiver em uso:
  - `az vm deallocate -g devops-na-infra -n vm-devops-na-infra`
- [ ] Deletar Resource Group ao finalizar (se aplicável):
  - `az group delete --name devops-na-infra --yes --no-wait`
- [ ] Confirmar que não há recursos órfãos cobrando na subscription

---

## 6. Controle do repositório e entrega

- [ ] Atualizar `README.md` com objetivo, passos e observações sobre placeholders
- [ ] Incluir `templates/` e `scripts/` com instruções de uso
- [ ] Commitar apenas arquivos não sensíveis:
  - `git add README.md templates scripts outputs (placeholders) images (placeholders)`
  - `git commit -m "Entrega: templates, scripts e evidências (placeholders)"`
- [ ] Gerar tag ou release (opcional) para a entrega final

---

## Observações finais

- Marque cada item com **data** e **responsável** quando concluir.  
- Se algum item for placeholder, registre a razão e a data prevista para substituição por evidência real.
'@ | Out-File -FilePath checklist.md -Encoding UTF8 -Force

## adicionar e commitar (se for um repositório git)

if (Test-Path .git) {
  git add checklist.md
  git commit -m "Adiciona checklist de entrega (24/02/2026)" || Write-Host "Commit falhou (talvez não haja alterações ou usuário não configurado)."
  Write-Host "checklist.md criado e commitado."
} else {
  Write-Host "checklist.md criado. Inicialize um repositório git aqui com 'git init' se quiser commitar."
}
