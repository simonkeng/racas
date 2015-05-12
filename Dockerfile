FROM bbolt/centos-node-r

USER	root

RUN	useradd -u 1000 -ms /bin/bash runner

RUN	yum -y localinstall http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm && \
	yum install -y postgresql94-devel curl-devel libxml2-devel

COPY	. /home/runner/racas
RUN	 mkdir /home/runner/r_libs
RUN  Rscript -e 'install.packages("racas", repos="file://home/runner/racas/repo", lib = "/home/runner/r_libs")'
RUN  rm -rf /home/runner/racas/repo
