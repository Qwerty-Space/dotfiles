#!/usr/bin/env bash
set -euo pipefail
# Request superuser privileges upfront

if [ "$EUID" -ne 0 ]; then
  sudo -v || { echo "sudo authentication failed"; exit 1; }
  exec sudo bash "$0" "$@"  echo "  sudo $0"
fi

cat > /etc/greetd/sway-config <<'EOF'
exec "foot -- tuigreet --astreisks --cmd 'startx /home/qwerty/.xinitrc'; swaymsg exit"
EOF
