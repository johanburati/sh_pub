#!/bin/bash
# Run spectre detection script on remote VMs

#for s in `lh|g u16`; do echo $s:; scp spectre-meltdown-checker.sh $s:; done

for s in `lh|grep -i u16`; do echo -n $s:; ssh $s sudo ./spectre-meltdown-checker.sh --batch text  --cve CVE-2018-3639; done

#u16001:CVE-2018-3639: VULN (Your CPU doesn't support SSBD)
#u16002:CVE-2018-3639: VULN (Your CPU doesn't support SSBD)
#u16003:CVE-2018-3639: VULN (Your CPU doesn't support SSBD)
#u16004:CVE-2018-3639: VULN (Your CPU doesn't support SSBD)
#u16005:CVE-2018-3639: VULN (Your CPU doesn't support SSBD)
exit 0
