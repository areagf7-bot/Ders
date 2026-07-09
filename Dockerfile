# استفاده از سیستم‌عامل لینوکس با نود جی‌اس نصب شده
FROM node:18-bullseye

# نصب پیش‌نیازها
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl bash

# دانلود و نصب Hermes Agent
RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

# تنظیم مسیر سیستم برای شناختن دستور hermes
ENV PATH="/root/.hermes/bin:${PATH}"

# اجرای داشبورد روی پورتی که Railway بتواند آن را اکسپوز کند
CMD ["hermes", "dashboard", "--host", "0.0.0.0", "--port", "12000"]
