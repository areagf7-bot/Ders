#!/bin/bash

# دریافت مقادیر از متغیرهای Railway (اگر تنظیم نشده باشند از admin استفاده می‌کند)
USER=${DASHBOARD_USER:-"admin"}
PASS=${DASHBOARD_PASS:-"admin123"}

echo "Generating config and hashing password for user: $USER"
mkdir -p /root/.hermes
cd /root/.hermes

# اجرای ماژول پایتونِ هرمس برای هش کردن رمز عبور
HASH=$(python3 -c "from plugins.dashboard_auth.basic import hash_password; print(hash_password('${PASS}'))")

# ساخت فایل کانفیگ امنیتی هرمس
echo "dashboard:" > /root/.hermes/config.yaml
echo "  basic_auth:" >> /root/.hermes/config.yaml
echo "    username: $USER" >> /root/.hermes/config.yaml
echo "    password_hash: $HASH" >> /root/.hermes/config.yaml

echo "Starting Hermes Dashboard..."
# اجرای برنامه
exec hermes dashboard --host 0.0.0.0 --port ${PORT:-12000}
