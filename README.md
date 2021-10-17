TsimermanE_infra Tsimerman Infra repository

# Записи к ДЗ по 5 уроку."Знакомство с облачнои инфраструктурои"

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
	
	* джамп хост
	  команда: ssh -J bastion someinternalhost
	
	* (* - задание) использовать команду ProxyCommand (прокси):
	  в файле ~/.ssh/config в записи для someinternal необходимо добавить:
	  ProxyCommand ssh bastion -W %h:%p 

3. Данные для подлючения:

### Как проверить работоспособность:

https://35.242.253.247.sslip.io/

bastion_IP = 35.242.253.247.sslip.io
someinternalhost_IP = 10.156.0.3


# Записи к ДЗ по 6 уроку. "Основные сервисы Google Cloud Platform"

testapp_IP = 34.141.73.242
testapp_port = 9292

0. Знакомство с утилитой gcloud.
1. Знакомство с командой создания ВМ.
---
	1.1. Знакомство с возможностью добавления startapscript.


```
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --scopes=storage-ro \
  --metadata=startup-script-url=gs://my-run/run.sh\
 ```
---

	1.2. Знакомство с возможностью деплоя скриптами в том числе с помощью startapscript.
	
---
	1.3. Знакомство с возмоднстью добавления правил фаервола через gcloud.

```
gcloud compute firewall-rules create default-puma-server \
    --network default \
    --action allow \
    --direction ingress \
    --rules tcp:9292 \
    --source-ranges 0.0.0.0/0 \
    --priority 1000 \
    --target-tags puma-server
```
---

	1.4. Знакомство с возмолжностью удаления ВМ командой через gcloud.


```
gcloud compute instances delete reddit-app
```
---

	1.5. Знакомство с возмолжностью  просмтра результата выполнения startapscript.


```
sudo journalctl -u google-startup-scripts.service
```
---
  
	1.6. Копирование в бакет файлов через утилиту gcloud/


```
gsutil cp run.sh gs://my-run/
```
---


# Записи к ДЗ по 7 уроку. "Сборка образа VM при помощи Packer"

1. Команды GCP.

---	
	1.1. Создание Application Default Credentials (ADC) - использование API GCP сторонним ПО:

```
gcloud auth application-default login
```
---
	1.2. Команда для просмотра проектов GCP:

```
gcloud projects list
```
---
	1.3. Команда для создания ВМ из своего образа:

```
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image=reddit-base-1634396083 \
  --machine-type=f1-micro \
  --tags puma-server
```
---
2. Packer.

---
	2.1. Файлы

Файл с шаблоном: ubuntu16.json и immutable.json
Файл с переменными: variables.json

---
	2.2. Описание файлов

* builders - секция отвечает за создание виртуальной машины для билда и создание машинного образа в GCP
* provisioners - секция позволяет устанавливать нужное ПО, производить настройки системы и конфигурацию приложений на созданной VM 
* variables - обявление переменных в файле шаблона или в отдельном файле (для сохранение секретов - хранить в отдельном файле и добавлять его в gitignore)

---
	2.3. Команды

* Для использования файла с переменными необходимо использовать добавить ключ -var-fil, например:

```
packer build -var-file=variables.json template.json
```

* Проверка (валидация) шаблона

```
packer validate -var-file=variables.json ubuntu16.json
```

* Сборка образа VM

```
packer build -var-file=varibles.json immutable.json
```
---
