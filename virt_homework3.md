Задача № 1. 
https://hub.docker.com/repository/docker/uzver33/test_repo33/general

Задача № 2. Посмотрите на сценарий ниже и ответьте на вопрос: «Подходит ли в этом сценарии использование Docker-контейнеров или лучше подойдёт виртуальная машина, физическая машина? Может быть, возможны разные варианты?»

Сценарии: 
- высоконагруженное монолитное Java веб-приложение
(подойдет физическая машина, т.к. высоконагруженное, то необходим доступ к физическим ресурсам, без использования гипервизора)
- Nodejs веб-приложение
(т.к. это веб-приложение, то реализуемо через контейнеризацию)
- мобильное приложение c версиями для Android и iOS
(для реализации подойдет виртуальная машина, т.к. при использовании контейнеров отсутствует графический интерфейс)
- шина данных на базе Apache Kafka
(подойдет виртуальная машина для сохранения данных)
- Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana
(данные сервисы можно развернуть через использование контейнеров, имеются необходимые docker-образы на hub.docker)
- мониторинг-стек на базе Prometheus и Grafana
(можно запустить в контейнерах, не требуется много ресурсов, возможность быстрого запуска сервисов)
- MongoDB как основное хранилище данных для Java-приложения
(можно использовать виртуальную машину, так как использование БД через контейнеризацию нерационально)
- Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry
(буду использовать через запуск в контейнерах)

Задача № 3. 

- Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
- Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
- Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;
- Добавьте еще один файл в папку /data на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

[root@localhost ~]# docker run --rm -it -d --mount type=bind,source=`pwd`/data,target=/data -w /data centos:7 /bin/bash
fb72296dc593af724143560c371b07cb4a58e7d38ec0ab8cfc009d8ecbd463f8
[root@localhost ~]# docker run --rm -it -d --mount type=bind,source=`pwd`/data,target=/data -w /data debian:12.1 /bin/bash
a0009376a1248b72078c4440003847c0ac8ce50bc3a224d348e8cf6206458d2d
[root@localhost ~]# docker ps
CONTAINER ID   IMAGE         COMMAND       CREATED          STATUS          PORTS     NAMES
a0009376a124   debian:12.1   "/bin/bash"   3 seconds ago    Up 2 seconds              adoring_benz
fb72296dc593   centos:7      "/bin/bash"   44 seconds ago   Up 43 seconds             vibrant_goldberg
[root@localhost ~]# 
[root@localhost data]# touch test
[root@localhost data]# 
[root@localhost ~]# docker exec -it fb72296dc593 /bin/bash
[root@fb72296dc593 data]# ls -la
total 0
drwxr-xr-x 2 root root 18 Sep 26 19:15 .
drwxr-xr-x 1 root root 18 Sep 26 19:14 ..
-rw-r--r-- 1 root root  0 Sep 26 19:15 test
[root@fb72296dc593 data]# touch test1
[root@fb72296dc593 data]# ls
test  test1
[root@fb72296dc593 data]# exit
[root@localhost ~]# docker exec -it a0009376a124 /bin/bash
root@a0009376a124:/data# ls -la
total 0
drwxr-xr-x 2 root root 31 Sep 26 19:16 .
drwxr-xr-x 1 root root 18 Sep 26 19:14 ..
-rw-r--r-- 1 root root  0 Sep 26 19:15 test
-rw-r--r-- 1 root root  0 Sep 26 19:16 test1
root@a0009376a124:/data#