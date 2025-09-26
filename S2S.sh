#!/usr/bin/env bash

printf '\n\n\n'

read -rsn1 -p "Press any key to see imscli configuration"; printf '\n\n\n'

#grep -f s2s.yaml -v secret
sed 's/^clientSecret:.*/clientSecret: xxxxxxxxxxxxxxxxxxx/' s2s.yaml

read -rsn1 -p "Press any key to obtain and decode an IMS access token"; printf '\n\n\n'

export IMS_TOKEN=$(imscli authz clientCredentials -f s2s.yaml)

imscli decode | jq . 2>/dev/null

printf '\n\n\n'

read -rsn1 -p "Press any key to send the API request"; printf '\n\n\n'

API_URL="https://author-p15854-e300181.adobeaemcloud.com/adobe/sites"
API_PATH="/cf/fragments?references=direct-hydrated&projection=full"

curl -w "\n\nSTATUS_CODE: %{http_code}\n" -H "Authorization: Bearer $IMS_TOKEN"  $API_URL$API_PATH

printf '\n\n\n'
