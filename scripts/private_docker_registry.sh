mkdir $SOME_DIR

wget -q https://github.com/docker/distribution/archive/v2.0.0.tar.gz

tar -xvf v2.0.0.tar.gz

cd distribution-2.0.0 && mkdir certs

openssl req -newkey rsa:2048 -nodes -keyout certs/registery.key -x509 -days 730 -out certs/registery.crt

# update config file of the registry

docker build -t docker_registry .
docker run -p 5000:5000 -v /var/spool/registry:<host_dir> docker_registry:latest


Since we are using a self-signed certificate, we need to configure any Docker client
that wishes to use this repository to recognize the new certificate. On each Docker
client, copy the registry.crt into /etc/docker/certs.d/<<registrydoma
in>>:<<registryport>>/ca.crt . Ensure that you replace registrydomain
with the DNS name of your Docker registry, and the registryport with the port it
will be running on. This will then suppress any warnings you may encounter due to
untrusted certificates.