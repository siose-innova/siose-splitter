
compose := docker-compose.yml

$(compose):
	$(file > $@,$(docker-compose))


define docker-compose

version: '3'

#TODO: Manage which services are going to be launched
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
      DEFAULT_USER: $(PGADMIN_USER)
      DEFAULT_PASSWORD: $(PGADMIN_PASSWORD)
    networks:
      - backend
    depends_on:
      - $(SIOSE_2005_CONTAINER)
    restart: unless-stopped

  $(BASH_CONTAINER):
    image: $(BASH_IMAGE)
    container_name: $(BASH_CONTAINER)
    entrypoint: $(SHELL)
    stdin_open: true
    tty: true
    working_dir: $(DOCKER_WORKDIR)
    volumes:
      - .$(DOCKER_WORKDIR):$(DOCKER_WORKDIR)
    networks:
      - backend
    restart: unless-stopped

  $(GDAL_CONTAINER):
    image: $(GDAL_IMAGE)
    container_name: $(GDAL_CONTAINER)
    entrypoint: $(SHELL)
    stdin_open: true
    tty: true
    working_dir: $(DOCKER_WORKDIR)
    volumes:
      - .$(DOCKER_WORKDIR):$(DOCKER_WORKDIR)
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



