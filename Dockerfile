FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html
COPY gracias.html /usr/share/nginx/html/gracias.html
COPY privacidad.html /usr/share/nginx/html/privacidad.html
COPY terminos.html /usr/share/nginx/html/terminos.html
COPY contacto.html /usr/share/nginx/html/contacto.html
COPY soporte.html /usr/share/nginx/html/soporte.html
COPY img/ /usr/share/nginx/html/img/

RUN printf 'server {\n\
    listen 80;\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
    \n\
    add_header X-Frame-Options "SAMEORIGIN" always;\n\
    add_header X-Content-Type-Options "nosniff" always;\n\
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;\n\
    \n\
    location = /index.html {\n\
        add_header Cache-Control "no-cache, must-revalidate";\n\
    }\n\
    \n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 80
