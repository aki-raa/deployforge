FROM ubuntu:24.04
RUN apt-get update && apt-get install -y python3 curl nonexistent-package-xyz && rm -rf /var/lib/apt/lists/*
COPY app.sh /app.sh
COPY web /web
RUN chmod +x /app.sh
CMD ["/app.sh"]
