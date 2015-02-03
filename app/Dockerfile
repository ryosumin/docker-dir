FROM google/debian:wheezy
MAINTAINER liao@oneofthem.jp

COPY cross-platform /cross-platform
# Update stuff
# Install Python Setuptools
RUN apt-get update && \
 apt-get --no-install-recommends install -y build-essential python-dev libpq-dev bzip2 wget ca-certificates git supervisor \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Install pip
RUN wget -q -O- https://bitbucket.org/squeaky/portable-pypy/downloads/pypy-2.4-linux_x86_64-portable.tar.bz2 | tar jxvf - \
  && mv pypy-2.4-linux_x86_64-portable /opt/pypy-2.4 \
  && rm -rf *.bz2 && ln -s /opt/pypy-2.4/bin/pypy /usr/bin/pypy \
  && pypy /opt/pypy-2.4/bin/virtualenv-pypy --no-site-packages /opt/pypy-env

#VOLUME ["cross-platform"]
WORKDIR /cross-platform
ADD config /config
RUN ln -s /config/* /etc/supervisor/conf.d/ && ln -s production.cfg.example production.cfg
# Install requirements.txt
RUN bash -c 'source /opt/pypy-env/bin/activate && pip install -r /cross-platform/requirements.txt && pip install -r /cross-platform/requirements.txt --upgrade --allow-external mysql-connector-python && fab setup'
CMD ["supervisord", "-n"]
#CMD ["bash"]

