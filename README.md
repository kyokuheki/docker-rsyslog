# docker-rsyslog

## enable syslog forward

```shell
cat <<__EOT__ | sudo tee /etc/systemd/journald.conf.d/99-forward-to-syslog
[Journal]
ForwardToSyslog=yes
__EOT__
sudo systemctl restart systemd-journald
ls -al /run/systemd/journal/syslog
```

## run
```shell
docker run -itd --restart=always -v /run/systemd/journal/:/run/systemd/journal/:ro -h `hostname -f` --name rsyslog kyokuheki/rsyslog
```
