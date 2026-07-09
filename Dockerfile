# استفاده از سیستم‌عامل لینوکس
FROM node:18-bullseye

# نصب پیش‌نیازها و پایتون به همراه ابزار بیلد برای پکیج‌های پایتون
RUN apt-get update && apt-get install -y --fix-missing curl bash python3 python3-pip python3-bcrypt

# دانلود و نصب Hermes Agent
RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

# تنظیم مسیر سیستم
ENV PATH="/root/.hermes/bin:${PATH}"

# کپی کردن فایل اسکریپت به داخل سرور
COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh

# اجرای اسکریپت هنگام روشن شدن کانتینر
CMD ["/root/start.sh"]
