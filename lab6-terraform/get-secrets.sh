#!/bin/bash

# === [1] Задати HCP Vault облікові дані ===
# (Або експортуй ці значення перед запуском скрипта)
export HCP_CLIENT_ID="eNA7uf8auzIPQpUXy45pP906Q9wN23Pr"
export HCP_CLIENT_SECRET="fI3yAdW49sIyxL3IyQJjZWb-Fj98_Iyee2TGftTwbl8wcfFYJCE3Syi9RAOgT_GE"

# === [2] Отримати Access Token з HCP ===
echo "🔐 Requesting HCP Vault API token..."
HCP_API_TOKEN=$(curl -s --location "https://auth.idp.hashicorp.com/oauth2/token" \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "client_id=$HCP_CLIENT_ID" \
  --data-urlencode "client_secret=$HCP_CLIENT_SECRET" \
  --data-urlencode "grant_type=client_credentials" \
  --data-urlencode "audience=https://api.hashicorp.cloud" | jq -r .access_token)

if [[ -z "$HCP_API_TOKEN" || "$HCP_API_TOKEN" == "null" ]]; then
  echo "❌ Failed to obtain HCP API token."
  exit 1
fi

echo "✅ HCP API token obtained."

# === [3] Витягти секрети з Vault ===
ORG_ID="8e3a273d-fdd1-422b-b5f7-497e98f0a0e8"
PROJECT_ID="976a857d-2d97-4623-b0ef-108d02b6b50b"
APP_NAME="lab7"

echo "📦 Fetching secrets from HCP Vault..."

SECRETS=$(curl -s --location "https://api.cloud.hashicorp.com/secrets/2023-11-28/organizations/$ORG_ID/projects/$PROJECT_ID/apps/$APP_NAME/secrets:open" \
  --header "Authorization: Bearer $HCP_API_TOKEN")

# Витягти значення секретів з правильного поля
AWS_ACCESS_KEY_ID=$(echo "$SECRETS" | jq -r '.secrets[] | select(.name=="AWS_ACCESS_KEY_ID") | .static_version.value')
AWS_SECRET_ACCESS_KEY=$(echo "$SECRETS" | jq -r '.secrets[] | select(.name=="AWS_SECRET_ACCESS_KEY") | .static_version.value')

if [[ -z "$AWS_ACCESS_KEY_ID" || -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  echo "❌ Помилка: не вдалося отримати AWS ключі з Vault."
  exit 1
fi

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

echo "✅ AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY exported to current shell."

