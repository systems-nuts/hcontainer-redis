# Use an official Python runtime as a parent image
FROM scratch

# Set the working directory to /app
WORKDIR /app

COPY . /app

EXPOSE 6379

STOPSIGNAL SIGTERM

CMD ["./pinit", "./redis-server", "/app/redis.conf"]
