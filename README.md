# do_api
Utilidades para interactuar con Digital Ocean

En la interface administrativa en Digital Ocean para cada team o usuario se debe obtener una key.

Luego de clonar este proyecto, ejecutar mix deps.get para instalar las dependencias.

Para ejecutar dentro de iex la funcionalidad

iex> DoApi.generate_hosts("<aqui_va_la_key>")

En la ruta del proyecto se genera un archivo llamado hosts-do.txt donde se insertan el resultado de las ejecuciones.
