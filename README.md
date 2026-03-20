# Nginx DevOps Simbirsoft Task

## Подготовка окружения

- Linux VM с Docker и `docker compose`
- `openssl`
- Открыты `22/tcp`, `80/tcp`, и `443/tcp` на VM для доступа к nginx и SSH.

##  Self-Signed сертификат

Для создания самоподписанного сертификата выполните:

```bash
chmod +x scripts/generate_self_signed.sh
./scripts/generate_self_signed.sh
```

Проверьте наличие сертификата и ключа:

- `nginx/ssl/cert.crt`
- `nginx/ssl/key.pem`

## Сборка и запуск сервиса

```bash
docker compose up -d --build
```
VM будет слушать порты `80` и `443` для HTTP и HTTPS соответственно. Nginx внутри контейнера будет работать от имени пользователя `nginxuser`, которому предоставлено право `NET_BIND_SERVICE` для привязки к привилегированным портам без необходимости запуска от root.

## Проверка сервиса

```bash
curl http://<vm-ip>/
curl -k https://<vm-ip>/
docker compose ps
docker compose exec nginx id
```

Ожидаемый результат:

- Оба url `http://<vm-ip>/`  `https://<vm-ip>/` возвращают одну и ту же страницу по условиям задания (редиректов нет).
- На странице отображается `Hello DevOps world!`
- На странице отображается текущее время.
- `docker compose exec nginx id` shows the dedicated `nginxuser`.

## Бэкап конфигурации Nginx

Для сохранения конфигурации Nginx выполните:

```bash
chmod +x scripts/backup_nginx_conf.sh
./scripts/backup_nginx_conf.sh
```

Архив создается в `./backups` и содержит:

- `nginx/nginx.conf`
- `nginx/conf.d`
- `nginx/ssl`

Cron job для автоматического бэкапа каждую неделю в понедельник в 1:00:

```cron
0 1 * * 1 cd /path/to/repo && ./scripts/backup_nginx_conf.sh
```

## Конфигурация брандмауэра

Примините следующие правила для настройки брандмауэра, чтобы разрешить только необходимые порты:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status numbered
```

Ожидаемый результат: только `22/tcp`, `80/tcp`, и `443/tcp` разрешены для входящего трафика.
