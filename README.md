 # Домашнее задание к занятию 9 «Процессы CI/CD»
## Знакомство с SonarQube
### Основная часть:
1) Создайте новый проект, название произвольное.
2) Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.
3) Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ)
`
user@test-VM:~$ echo $PATH
/home/user/yandex-cloud/bin:/home/user/yandex-cloud/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/opt/sonar-scanner/bin:/opt/apache-maven-3.9.6/bin
`
4) Проверьте sonar-scanner --version.
`
user@test-VM:~$ sonar-scanner --version
INFO: Scanner configuration file: /opt/sonar-scanner/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 5.0.1.3006
INFO: Java 17.0.7 Eclipse Adoptium (64-bit)
INFO: Linux 5.15.0-92-generic amd64
`
5) Запустите анализатор против кода из директории example с дополнительным ключом -Dsonar.coverage.exclusions=fail.py.
6) Посмотрите результат в интерфейсе.
7) Исправьте ошибки, которые он выявил, включая warnings.
8) Запустите анализатор повторно — проверьте, что QG пройдены успешно.
9) Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.

