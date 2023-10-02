defmodule Redox.Request do
  alias __MODULE__
  require Logger
  alias Redox.Request.Data

  defstruct query: nil, url: "", data: nil, auth: false, access_token: nil, legacy: false

  def new(url) do
    %Request{url: url}
  end

  def new(url, query, access_token) do
    %Request{url: url, query: query, access_token: access_token}
  end

  def put_data(request) do
    %{request | data: Data.to_redox(request.query)}
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

  def send(%Request{url: url, data: data, auth: false, access_token: access_token}) do
    IO.inspect(data: data)
    # Todo make better ex. handle auth token expired more gracefully 
    case HTTPoison.post(url, Jason.encode!(data), [
           {"Content-Type", "application/json"},
           {"Authorization", "Bearer #{access_token}"}
         ]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> Jason.decode!() |> Data.from_redox()

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        Logger.error(
          "Redox.Request.send status_code=#{inspect(status_code)} body=#{inspect(body)}"
        )

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Redox.Request.send reason=#{inspect(reason)}")
    end
  end

  def send(%Request{url: url, data: data, auth: true, legacy: false}) do
    # make better
    body = URI.encode_query(data)

    case HTTPoison.post(url, body, %{"Content-Type" => "application/x-www-form-urlencoded"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body)

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        Logger.error(
          "Redox.Request.send status_code=#{inspect(status_code)} body=#{inspect(body)}"
        )

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Redox.Request.send reason=#{inspect(reason)}")
    end
  end

  def send(%Request{url: url, data: data, auth: true, legacy: true}) do
    # make better
    body = Jason.encode!(data)

    case HTTPoison.post(url, body, %{"Content-Type" => "application/json"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body)

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        Logger.error(
          "Redox.Request.send status_code=#{inspect(status_code)} body=#{inspect(body)}"
        )

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Redox.Request.send reason=#{inspect(reason)}")
    end
  end
end
