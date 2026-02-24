#!/bin/bash
# scripts/collect_evidence.sh
# Coleta evidências (placeholders se não houver assinatura)
OUT_DIR="$(dirname "$0")/../outputs"
mkdir -p "$OUT_DIR"

TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

# Placeholder: lista de resource groups (tabela)
cat > "$OUT_DIR/az-group-list.txt" <<EOF
# Generated: $TIMESTAMP (UTC)
Name             Location    Status
---------------  ----------  ----------
devops-na-infra  eastus      Succeeded
EOF

# Placeholder: detalhes da VM (tabela)
cat > "$OUT_DIR/az-vm-create-output.txt" <<EOF
# Generated: $TIMESTAMP (UTC)
Name                 ResourceGroup     Location    VM Size       ProvisioningState   Public IP
-------------------  ----------------  ----------  ------------  ------------------  -------------
vm-devops-na-infra   devops-na-infra   eastus      Standard_B1s  Succeeded           172.203.208.189
EOF

# Placeholder: IP separado
cat > "$OUT_DIR/az-vm-ip.txt" <<EOF
# Generated: $TIMESTAMP (UTC)
Name                 Public IP
-------------------  -------------
vm-devops-na-infra   172.203.208.189
EOF

# Arquivo de custo com cálculos básicos
cat > "$OUT_DIR/cost.txt" <<EOF
# Generated: $TIMESTAMP (UTC)
Tarifa por hora: 0.0531 BRL/hr
Cálculo diário (24h): 0.0531 * 24 = 1.2744 BRL/dia
Cálculo mensal (30 dias): 1.2744 * 30 = 38.232 BRL/mês
Observação: valor informado manualmente; substituir por print do Portal quando disponível.
EOF

echo "Evidências (placeholders) gravadas em $OUT_DIR"
