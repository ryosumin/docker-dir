FROM google/debian:wheezy
MAINTAINER liao@oneofthem.jp 

# Update stuff
RUN apt-get update

# Install Python Setuptools
RUN apt-get --no-install-recommends install -y python-setuptools build-essential python-dev libpq-dev ca-certificates git supervisor \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Install pip
RUN easy_install pip

#ADD requirements.txt /tmp/requirements.txt
COPY cross-platform /cross-platform
#VOLUME ["cross-platform"]
WORKDIR /cross-platform
# Install requirements.txt
RUN pip install -r /cross-platform/requirements.txt --allow-external mysql-connector-python \
&&  pip install -r /cross-platform/requirements.txt --upgrade --allow-external mysql-connector-python
ADD config /config
RUN ln -s /config/* /etc/supervisor/conf.d/
RUN fab setup
#CMD fab setup && gunicorn -b :8080 --worker-class socketio.sgunicorn.GeventSocketIOWorker wsgi:application
CMD ["supervisord", "-n"]
