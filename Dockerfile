FROM 4km3/dnsmasq:2.90-r3-alpine-latest@sha256:ceb4662c877875dcb29f706c498624a64edcb17d6ea4402086dd1aa33c123417

RUN apk add --no-cache curl

COPY update_blocked_hosts.sh /update_blocked_hosts.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /update_blocked_hosts.sh \
 && chmod +x /entrypoint.sh \
 && mkdir -p /var/spool/cron/crontabs \
 && echo '0 3 * * * /update_blocked_hosts.sh' \
    > /var/spool/cron/crontabs/root \
 && chmod 0644 /var/spool/cron/crontabs/root \
 && echo 'addn-hosts=/blocked_hosts' > /etc/dnsmasq.conf \
 && echo 'conf-file=/dnsmasq.conf' >> /etc/dnsmasq.conf

ENTRYPOINT ["/entrypoint.sh"]