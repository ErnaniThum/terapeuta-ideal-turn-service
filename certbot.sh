
echo "Starting nginx and certbot containers..."

NGINX_PID= $(docker run -d \
  --name nginx \
  -p 80:80 \
  -p 443:443 \
  -v ./default.conf:/etc/nginx/conf.d/default.conf \
  -v ./letsencrypt:/etc/letsencrypt \
  -v ./certbot:/var/www/certbot \
  nginx:latest)

echo "Obtaining SSL certificates with Certbot..."
docker run -it --rm --name certbot \
            -v "/etc/letsencrypt:/etc/letsencrypt" \
            -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
            certbot/certbot certonly


echo "Stopping nginx container..."
docker stop $NGINX_PID
docker rm $NGINX_PID