TsimermanE_infra Tsimerman Infra repository

Ответ на задание в ДЗ 5 урок "Знакомство с облачнои инфраструктурои"

0. Для упращения подлючения к серверам по ssh можно использовать алиасы, для данного задания подходит
   следующий конфиг:

   файл ~/.ssh/config
   
   _________________________________________
   Host bastion
       HostName 34.141.15.191
       User appuser
       IdentityFIle ~/.ssh/_навазние ключа_

   Host someinternalhost
       HostName 10.156.0.3
       User appuser
       ProxyCommand ssh bastion -W %h:%p
   ________________________________________

1. Для подлючения к хосту (someinternalhost) через промежуточный (bastion) можно исполтьзовать 
   bastion как:
	
	- джамп хост
	  команда: ssh -J bastion someinternalhost
	
	-* использовать команду ProxyCommand (прокси):
	  в файле ~/.ssh/config в записи для someinternal необходимо добавить:
	  ProxyCommand ssh bastion -W %h:%p 

3. Данные для подлючения:

## Как проверить работоспособность:
 - https://35.242.253.247.sslip.io/

bastion_IP = 35.242.253.247.sslip.io
someinternalhost_IP = 10.156.0.3


## Ответ на задание в ДС 6 урок Основные сервисы Google Cloud Platform

testapp_IP = 34.141.73.242
testapp_port = 9292

  0. Знакомство с утилитой gcloud.
  1. Знакомство с командой создания ВМ.
  1.1. Знакомство с возможностью добавления startapscript.
____________

gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --scopes=storage-ro \
  --metadata=startup-script-url=gs://my-run/run.sh
____________

  1.2. Знакомство с возможностью деплоя скриптами в том числе с помощью startapscript.
  1.3. Знакомство с возмоднстью добавления правил фаервола через gcloud.
____________

gcloud compute firewall-rules create default-puma-server \
    --network default \
    --action allow \
    --direction ingress \
    --rules tcp:9292 \
    --source-ranges 0.0.0.0/0 \
    --priority 1000 \
    --target-tags puma-server
____________

  1.4. Знакомство с возмолжностью удаления ВМ командой через gcloud.
____________

gcloud compute instances delete reddit-app
____________

  1.5. Знакомство с возмолжностью  просмтра результата выполнения startapscript.
____________

sudo journalctl -u google-startup-scripts.service
____________
  
  1.6. Копирование в бакет файлов через утилиту gcloud/
____________

gsutil cp run.sh gs://my-run/
____________


## Записи к ДС по 7 уроку. Сборка образа VM при помощи Packer

Файл с шаблоном: ubuntu16-1.json
Файл с переменными: variables.json

Для использования файла с переменными необходимо использовать добавить ключ -var-fil, например:

packer build -var-file=variables.json template.json

или

packer validate -var-file=variables.json ubuntu16.json
