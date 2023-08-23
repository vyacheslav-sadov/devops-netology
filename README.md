**/.terraform/*
# Игнорировать все файлы в директории .terraform на любом уровне вложенности
*.tfstate
# игнорировать все файлы с расширением .tfstate
*.tfstate.*
# будут проигнорированы все файлы, содержащие в имени .tfstate. 
crash.log
# игнорировать файл crash.log
crash.*.log
# игнорировать все файлы, которые начинаются на crash. и оканчиваются на .log 
*.tfvars
# игнорировать все файлы с расширением .tfvars
*.tfvars.json
# игнорировать файлы .tfvars с расширением .json с любыми символами в начале имени файла
override.tf
# игнорировать файл override.tf
override.tf.json
# игнорировать файл override.tf.json
*_override.tf
# игнорировать файлы _override.tf с любыми символами в начале имени файла 
*_override.tf.json 
# игнорировать файлы _override.tf.json с любыми символами в начале имени файла
.terraformrc
# игнорировать файл .terraformrc
terraform.rc
# игнорировать файл terraform.rc