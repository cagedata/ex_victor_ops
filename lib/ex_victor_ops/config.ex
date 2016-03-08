defmodule ExVictorOps.Config do
    @moduledoc """
    Stores configuration variables used to communicate with VictorOps' API.
    """

    @doc """
    Returns the API ID for your account. Set it in `config/config.exs`:

        config :ex_victor_ops, api_id: "YOUR_API_ID"
    """
    def api_id, do: Application.get_env(:ex_victor_ops, :api_id)

    @doc """
    Returns the API Key for your account. Set it in `config/config.exs`:

        config :ex_victor_ops, api_key: "YOUR_API_KEY"
    """
    def api_key, do: Application.get_env(:ex_victor_ops, :api_key)

    @doc """
    Returns the domain fo the VictorOps API. Defaults api.victorops.com", but can be overridden
    in `config/config.exs`

        config :ex_victor_ops, api_domain: "other.victorops.com"
    """
    def api_domain, do: Application.get_env(:ex_victor_ops, :api_domain) || "api.victorops.com"

    @doc """
    Returns the version of the API that ExVictorOps is going to talk to. Defaults to "v1", but
    can be overriden in `config/config.exs`

        config :ex_victor_ops, api_version: "vX"
    """
    def api_version, do: Application.get_env(:ex_victor_ops, :api_version) || "v1"

    @doc """
    Returns the combines base URL for the VictorOps API, using the configuration settings given.
    """
    def base_url do
      "https://#{api_domain}/api-public/#{api_version}/"
    end
end
