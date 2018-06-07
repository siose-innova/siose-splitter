
# PG client is not mandatory in the siose-splitter tasks, but it can be defined for inspecting and testing purposes.
pgclient := none
#pgclient := pgadmin
#pgclient := psql

compose := docker-compose.yml

#TODO: Manage which services are going to be launched
$(compose):
	$(file > $@,$(header))
	$(file >> $@,$(dbm))
	$(file >> $@,$(gdal))
	$(file >> $@,$(bash))
ifeq ($(pgclient),pgadmin)
	$(file >> $@,$(pgadmin))
	@echo "You can access pgadmin at port..."
else ifeq ($(pgclient),psql)
	$(file >> $@,$(psql))
	@echo "You can access psql..."
else
	@echo "No pgclient was defined in this compose."
endif
	$(file >> $@,$(volumes))
	$(file >> $@,$(networks))


define header
version: '3'

services:
endef

define psql
  $(PSQL_CONTAINER):
    image: $(PSQL_IMAGE)
    entrypoint: $(SHELL)
    stdin_open: true
    tty: true
    working_dir: $(DOCKER_WORKDIR)
    volumes:
      - .$(DOCKER_WORKDIR):$(DOCKER_WORKDIR)
    links:
      - $(SIOSE_2005_CONTAINER)
    networks:
      - backend
    depends_on:
      - $(SIOSE_2005_CONTAINER)
    restart: unless-stopped
endef

define pgadmin
  $(PGADMIN_CONTAINER):
    image: $(PGADMIN_IMAGE)
#    container_name: $(PGADMIN_CONTAINER)
    links:
      - $(SIOSE_2005_CONTAINER)
    volumes:
      - .:/var/lib/pgadmin4/data/storage/pgadmin4
    ports:
      - "5050:5050"
    environment:
      DEFAULT_USER: $(PGADMIN_USER)
      DEFAULT_PASSWORD: $(PGADMIN_PASSWORD)
    networks:
      - backend
    depends_on:
      - $(SIOSE_2005_CONTAINER)
    restart: unless-stopped
endef

define bash
  $(BASH_CONTAINER):
    image: $(BASH_IMAGE)
#    container_name: $(BASH_CONTAINER)
    entrypoint: $(SHELL)
    stdin_open: true
    tty: true
    working_dir: $(DOCKER_WORKDIR)
    volumes:
      - .$(DOCKER_WORKDIR):$(DOCKER_WORKDIR)
    networks:
      - backend
    restart: unless-stopped
endef

define gdal
  $(GDAL_CONTAINER):
    image: $(GDAL_IMAGE)
#    container_name: $(GDAL_CONTAINER)
    entrypoint: $(SHELL)
    stdin_open: true
    tty: true
    working_dir: $(DOCKER_WORKDIR)
    volumes:
      - .$(DOCKER_WORKDIR):$(DOCKER_WORKDIR)
    networks:
      - backend
    restart: unless-stopped
endef

define dbm
  $(SIOSE_2005_CONTAINER):
    build:
      context: .
      dockerfile: Dockerfile
    image: $(SIOSE_2005_IMAGE)
#    container_name: $(SIOSE_2005_CONTAINER)
    ports:
      - "5433:5432"
    environment:
      POSTGRES_PASSWORD: $(POSTGRES_PASSWORD)
      POSTGRES_USER: $(POSTGRES_USER)
      POSTGRES_DB: $(POSTGRES_DB)
      PGDATA: /postgresql/data
    volumes:
      - postgres_data:/postgresql/data:rw
      - postgres_backups:/postgresql/backups
    networks:
      - backend
    restart: unless-stopped
endef

define volumes
volumes:
  postgres_data:
    driver: local
  postgres_backups:
    driver: local
endef

define networks
networks:
  backend:
    driver: bridge
endef



