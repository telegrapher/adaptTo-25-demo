#!/usr/bin/env bash

printf '\n\n\n'

read -rsn1 -p "Set up https in port 9999 -> 8888"; printf '\n\n\n'

read -rsn1 -p "Press any key to see imscli configuration"; printf '\n\n\n'

sed 's/^clientSecret:.*/clientSecret: xxxxxxxxxxxxxxxxxxx/' webApp.yaml

read -rsn1 -p "Press any key to obtain and decode an IMS access token"; printf '\n\n\n'

export IMS_TOKEN=$(imscli authz user -f webApp.yaml)

imscli decode | jq . 2>/dev/null

printf '\n\n\n'

read -rsn1 -p "Press any key to send the API request"; printf '\n\n\n'

API_URL="https://author-p15854-e300181.adobeaemcloud.com/adobe/sites"
API_PATH="/cf/fragments?references=direct-hydrated&projection=full"

curl -w "\n\nSTATUS_CODE: %{http_code}\n" -H "Authorization: Bearer $IMS_TOKEN"  $API_URL$API_PATH

printf '\n\n\n'
