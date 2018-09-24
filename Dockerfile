FROM nginx:mainline

COPY dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/
RUN touch /etc/nginx/nginx.conf \
    && chmod -R g+w /var/run \
    && chmod -R g+w /etc/nginx \
    && chmod -R g+w /var/cache/nginx \
    && chmod 775 /var/cache/nginx \
    && chmod -R g+w /usr/share/nginx/html \
    && chmod 775 /usr/share/nginx/html \
    && chmod -R g+w /var/log/nginx
