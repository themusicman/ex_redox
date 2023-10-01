defmodule Redox.Request do
  alias __MODULE__

  defstruct query: nil, url: "", data: nil, auth: false, access_token: nil, legacy: false

  def new(url) do
    %Request{url: url}
  end

  def new(url, query, access_token) do
    %Request{url: url, query: query, access_token: access_token}
  end

  def put_data(request) do
    %{request | data: Redox.Request.Serializer.encode(request.query)}
  end

  def put_api_key(_request, nil, _secret), do: raise("api_key must be configured")
  def put_api_key(_request, _api_key, nil), do: raise("secret must be configured")
  def put_api_key(_request, nil, nil), do: raise("api_key and secret must be configured")

  def put_api_key(request, api_key, secret) do
    %{request | data: %{"apiKey" => api_key, "secret" => secret}}
  end

  def send(%Request{url: _url, data: nil}) do
    raise "data can't be nil"
  end

  def send(%Request{url: url, data: data, auth: false, access_token: access_token, query: query}) do
    IO.inspect(data: data)
    # Todo make better ex. handle auth token expired more gracefully 
    case HTTPoison.post(url, Jason.encode!(data), [
           {"Content-Type", "application/json"},
           {"Authorization", "Bearer #{access_token}"}
         ]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Redox.Request.Serializer.decode(query, Jason.decode!(body))

      {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 401, body: body}} ->
        IO.puts("401")
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        IO.puts(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def send(%Request{url: url, data: data, auth: true, legacy: false}) do
    # make better
    body = URI.encode_query(data)

    case HTTPoison.post(url, body, %{"Content-Type" => "application/x-www-form-urlencoded"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body)

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        IO.inspect(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def send(%Request{url: url, data: data, auth: true, legacy: true}) do
    # make better
    body = Jason.encode!(data)

    case HTTPoison.post(url, body, %{"Content-Type" => "application/json"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body)

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        IO.inspect(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
