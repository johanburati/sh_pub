#!/bin/sh
# CustomScript: Create a file in /tmp with a time stamp
#
# az vm extension set --resource-group $rg --vm-name $vm --name customScript --publisher Microsoft.Azure.Extensions \
# --settings '{"fileUris": ["https://raw.githubusercontent.com/johanburati/ms/master/customscript-test.sh"],"commandToExecute": "./customscript-test.sh"}'
#
touch /tmp/customscript-$(date +"%H%M%S")
