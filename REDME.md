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

