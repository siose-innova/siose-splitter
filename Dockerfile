FROM sioseinnova/siose-2005:base

###################
# Install geohash #
###################
ENV GEOHASH https://github.com/siose-innova/pg_geohash_extra.git

WORKDIR /install-ext
RUN git clone $GEOHASH
WORKDIR /install-ext/pg_geohash_extra
RUN make
RUN make install
WORKDIR /
RUN rm -rf /install-ext


ADD init-db.sh /docker-entrypoint-initdb.d/init-db.sh
ADD src/sql/split.sql /docker-entrypoint-initdb.d/split.sql
