# Lightweight SOCKS5 Proxy on Railway

این فورک به یک پروکسی SOCKS5 سبک و دارای احراز هویت تبدیل شده است. نسخه قبلی شامل Ubuntu Desktop، XFCE، VNC و Firefox بود؛ همه آن‌ها حذف شده‌اند تا مصرف RAM و CPU بسیار کمتر شود.

## ویژگی‌ها

- Debian Bookworm Slim
- MicroSocks
- SOCKS5 با نام کاربری و رمز عبور
- بدون Desktop / VNC / Firefox
- مناسب استقرار روی Railway با TCP Proxy
- بدون ذخیره رمز در GitHub

## متغیرهای لازم در Railway

در تب `Variables` این مقادیر را بسازید:

```text
PROXY_USER=your_username
PROXY_PASSWORD=use_a_long_random_password
PROXY_PORT=1080
```

نکات امنیتی:

- `PROXY_PASSWORD` باید حداقل 12 کاراکتر باشد.
- نام کاربری و رمز واقعی را داخل Dockerfile یا GitHub Commit نکنید.
- مخزن عمومی است؛ Secrets را فقط در Railway Variables نگهداری کنید.

## Deploy روی Railway

1. در Railway یک پروژه جدید بسازید.
2. گزینه `Deploy from GitHub repo` را انتخاب کنید.
3. مخزن `ahbe0911-cmd/docker-ubuntu-free` را انتخاب کنید.
4. متغیرهای بالا را در `Variables` اضافه کنید.
5. صبر کنید Build و Deploy موفق شود.
6. وارد `Settings > Networking` شوید.
7. `TCP Proxy` را فعال کنید.
8. Internal/Application Port را روی `1080` قرار دهید.
9. Railway یک Host و Port خارجی در اختیار شما قرار می‌دهد.

نمونه خروجی Railway:

```text
Host: example.proxy.rlwy.net
Port: 12345
```

اتصال SOCKS5:

```text
Server: example.proxy.rlwy.net
Port: 12345
Username: مقدار PROXY_USER
Password: مقدار PROXY_PASSWORD
```

توجه: پورت خارجی Railway معمولاً با `1080` یکی نیست. در کلاینت باید همان پورت خارجی نمایش‌داده‌شده توسط Railway را وارد کنید.

## تست

از سیستمی که curl دارد:

```bash
curl --socks5-hostname USER:PASSWORD@HOST:PORT https://api.ipify.org
```

`USER`، `PASSWORD`، `HOST` و `PORT` را با اطلاعات واقعی خود جایگزین کنید.

## محدودیت

MicroSocks در این تنظیم برای ترافیک TCP استفاده می‌شود و UDP را ارائه نمی‌کند. هزینه، اعتبار، محدودیت منابع و محدودیت شبکه نیز تابع پلن و سیاست فعلی Railway است.
