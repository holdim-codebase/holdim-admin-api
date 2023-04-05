# Holdim Admin API

## Clone

1. Clone repository
2. Clone submodules

```
git submodule update --init --recursive
```

## Installation

1. Install Docker on your system

2. Build containers

```
cd docker-compose
docker-compose up
```

3. Run seed

```
docker exec -it holdim_admin_api yarn db:seed
```
