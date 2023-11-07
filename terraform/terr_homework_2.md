**Задание № 1**

- Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
- Переименуйте файл personal.auto.tfvars_example в personal.auto.tfvars. Заполните переменные: идентификаторы облака, токен доступа. Благодаря .gitignore этот файл не попадёт в публичный репозиторий. Вы можете выбрать иной способ безопасно передать секретные данные в terraform.
- Сгенерируйте или используйте свой текущий ssh-ключ. Запишите его открытую часть в переменную vms_ssh_root_key.
- Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
Ошибка: Yandex Compute Cloud предоставляет различные виды физических процессоров. Выбор платформы гарантирует тип физического процессора в дата-центре и определяет набор допустимых конфигураций vCPU и RAM. Также, к виртуальной машине можно добавить графический ускоритель (GPU). Платформу необходимо выбирать при создании каждой виртуальной машины.
![Скриншот_1](https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/screenshots/1.png)
- Ответьте, как в процессе обучения могут пригодиться параметры "preemptible = true" и "core_fraction=5" в параметрах ВМ. Ответ в документации Yandex Cloud.
Первый параметр - это прерываемость виртуальной машины. Прерываемые виртуальные машины — это виртуальные машины, которые могут быть принудительно остановлены в любой момент. Прерываемые виртуальные машины доступны по более низкой цене в сравнении с обычными, однако не обеспечивают отказоустойчивости.
Второй параметр - это уровни производительности vCPU. При создании каждой виртуальной машины необходимо выбирать уровень производительности vCPU. Этот уровень определяет долю вычислительного времени физических ядер, которую гарантирует vCPU. ВМ с уровнем производительности меньше 100% предназначены для запуска приложений, не требующих высокой производительности и не чувствительных к задержкам. Такие машины обойдутся дешевле. Виртуальные машины с уровнем производительности 100% имеют непрерывный доступ (100% времени) к вычислительной мощности физических ядер. Такие ВМ предназначены для запуска приложений, требующих высокой производительности на протяжении всего времени работы.

В качестве решения приложите:

скриншот ЛК Yandex Cloud с созданной ВМ. 
![Скриншот_2](https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/screenshots/2.png)
скриншот успешного подключения к консоли ВМ через ssh:
![Скриншот_3](https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/screenshots/3.png)

**Задание № 2**

- Изучите файлы проекта.
- Замените все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.
- Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.
- Проверьте terraform plan. Изменений быть не должно.

![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/screenshots/task_2.png)
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/screenshots/task_2(1).png)

**Задание № 3**

- Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
- Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf').
- Примените изменения.

![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/screenshots/task_3.png)

**Задание № 4**

- Объявите в файле outputs.tf output типа map, содержащий { instance_name = external_ip } для каждой из ВМ. Примените изменения.
В качестве решения приложите вывод значений ip-адресов команды terraform output.

![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/screenshots/task_4.png)

Ссылка на код: https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/outputs.tf

**Задание № 5**

- В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с несколькими переменными по примеру из лекции.
- Замените переменные с именами ВМ из файла variables.tf на созданные вами local-переменные.
- Примените изменения.

![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/screenshots/task_5.png)

Ссылки на код:
- https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/main.tf
- https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/locals.tf


**Задание № 6**

- Вместо использования трёх переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедините их в переменные типа map с именами "vm_web_resources" и "vm_db_resources". В качестве продвинутой практики попробуйте создать одну map-переменную vms_resources и уже внутри неё конфиги обеих ВМ — вложенный map.
- Также поступите с блоком metadata {serial-port-enable, ssh-keys}, эта переменная должна быть общая для всех ваших ВМ.
- Найдите и удалите все более не используемые переменные проекта.
- Проверьте terraform plan. Изменений быть не должно.

Ссылки на код: 
- https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/main.tf
- https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/variables.tf
- https://github.com/vyacheslav-sadov/devops-netology/blob/terraform-02/terraform/vms_platform.tf

