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


Puede modificar la lista projects_key en config/config.exs y colocar todas las keys de los diferentes proyectos de su usuario en Digital Ocean.

Luego ejecutar

iex> DoApi.build_hosts_file()

para generar el mismo archivo pero de todos los proyectos.


Para obtener las características de los dropplets dentro de un proyecto.

iex> DoApi.list_droplet_info("aqui_va_la_key")


Si configuró projects_key en config/config.exs

iex> DoApi.query_droplets_list()