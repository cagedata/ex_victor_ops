defmodule ExVictorOps.Api do
  @moduledoc """
  Provides a basic HTTP client for the VictorOps API by wrapping `HTTPotion`.

  ## Examples

  Requests are made by calling the method for the request passing in the path to the API resource:

    ExVictorOps.Api.get("team/support/oncall/schedule")
    %HTTPotion.Response({...})
  """
  use HTTPotion.Base
  alias ExVictorOps.Config

  def process_url(url) do
    Config.base_url <> url
  end

  def process_request_headers(headers) do
    Dict.put(headers, :"User-Agent", "ex-victor-ops")
    |> Dict.put(:"X-VO-Api-Id", Config.api_id)
    |> Dict.put(:"X-VO-Api-Key", Config.api_key)
  end

  def process_response_body(body) do
    body |> IO.iodata_to_binary
  end
end
