# dnf-automatic-configure

## Setup

curl
```bash
curl -L https://raw.githubusercontent.com/JtMotoX/dnf-automatic-configure/refs/heads/main/install.sh | sh -s -- run
```

wget
```bash
wget -O - https://raw.githubusercontent.com/JtMotoX/dnf-automatic-configure/refs/heads/main/install.sh | sh -s -- run
```

## Useful Commands

List Timers

```bash
sudo systemctl list-timers dnf-automatic.timer
```

Manually Trigger

```bash
sudo systemctl start dnf-automatic.service
```

View Logs

```bash
sudo journalctl -u dnf-automatic.service -f
```

Check if successful run within past 48h

```bash
if [ $(date -d"$(sudo journalctl -u dnf-automatic.service 2>/dev/null | grep 'Deactivated successfully' | tail -n1 | awk '{print $1,$2}')" +%s 2>/dev/null) -ge $(date -d'2 days ago' +%s) ] 2>/dev/null; then echo 'Successfully ran within the past 24 hours.'; else echo 'Did not complete within the past 24 hours.'; fi
```

Check if reboot is required

```bash
sudo needs-restarting -r
```
