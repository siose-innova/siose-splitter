
docker_services: bash gdal dbm pgadmin

docker-compose.yml:
	$(file > $@,$(docker-compose))


# TODO: Replace this define by a template
define docker-compose

#TODO: In compose v3 we can't use volumes_from
version: '2'

#TODO: Use if's for letting specify a list of services
services:

  $(PGADMIN_CONTAINER):
    image: $(PGADMIN_IMAGE)
    container_name: $(PGADMIN_CONTAINER)
    links:
      - $(SIOSE_2005_CONTAINER)
    volumes:
      - .:/var/lib/pgadmin4/data/storage/pgadmin4
    ports:
      - "5050:5050"
    environment:
      DEFAULT_USER: pgadmin4@pgadmin.org
      DEFAULT_PASSWORD: admin
    networks:
      - backend
    depends_on:
      - $(SIOSE_2005_CONTAINER)
    restart: unless-stopped

  $(BASH_CONTAINER):
    image: $(BASH_IMAGE)
    container_name: $(BASH_CONTAINER)
    entrypoint: /bin/sh
    stdin_open: true
    tty: true
    working_dir: /outputs
    volumes_from:
      - gdal
    networks:
      - backend
    restart: unless-stopped

  $(GDAL_CONTAINER):
    image: $(GDAL_IMAGE)
    container_name: $(GDAL_CONTAINER)
    entrypoint: /bin/sh
    stdin_open: true
    tty: true
    working_dir: /outputs
    volumes:
      - ./outputs:/outputs
    networks:
      - backend
    restart: unless-stopped

  $(SIOSE_2005_CONTAINER):
    image: $(SIOSE_2005_IMAGE)
    container_name: $(SIOSE_2005_CONTAINER)
    ports:
      - "5433:5432"
    environment:
      POSTGRES_PASSWORD: $(POSTGRES_PASSWORD)
      POSTGRES_USER: $(POSTGRES_USER)
      POSTGRES_DB: $(POSTGRES_DB)
      PGDATA: /postgresql/data
#    command: postgres -c search_path='public,gh'
    volumes:
      - postgres_data:/postgresql/data:rw
      - postgres_backups:/postgresql/backups
    networks:
      - backend
    restart: unless-stopped

volumes:
  postgres_data:
    driver: local
  postgres_backups:
    driver: local

networks:
  backend:
    driver: bridge

endef



