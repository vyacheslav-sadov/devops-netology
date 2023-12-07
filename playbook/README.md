# Домашнее задание к занятию 2 «Работа с Playbook»

**1) Подготовьте свой inventory-файл `prod.yml`.**

С использованием yandex-cloud создал две виртуальные машины на Centos7. Затем подготовил файл `prod.yml`
```
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: "51.250.120.218"
      ansible_user: "admin"
vector:
  hosts:
    vector-01:
      ansible_host: "51.250.121.136"
      ansible_user: "admin"
```
**2) Допишите `playbook:` нужно сделать ещё один play, который устанавливает и настраивает vector. Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по ссылке. не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!**
3) При создании tasks рекомендую использовать модули: `get_url, template, unarchive, file.`
4) Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.

В файл `site.yml` добавлена конфигурация по настройке `vector`. Использованы модули: `get-url, yum, service, template`.  
```
- name: Install Vector
  hosts: vector
  handlers:
    - name: Start vector service
      service:
        name: vector
        state: restarted

  tasks:
    - name: Get vector distrib
      get_url:
        url: "https://packages.timber.io/vector/latest/vector-{{ vector_version }}.{{ ansible_architecture }}.rpm"
        dest: "./vector-{{ vector_version }}.{{ ansible_architecture }}.rpm"
    - name: Install vector packages
      yum:
        name: ./vector-{{ vector_version }}.{{ ansible_architecture }}.rpm
        state: present
    - name: Deploy config vector
      template:
        src: template/vector.j2
        dest: /etc/vector/vector.yaml
        mode: 0755
      notify: Start vector service
```

**5) Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.**

```
user@test-VM:~/module_ansible/mnt-homeworks/08-ansible-02-playbook/playbook$ 
ansible-lint site.yml
[206] Variables should have spaces before and after: {{ var_name }}
site.yml:52
        dest: "./vector-{{ vector_version }}.{{ansible_architecture}}.rpm"

user@test-VM:~/module_ansible/mnt-homeworks/08-ansible-02-playbook/playbook$
```
- Исправляем ошибки и запускаем команду повторно: 
```
user@test-VM:~/module_ansible/mnt-homeworks/08-ansible-02-playbook/playbook$ 
ansible-lint site.yml
user@test-VM:~/module_ansible/mnt-homeworks/08-ansible-02-playbook/playbook$
```

**6) Попробуйте запустить playbook на этом окружении с флагом `--check`**
```
ansible-playbook site.yml -i inventory/prod.yml -l vector --check

PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************
skipping: no hosts matched

PLAY [Install Vector] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *********************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install vector packages] ****************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Deploy config vector] *******************************************************************************************************************************************************************************
changed: [vector-01]

RUNNING HANDLER [Start vector service] ********************************************************************************************************************************************************************
changed: [vector-01]

PLAY RECAP ************************************************************************************************************************************************************************************************
vector-01                  : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

**7) Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.**
```
ansible-playbook site.yml -i inventory/prod.yml -l vector --diff

PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************
skipping: no hosts matched

PLAY [Install Vector] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *********************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install vector packages] ****************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Deploy config vector] *******************************************************************************************************************************************************************************
--- before
+++ after: /home/user/.ansible/tmp/ansible-local-8397a_txm_zm/tmpe2uluvnt/vector.j2
@@ -0,0 +1,42 @@
+#                                    V E C T O R
+#                                   Configuration
+#
+# ------------------------------------------------------------------------------
+# Website: https://vector.dev
+# Docs: https://vector.dev/docs
+# Chat: https://chat.vector.dev
+# ------------------------------------------------------------------------------
+
+# Change this to use a non-default directory for Vector data storage:
+# data_dir: "/var/lib/vector"
+
+# Random Syslog-formatted logs this is my test
+sources:
+  dummy_logs:
+    type: "demo_logs"
+    format: "syslog"
+    interval: 1
+
+# Parse Syslog logs
+# See the Vector Remap Language reference for more info: https://vrl.dev
+transforms:
+  parse_logs:
+    type: "remap"
+    inputs: ["dummy_logs"]
+    source: |
+      . = parse_syslog!(string!(.message))
+
+# Print parsed logs to stdout
+sinks:
+  print:
+    type: "console"
+    inputs: ["parse_logs"]
+    encoding:
+      codec: "json"
+
+# Vector's GraphQL API (disabled by default)
+# Uncomment to try it out with the `vector top` command or
+# in your browser at http://localhost:8686
+# api:
+#   enabled: true
+#   address: "127.0.0.1:8686"

changed: [vector-01]

RUNNING HANDLER [Start vector service] ********************************************************************************************************************************************************************
changed: [vector-01]

PLAY RECAP ************************************************************************************************************************************************************************************************
vector-01                  : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
- Подключаемся к ВМ по SSH и проверяем установленную версию vector:
```
ssh admin@51.250.121.136
[admin@vector-01 ~]$ systemctl status vector
● vector.service - Vector
   Loaded: loaded (/usr/lib/systemd/system/vector.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2023-12-07 18:12:42 UTC; 1min 50s ago
     Docs: https://vector.dev
  Process: 5883 ExecStartPre=/usr/bin/vector validate (code=exited, status=0/SUCCESS)
 Main PID: 5887 (vector)
   CGroup: /system.slice/vector.service
           └─5887 /usr/bin/vector
```
**8) Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.**

```
ansible-playbook site.yml -i inventory/prod.yml -l vector --diff

PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************
skipping: no hosts matched

PLAY [Install Vector] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] *********************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install vector packages] ****************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Deploy config vector] *******************************************************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP ************************************************************************************************************************************************************************************************
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
**9) Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по ссылке. Так же приложите скриншоты выполнения заданий №5-8**

**При создании конфигурации vector произведено:**
- создан `inventory` с группой `vector`, содержащей параметры:
  ansible_host: "51.250.121.136"
  ansible_user: admin
  ansible_become: yes
  vector_version: "0.34.1-1"
  test: "this is my test" 
- создан playbook `install vector`, который запускается на hosts группы `vector`, описанных в `inventory`;
  в playbook созданы: 
  - обработчик `handler` с модулем `service` для перезапуска сервиса vector в случае внесения изменений; 
  - task `Get vector distrib` с использованием модуля `get_url` происходит скачивание rpm-пакета в текущую директорию;
  - task `Install vector packages` с использованием модуля `yum` устанавливает данный rpm-пакет;
  - task `Deploy config vector` с использованием модуля `template` отправляет шаблон по пути `/etc/vector/vector.yaml`;
  - notify вызывает `handlers`.  

**10) Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-02-playbook на фиксирующий коммит, в ответ предоставьте ссылку на него.**

