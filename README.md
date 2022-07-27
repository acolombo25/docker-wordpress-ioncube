## What's included?
This image is based on the [official WordPress image](https://hub.docker.com/_/wordpress/).
It includes the [ionCube Loader](https://www.ioncube.com/loaders.php) and increases the memory limit and the maximum upload file size.

## How to use
The image can be used identically to the official WordPress image. You can take a look at their description or use a **docker-compose.yml** similar to this:

```yml
version: '1.0'

services:
  wordpress:
    image: acolombo11/wordpress-ioncube
    restart: always
    ports:
      - 80:80
    volumes:
      - ./wp-content/:/var/www/html/wp-content
    environment:
      - WORDPRESS_DB_HOST=mariadb
      - WORDPRESS_DB_PASSWORD: example

  db:
    image: mariadb
    restart: always
    volumes: ./db-data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: example

```

### How to build and update docker-hub
https://docs.docker.com/docker-hub/repos/
