#!/bin/bash
webhook="https://microsoft.webhook.office.com/webhookb2/ffbf6840-6424-4e92-9406-5a217624ba90@72f988bf-86f1-41af-91ab-2d7cd011db47/IncomingWebhook/7984c4399fef4c21b8519bda5edac739/db40402c-aac5-4b79-9712-80d427ac2aed"

header="Content-Type: application/json"
message="$@"
if [ -z "$message" ]; then message="What\'s up Doc?"; fi
text="{'text': '$message'}"
curl -H "$header" -d "$text" "$webhook" 2>/dev/null 1>&2

exit 0

