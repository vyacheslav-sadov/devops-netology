# Домашнее задание к занятию "Введение в Ansible"

**Основная часть**

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_1.png)

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_2.png)

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
Запущены контейнеры: 
```
user@test-VM:~/module_ansible/mnt-homeworks/08-ansible-01-base/playbook$ docker ps
CONTAINER ID   IMAGE            COMMAND       CREATED        STATUS          PORTS     NAMES
41360ca9970c   ubuntu:20.04     "/bin/bash"   10 hours ago   Up 34 minutes             ubuntu
4d4cfa416ba8   centos:centos7   "/bin/bash"   10 hours ago   Up 34 minutes             centos7
```
Пользователь `user` добавлен в группу `docker` в файле /etc/group для предоставления прав на запуск. 

4. Проведите запуск playbook на окружении из prod.yml. Зафиксируйте полученные значения some_fact для каждого из managed host.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_4.png)

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb — deb default fact`, для `el — el default fact`.
Редактируем файл: group_vars/el/examp.yml
```
---
  some_fact: "el default fact"
```
Редактируем файл: group_vars/deb/examp.yml
```
---
  some_fact: "deb default fact"
```

6. Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_6.png)

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_7.png)

8. Запустите playbook на окружении `prod.yml`. При запуске ansible должен запросить у вас пароль. Убедитесь в работоспособности.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_8.png)

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на control node.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_9.png)

```
user@test-VM:~/module_ansible/mnt-homeworks/08-ansible-01-base/playbook/inventory$ ansible-doc -t connection local
> ANSIBLE.BUILTIN.LOCAL    (/usr/local/lib/python3.8/dist-packages/ansible/plugins/connection/local.py)

        This connection plugin allows ansible to execute tasks on the Ansible 'controller' instead of
        on a remote host.

ADDED IN: historical

OPTIONS (= is mandatory):

- pipelining
        Pipelining reduces the number of connection operations required to execute a module on the
        remote server, by executing many Ansible modules without actual file transfers.
        This can result in a very significant performance improvement when enabled.
        However this can conflict with privilege escalation (become). For example, when using sudo
        operations you must first disable 'requiretty' in the sudoers file for the target hosts, which
        is why this feature is disabled by default.
        [Default: False]
        set_via:
          env:
          - name: ANSIBLE_PIPELINING
          ini:
          - key: pipelining
            section: defaults
          - key: pipelining
            section: connection
          vars:
          - name: ansible_pipelining
        
        type: boolean


NOTES:
      * The remote user is ignored, the user with which the ansible CLI was executed is used
        instead.


AUTHOR: ansible (@core)

NAME: local
```

10. В `prod.yml` добавьте новую группу хостов с именем `local`, в ней разместите `localhost` с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске ansible должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных group_vars.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_11.png)

12. Заполните README.md ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым playbook и заполненным README.md.
13. Предоставьте скриншоты результатов запуска команд.

**Необязательная часть**

1) При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_(1).png)

2) Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_(2).png)

3) Запустите playbook, убедитесь, что для нужных хостов применился новый `fact`.
![Скриншот](https://github.com/vyacheslav-sadov/devops-netology/blob/master/ansible/images/task_(3).png)

4) Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать этот вариант.
Подготавливаем новый контейнер `fedora`
```
user@test-VM:~/module_ansible/mnt-homeworks/08-ansible-01-base/playbook/inventory$ docker ps
CONTAINER ID   IMAGE               COMMAND       CREATED        STATUS          PORTS     NAMES
dffdd46faa96   pycontribs/fedora   "/bin/bash"   2 hours ago    Up 2 seconds              fedora
41360ca9970c   ubuntu:20.04        "/bin/bash"   10 hours ago   Up 41 seconds             ubuntu
4d4cfa416ba8   centos:centos7      "/bin/bash"   10 hours ago   Up 41 seconds             centos7
```
Редактируем файл inventory/prod.yml, добавляем группу хостов `fedora`:
```
  fedora:
    hosts:
      fedora_pic:
        ansible_connection: docker
```
Добавляем файл с переменными для группы `fedora` group_vars/fed/examp.yml:
```
---
  some_fact: "Fedora default fact"
```
Результат работы плейбука: 
```
user@test-VM:~/module_ansible/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook site.yml -i inventory/prod.yml --ask-vault-password
Vault password: 
[WARNING]: Found both group and host with same name: fedora

PLAY [Print os facts] **********************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [fedora]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [fedora] => {
    "msg": "Fedora"
}

TASK [Print fact] **************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [fedora] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP *********************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```