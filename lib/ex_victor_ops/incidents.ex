defmodule ExVictorOps.Incidents do
  @moduledoc """
  Interacts wit hthe Incidents endpoints of the VictorOps API.

  *Note: Because of limitations of VictorOps' API, regardless of the filters
  passed in arguments, all incidents are pulled from the VictorOps API and
  then filtered.*

  ## Examples

      ExVictorOps.Incidents.get
      > # All incidents

      ExVictorOps.Incidents.get :triggered
      > # All incidents which have not been acked or resolved

      ExVictorOps.Incidents.get nil,
  """
  alias ExVictorOps.Api
  alias ExVictorOps.Entities
  alias ExVictorOps.ApiError

  @doc """
  Gets all incidents for organization
  """
  @spec get() :: {:ok, [%Entities.Incident{}]} | {:error, Map.t}
  def get do
    response = Api.get("incidents")
    if response.status_code == 200 do
      incidents = Poison.decode!(response.body, as: %{"incidents" => [%Entities.Incident{}]})["incidents"]
      {:ok, incidents}
    else
      {:error, ApiError.error_for response.status_code}
    end
  end

  @doc """
  Returns current incidents filtered by phase and/or team.

  Args:
    * `phase` - Filters incident by phase. Can be one of `:triggered`, `:acked`, or `:resolved`. Defaults to nil, or all incidents
    * `team` - Team slug to get incidents for. Defaults to nil, or all teams
  """
  @spec get(:atom, String.t) :: {:ok, [any()]} | {:error, Map.t}
  def get(phase, team) do
    {status, response} = get
    if status == :ok do
      incidents = response
        |> filter_incidents(phase, team)
      {status, incidents}
    else
      {status, response}
    end
  end

  @doc """
  Returns current incidents filtered by phase.

  Args:
    * `phase` - Filters incident by phase. Can be one of `:triggered`, `:acked`, or `:resolved`. Defaults to nil, or all incidents
  """
  @spec get(:atom) :: {:ok, [%Entities.Incident{}]} | {:error, Map.t}
  def get(phase) when is_atom(phase) and not is_nil(phase) do
    get(phase, nil)
  end

  @doc """
  Returns current incidents filtered by team.

  Args:
    * `team` - Team slug to get incidents for.
  """
  @spec get(String.t) :: {:ok, [%Entities.Incident{}]} | {:error, Map.t}
  def get(team) when is_bitstring(team) and not is_nil(team) do
    get(nil, team)
  end 

  defp filter_incidents(incidents, phase, team) do
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
