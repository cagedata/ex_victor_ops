defmodule ExVictorOps.Incidents do
  @moduledoc """
  Interacts wit hthe Incidents endpoints of the VictorOps API.

  ## Examples

      ExVictorOps.Incidents.get
  """
  alias ExVictorOps.Api
  alias ExVictorOps.Entities
  alias ExVictorOps.ApiError

  @doc """
  Returns current incidents.

  TODO: Args are not implemented yet
  *Note: Because of limitations of VictorOps' API, regardless of the filters
  passed in arguments, all incidents are pulled from the VictorOps API and
  then filtered.*

  Args:
    * `phase` - Filters incident by phase. Can be one of `:unacked`, `:acked`, or `:resolved`. Defaults to nil, or all incidents
    * `team` - Team slug to get incidents for. Defaults to nil, or all teams
  """
  @spec get(:atom, String.t) :: {:ok, [any()]} | {:error, Map.t}
  def get(phase \\ nil, team \\ nil) do
    response = Api.get("incidents")
    if response.status_code == 200 do
      incidents = Poison.decode!(response.body)["incidents"]
        |> Enum.map(&struct(Entities.Incident, &1))
      {:ok, incidents}
    else
      {:error, ApiError.error_for response.status_code}
    end
  end
end
