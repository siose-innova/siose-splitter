
docker_services: bash gdal dbm pgadmin

docker-compose.yml:
	$(file > $@,$(docker-compose))


define docker-compose

version: '2'

#TODO: write this compose from make variables
#TODO: Use if's for letting specify a list of services
#TODO: In compose v3 we can't use volumes_from

services:

  bash:
    image: sioseinnova/alpine-bash
    container_name: bash
    entrypoint: /bin/sh
#    user: 1000:1000
    stdin_open: true
    tty: true
    working_dir: /outputs
    volumes_from:
      - gdal
    networks:
      - backend
    restart: unless-stopped

  gdal:
    image: sioseinnova/gdal
    container_name: gdal
    entrypoint: /bin/sh
#    user: 1000:1000
    stdin_open: true
    tty: true
    working_dir: /outputs
    volumes:
      - ./outputs:/outputs # Your outputs will be here
    networks:
      - backend
    restart: unless-stopped
#    command: bash -c "ogrinfo -ro "PG:host=dbm dbname=db user=postgres password=postgres" -sql "SELECT * from roi"

  dbm:
    # comment on build if want to use the dockerhub build
#    build:
#      context: .
#      dockerfile: Dockerfile
    image: sioseinnova/siose-2005-geohashed
    container_name: siose-2005-geohashed
    ports:
      - "5433:5432" # redirect to 5433 in case you already have postgres installed
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: db
      PGDATA: /postgresql/data
#    command: postgres -c search_path='public,gh'
    volumes: # named volumes, use compose -v to remove them.
      - postgres_data:/postgresql/data:rw
      - postgres_backups:/postgresql/backups
    networks:
      - backend
    restart: unless-stopped

  pgadmin:
    image: fenglc/pgadmin4:latest
    container_name: pgadmin
    links:
      - dbm
    volumes:
#      - ./.pgadmin4:/var/lib/pgadmin4/data # pgadmin4 user and session data (SQLITE)
      - .:/var/lib/pgadmin4/data/storage/pgadmin4
    ports:
      - "5050:5050"
    environment:
      DEFAULT_USER: pgadmin4@pgadmin.org
      DEFAULT_PASSWORD: admin
    networks:
      - backend
    depends_on:
      - dbm
    restart: unless-stopped

volumes: # named volumes that can be mounted by other containers
  postgres_data:
    driver: local
  postgres_backups:
    driver: local

networks:
  backend:
    driver: bridge

endef


