 # Домашнее задание к занятию 9 «Процессы CI/CD»
## Знакомство с SonarQube
### Основная часть:
1) Создайте новый проект, название произвольное.
2) Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.
3) Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ)
```
user@test-VM:~$ echo $PATH
/home/user/yandex-cloud/bin:/home/user/yandex-cloud/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/opt/sonar-scanner/bin:/opt/apache-maven-3.9.6/bin
```
4) Проверьте sonar-scanner --version.
```
user@test-VM:~$ sonar-scanner --version
INFO: Scanner configuration file: /opt/sonar-scanner/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 5.0.1.3006
INFO: Java 17.0.7 Eclipse Adoptium (64-bit)
INFO: Linux 5.15.0-92-generic amd64
```
5) Запустите анализатор против кода из директории example с дополнительным ключом -Dsonar.coverage.exclusions=fail.py.
6) Посмотрите результат в интерфейсе.
7) Исправьте ошибки, которые он выявил, включая warnings.
8) Запустите анализатор повторно — проверьте, что QG пройдены успешно.
9) Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.
![QG Passed](https://github.com/vyacheslav-sadov/devops-netology/blob/cicd/Images/QG.png)

## Знакомство с Nexus
### Основная часть: 
1) В репозиторий maven-public загрузите артефакт с GAV-параметрами:
- groupId: netology;
- artifactId: java;
- version: 8_282;
- classifier: distrib;
- type: tar.gz.
2) В него же загрузите такой же артефакт, но с version: 8_102.
3) Проверьте, что все файлы загрузились успешно.
4) В ответе пришлите файл maven-metadata.xml для этого артефекта.
```
<metadata modelVersion="1.1.0">
<groupId>netology</groupId>
<artifactId>java</artifactId>
<versioning>
<latest>8_282</latest>
<release>8_282</release>
<versions>
<version>8_102</version>
<version>8_282</version>
</versions>
<lastUpdated>20240124181638</lastUpdated>
</versioning>
</metadata>
```

## Знакомство с Maven
### Основная часть: 
1) Поменяйте в pom.xml блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).
2) Запустите команду mvn package в директории с pom.xml, ожидайте успешного окончания.
3) Проверьте директорию ~/.m2/repository/, найдите ваш артефакт.
4) В ответе пришлите исправленный файл pom.xml.
```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
.
  <groupId>com.netology.app</groupId>
  <artifactId>simple-app</artifactId>
  <version>1.0-SNAPSHOT</version>
   <repositories>
    <repository>
      <id>my-repo</id>
      <name>maven-public</name>
      <url>http://51.250.126.183:8081/repository/maven-public/</url>
    </repository>
  </repositories>
  <dependencies>
     <dependency>
      <groupId>netology</groupId>
      <artifactId>java</artifactId>
      <version>8_282</version>
      <classifier>distrib</classifier>
      <type>jar</type>
    </dependency>
  </dependencies>
</project>
```