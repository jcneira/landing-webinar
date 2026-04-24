FROM nginx:alpine

# Copia tu landing
COPY index.html /usr/share/nginx/html/index.html

# Configuración simple con headers de seguridad y caché corto para HTML
RUN printf 'server {\n\
    listen 80;\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
    \n\
    # Headers de seguridad\n\
    add_header X-Frame-Options "SAMEORIGIN" always;\n\
    add_header X-Content-Type-Options "nosniff" always;\n\
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;\n\
    \n\
    # HTML: caché corto para poder iterar sin problemas\n\
    location = /index.html {\n\
        add_header Cache-Control "no-cache, must-revalidate";\n\
    }\n\
    \n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 80
