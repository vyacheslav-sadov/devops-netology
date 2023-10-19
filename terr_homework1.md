**Задание № 1.**
*1) Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.*
Команда: git clone https://github.com/netology-code/ter-homeworks.git. 

*2) Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?*
Ответ: в файле "personal.auto.tfvars". 

*3) Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.*
Ответ: "result": "OqC7Gl1oQxWyfhWp"
![Изображение](https://github.com/vyacheslav-sadov/devops-netology/blob/WM_branch/terraform1/terr1_task_3.png)

*4) Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.*
Ответ: 
![Изображение](https://github.com/vyacheslav-sadov/devops-netology/blob/WM_branch/terraform1/terr1_task_4.png)
- отсутствует имя ресурса в строке 24;
- неверное имя ресурса в строке 29;
![Изображение](https://github.com/vyacheslav-sadov/devops-netology/blob/WM_branch/terraform1/terr1_task_4(1).png)
- ссылка на незадекларированный ресурс в строке 31;
- ошибка в неподдерживаемом атрибуте "resulT"

*5) Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды docker ps.*
![Изображение](https://github.com/vyacheslav-sadov/devops-netology/blob/WM_branch/terraform1/terr1_task_5.png)
![Изображение](https://github.com/vyacheslav-sadov/devops-netology/blob/WM_branch/terraform1/terr1_task_5(1).png)

*6) Замените имя docker-контейнера в блоке кода на hello_world. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду terraform apply -auto-approve. Объясните своими словами, в чём может быть опасность применения ключа -auto-approve. В качестве ответа дополнительно приложите вывод команды docker ps.*
Ответ: когда запускаем команду "terraform apply" без передачи сохраненного файла плана, Terraform автоматически создает новый план выполнения, как если бы запустили terraform plan и предлагает утвердить этот план и выполнить указанные действия. При использовании ключа "-auto-approve" мы передаем Terraform указание применить план, не запрашивая подтверждения. При использовании данного ключа необходимо убедиться, что никто не сможет изменить инфраструктуру за пределами моего рабочего процесса Terraform. Это сводит к минимуму риск непредсказуемых изменений и смещения конфигурации.
![Изображение](https://github.com/vyacheslav-sadov/devops-netology/blob/WM_branch/terraform1/terr1_task_6.png)

*7) Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.*
![Изображение](https://github.com/vyacheslav-sadov/devops-netology/blob/WM_branch/terraform1/terr1_task_7.png)

*8) Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ обязательно подкрепите строчкой из документации terraform провайдера docker. (ищите в классификаторе resource docker_image )*
Ответ: в конфигурации используется функция "keep_locally" = true. 
Согласно документации: если true, то изображение Docker не будет удалено при операции уничтожения. Если это значение равно false, то при операции уничтожения изображение будет удалено из локального хранилища docker.