defmodule ExVictorOps.Config do
    @moduledoc """
    Stores configuration variables used to communicate with VictorOps' API.
    """

    @doc """
    Returns the API ID for your account. Set it in `config/config.exs`:

        config :ex_victor_ops, api_id: "YOUR_API_ID"

    ## Examples

        iex> ExVictorOps.Config.api_id
        "foobar"
    """
    def api_id, do: Application.get_env(:ex_victor_ops, :api_id)

    @doc """
    Returns the API Key for your account. Set it in `config/config.exs`:

        config :ex_victor_ops, api_key: "YOUR_API_KEY"

    ## Examples

        iex> ExVictorOps.Config.api_key
        "helloworld"
    """
    def api_key, do: Application.get_env(:ex_victor_ops, :api_key)

    @doc """
    Returns the domain fo the VictorOps API. Defaults api.victorops.com", but can be overridden
    in `config/config.exs`

        config :ex_victor_ops, api_domain: "other.victorops.com"

    ## Examples

        iex> ExVictorOps.Config.api_domain
        "api.victorops.com"
    """
    def api_domain, do: Application.get_env(:ex_victor_ops, :api_domain) || "api.victorops.com"

    @doc """
    Returns the version of the API that ExVictorOps is going to talk to. Defaults to "v1", but
    can be overriden in `config/config.exs`

        config :ex_victor_ops, api_version: "vX"

    ## Examples

        iex> ExVictorOps.Config.api_version
        "v1"
    """
    def api_version, do: Application.get_env(:ex_victor_ops, :api_version) || "v1"

    @doc """
    Returns the combines base URL for the VictorOps API, using the configuration settings given.

    ## Examples

      iex> ExVictorOps.Config.base_url
      "https://api.victorops.com/api-public/v1/"
    """
    def base_url do
      "https://#{api_domain}/api-public/#{api_version}/"
    end
end
