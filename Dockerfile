FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy PDF.js viewer
COPY pdfjs/ /usr/share/nginx/html/pdfjs/

# Copy landing page, custom viewer, and set list
COPY index.html /usr/share/nginx/html/
COPY viewer.html /usr/share/nginx/html/
COPY sets.json /usr/share/nginx/html/

# PDF directory will be mounted as a volume
RUN mkdir -p /usr/share/nginx/html/pdfs

# Custom nginx config for clean caching and mobile headers
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
