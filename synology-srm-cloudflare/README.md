## Cloudflare DDNS script for Synology SRM

Adopted from https://luvis.se/tipstricks/set-up-dynamic-dns-with-cloudflare-on-synology-dsm-6/ to work in Synology SRM.

```
echo "[Cloudflare]">>/etc/ddns_provider.conf
echo " modulepath=/usr/sbin/cloudflaredns.sh">>/etc/ddns_provider.conf
echo " queryurl=https://www.cloudflare.com/">>/etc/ddns_provider.conf
```
