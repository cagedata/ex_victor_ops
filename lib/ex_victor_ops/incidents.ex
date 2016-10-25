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
    * `phase` - Filters incident by phase. Can be one of `:triggered`, `:acked`, or `:resolved`. Defaults to nil, or all incidents
    * `team` - Team slug to get incidents for. Defaults to nil, or all teams
  """
  @spec get(:atom, String.t) :: {:ok, [any()]} | {:error, Map.t}
  def get(phase \\ nil, team \\ nil) do
    response = Api.get("incidents")
    if response.status_code == 200 do
      incidents = Poison.decode!(response.body, as: %{"incidents" => [%Entities.Incident{}]})["incidents"]
        |> filter_incidents(phase, team)
      # No need to filter if we don't need to
      {:ok, incidents}
    else
      {:error, ApiError.error_for response.status_code}
    end
  end

  defp filter_incidents(incidents, phase \\ nil, team \\ nil) do
    if phase || team do
      Enum.filter(incidents, fn(incident) ->
        # Test phase and team
        testPhase = if phase != nil, do: incident.currentPhase == victorops_phase(phase), else: true
        testTeam = if team != nil, do: Enum.member?(incident.pagedTeams, team), else: true
        testPhase && testTeam
      end)
    else
      incidents
    end
  end

  defp victorops_phase(filter) do
    case filter do
      :triggered -> "UNACKED"
      :acked -> "ACKED"
      :resolved -> "RESOLVED"
      _ -> raise "Invalid phase #{Atom.to_string filter}."
    end
  end
end
