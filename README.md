# do_api
Utilidades para interactuar con la api de Digital Ocean

https://developers.digitalocean.com/documentation/v2/

En la interface administrativa en Digital Ocean para cada team o usuario se debe obtener una key.

Dependencias:

- Erlang Virtual Machine
- Elixir 1.8 o superior

Luego de clonar este proyecto, ejecutar en el directorio del mismo mix deps.get para instalar las dependencias.

Para inicial la consola del proyecto iex -S mix

iex> DoApi.generate_hosts("<aqui_va_la_key>")

En la ruta del proyecto se genera un archivo llamado hosts-do.txt donde se insertan el resultado de las ejecuciones.
