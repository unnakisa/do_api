defmodule DoApi do
  @moduledoc """
  Documentation for DoApi.
  """

  def generate_hosts(bearer) do
    HTTPoison.start
    headers = ["Authorization": "Bearer #{bearer}", "Accept": "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 50_000]
    case HTTPoison.get("https://api.digitalocean.com/v2/droplets", headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, file} = File.open("#{Path.absname("hosts-do.txt")}", [:append])
        {:ok, json} = Jason.decode(body)
        Enum.map(json["droplets"], fn droplet ->
          [network|_] = droplet["networks"]["v4"]
          IO.write(file, "#{network["ip_address"]}\t\t#{droplet["name"]}\n")
        end)
        File.close(file)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end




