defmodule DoApi do
  @moduledoc """
  Documentation for DoApi.
  """

  defp generate_hosts(bearer) do
    HTTPoison.start()
    headers = [Authorization: "Bearer #{bearer}", Accept: "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 50_000]

    case HTTPoison.get("https://api.digitalocean.com/v2/droplets", headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, file} = File.open("#{Path.absname("hosts-do.txt")}", [:append])
        {:ok, json} = Jason.decode(body)

        Enum.map(json["droplets"], fn droplet ->
          [network | _] = droplet["networks"]["v4"]
          IO.write(file, "#{network["ip_address"]}\t\t#{droplet["name"]}\n")
        end)

        File.close(file)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end


  defp list_droplet_info(bearer) do
    HTTPoison.start()
    headers = [Authorization: "Bearer #{bearer}", Accept: "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 50_000]

    case HTTPoison.get("https://api.digitalocean.com/v2/droplets", headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, file} = File.open("#{Path.absname("droplets_list.txt")}", [:append])
        {:ok, json} = Jason.decode(body)

        Enum.map(json["droplets"], fn droplet ->
          IO.write(
            file,
            "#{droplet["name"]}\t#{droplet["memory"]}\t#{droplet["vcpus"]}\t#{droplet["disk"]}\t#{
              droplet["features"]
            }\n"
          )
        end)

        File.close(file)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  @doc """
  Llama a la funcion de listar droplets
    https://developers.digitalocean.com/documentation/v2/#droplets


  iex > DoApi.query_dropplets_list()
  [_,_]

  """
  def query_droplets_list() do
    case keys = Application.get_env(:do_api, :projects_key, []) do
      [] ->
        IO.puts("Debe configurar por lo menos una key de Digital Ocean Api en configs.exs")

      [_ | _] ->
        Enum.map(keys, fn bearer ->
          list_droplet_info(bearer)
        end)
    end
  end

  @doc """
  LLama a la funcion de generar el archivo hosts
  https://developers.digitalocean.com/documentation/v2/#droplets


  iex > DoApi.build_hosts_file()
  [_,_]

  """
  def build_hosts_file() do
    case keys = Application.get_env(:do_api, :projects_key, []) do
      [] ->
        IO.puts("Debe configurar por lo menos una key de Digital Ocean Api en configs.exs")

      [_ | _] ->
        Enum.map(keys, fn bearer ->
          generate_hosts(bearer)
        end)
    end
  end
end
