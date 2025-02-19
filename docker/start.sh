#!/bin/sh
set -e

echo "[$(date)] Starting initialization..."

# 确保目录权限正确
echo "Setting up permissions..."
mkdir -p /app/runtime

# 更改除 /app/.env 的文件权限
find /app -path /app/.env -prune -o -exec chown www-data:www-data {} \;

# 读取 .env 文件并导出环境变量
if [ -f /app/.env ]; then
    echo "Loading environment variables from .env file..."
    export $(grep -v '^#' /app/.env | grep -E '^[A-Za-z_][A-Za-z0-9_]*=.*$' | xargs)
else
    echo ".env file not found, skipping environment variable loading"
fi

chmod -R 755 /app/runtime

# 运行数据库迁移
# 检查是否存在迁移文件
if [ -d "/app/database/migrations" ] && [ "$(ls -A /app/database/migrations)" ]; then
    echo "Running database migrations..."
    php think migrate:run
else
    echo "No migrations found, skipping migration step"
fi

# 启动PHP-FPM
echo "Starting PHP-FPM..."
php-fpm -D

# 启动GatewayWorker
echo "Starting GatewayWorker..."
php /app/server.php start -d

# 启动Nginx
echo "Starting Nginx..."
nginx -g "daemon off;"