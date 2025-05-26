#!/bin/bash

# === [1] Задати HCP Vault облікові дані ===
export HCP_CLIENT_ID="eNA7uf8auzIPQpUXy45pP906Q9wN23Pr"
export HCP_CLIENT_SECRET="fI3yAdW49sIyxL3IyQJjZWb-Fj98_Iyee2TGftTwbl8wcfFYJCE3Syi9RAOgT_GE"

echo "🔐 Отримання секретів з HCP Vault..."
source ./get-secrets.sh

# === [2] Перевірка, чи змінні вже є ===
if [[ -z "$AWS_ACCESS_KEY_ID" || -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  echo "❌ Помилка: не вдалося отримати AWS ключі з Vault."
  exit 1
else
  echo "✅ AWS ключі отримано. Запускаємо Terraform..."
fi

# === [3] Ініціалізація Terraform бекенду ===
terraform init

# === [4] Розгортання інфраструктури ===
terraform apply -auto-approve

