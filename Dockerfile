# استفاده از سیستم‌عامل لینوکس
FROM node:18-bullseye

# نصب پیش‌نیازها و پایتون برای اجرای اسکریپت امنیتی
RUN apt-get update && apt-get install -y --fix-missing curl bash python3 python3-pip

# دانلود و نصب Hermes Agent
RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

# تنظیم مسیر سیستم
ENV PATH="/root/.hermes/bin:${PATH}"

# کپی کردن فایل اسکریپت به داخل سرور و دادن دسترسی اجرا به آن
COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh

# اجرای اسکریپت هنگام روشن شدن کانتینر
CMD ["/root/start.sh"]
