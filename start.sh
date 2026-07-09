#!/bin/bash

# دریافت مقادیر از متغیرهای Railway
USER=${DASHBOARD_USER:-"admin"}
PASS=${DASHBOARD_PASS:-"admin123"}

echo "Configuring Hermes for user: $USER"
mkdir -p /root/.hermes

# پیدا کردن دایرکتوری اصلی نصب هرمس (معمولاً در این مسیر نصب می‌شود)
HERMES_DIR=$(dirname $(which hermes))/../lib/node_modules/hermes-agent 2>/dev/null || echo "/root/.hermes"

# تولید هش پسورد با رفتن به مسیر اصلی برنامه
HASH=$(cd $HERMES_DIR && python3 -c "from plugins.dashboard_auth.basic import hash_password; print(hash_password('${PASS}'))")

# ساخت فایل کانفیگ امنیتی هرمس
cat <<EOF > /root/.hermes/config.yaml
dashboard:
  basic_auth:
    username: "$USER"
    password_hash: "$HASH"
EOF

echo "Starting Hermes Dashboard on port ${PORT:-12000}..."
# اجرای برنامه
exec hermes dashboard --host 0.0.0.0 --port ${PORT:-12000}
