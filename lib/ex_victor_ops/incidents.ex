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

  *Note: Because of limitations of VictorOps' API, regardless of the filters
  passed in arguments, all incidents are pulled from the VictorOps API and
  then filtered.*

  Args:
    * `phase` - Filters incident by phase. Can be one of `:unacked`, `:acked`, or `:resolved`. Defaults to nil, or all incidents
    * `team` - Team slug to get incidents for. Defaults to nil, or all teams
  """
  @spec get(:atom, String.t) :: {:atom, any()}
  def get(phase \\ nil, team \\ nil) do
    response = Api.get("incidents")
    if response.status_code == 200 do
      Poison.decode response.body, as: %Entities.Incident{}
      # TODO: Parse the specific phase or team for arguments
    else
      {:error, ApiError.error_for response.status_code}
    end
  end
end
