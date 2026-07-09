#!/bin/bash

# دریافت مقادیر از متغیرهای Railway
USER=${DASHBOARD_USER:-"admin"}
PASS=${DASHBOARD_PASS:-"admin123"}

echo "Configuring Hermes for user: $USER"
mkdir -p /root/.hermes

# تولید هش پسورد استاندارد با استفاده از bcrypt در پایتون
HASH=$(python3 -c "import bcrypt; print(bcrypt.hashpw(b'${PASS}', bcrypt.gensalt()).decode('utf-8'))")

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
