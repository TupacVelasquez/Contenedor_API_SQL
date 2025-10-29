# Ejecución del proyecto Node.js + SQL Server en Docker

# Crear red Docker
docker network create red_api_sql

# Levantar contenedor SQL Server
docker run -d --name sqlserver --network red_api_sql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Password123!" -p 1433:1433 mcr.microsoft.com/mssql/server:2019-latest

# Copiar init.sql al contenedor SQL Server
docker cp .\init.sql sqlserver:/init.sql

# Entrar al contenedor SQL Server como root
docker exec -it --user root sqlserver /bin/bash

# Instalar sqlcmd dentro del contenedor
apt-get update
apt-get install -y curl apt-transport-https gnupg
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev
export PATH=$PATH:/opt/mssql-tools/bin

# Ejecutar init.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Password123!' -i /init.sql

# Salir del contenedor SQL Server
exit

# Construir imagen Node.js
docker build -t node_api .

# Levantar contenedor Node.js
docker run -d --name api_node --network red_api_sql -p 3000:3000 node_api

# Probar API
http://localhost:3000/mascotas
