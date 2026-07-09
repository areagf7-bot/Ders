#!/bin/bash

# دریافت مقادیر از متغیرهای Railway
USER=${DASHBOARD_USER:-"admin"}
PASS=${DASHBOARD_PASS:-"admin123"}

echo "Configuring Hermes for user: $USER"
mkdir -p /root/.hermes

# ساخت فایل کانفیگ بدون نیاز به پکیج‌های جانبی و به صورت کاملاً سازگار
cat <<EOF > /root/.hermes/config.yaml
dashboard:
  basic_auth:
    username: "$USER"
    password: "$PASS"
EOF

echo "Starting Hermes Dashboard on port ${PORT:-12000}..."
# اجرای برنامه
exec hermes dashboard --host 0.0.0.0 --port ${PORT:-12000}
