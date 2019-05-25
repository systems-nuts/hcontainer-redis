# Use an official Python runtime as a parent image
FROM scratch

# Set the working directory to /app
WORKDIR /app

COPY . /app

EXPOSE 6379

STOPSIGNAL SIGTERM

ENTRYPOINT ["./pinit", "./redis-benchmark", "-q"]
