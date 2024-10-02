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
