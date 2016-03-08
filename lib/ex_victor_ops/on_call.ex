defmodule ExVictorOps.OnCall do
  @moduledoc """
  Interacts with the On-Call endpoints of the VictorOps API.

  ## Examples

      ExVictorOps.OnCall.get_team "support"
      %ExVictorOps.Entity.OnCall({...})

      ExVictorOps.OnCall.get_user "davejlong"
      [%ExVictorOps.Entity.OnCall({...})]
  """
  alias ExVictorOps.Api
  alias ExVictorOps.Entities

  @doc """
  Returns a team's on-call schedule from the VictorOps API.

  Args:
    * `team` - Team slug to get from VictorOps
    * `options` - orddict of options to pass in the request

  Options:
    * `days_forward` - Days to include in returned schedule (30 max)
    * `days_skip` - Days to skip before computing schedule to return (90 max)
    * `step` - Step of escalation policy (3 max)

  Returns `ExVictorOps.Entities.OnCall` if successful.
  """
  @spec get_team(String.t, [{atom(), String.t}]) :: %ExVictorOps.Entities.OnCall{}
  def get_team(team, options \\ []) do
    qs = %{
      daysForward: options[:days_forward] || 14,
      daysSkip: options[:days_skip] || 0,
      step: options[:step] || 0
    }
    qs = Enum.map_join(qs, "&", fn({k, v}) -> "#{k}=#{v}" end)
    response = Api.get("team/#{team}/oncall/schedule?#{qs}")
    if response.status_code == 200 do
      Poison.decode response.body, as: Entities.OnCall
    else
    end
  end

  @doc """
  Returns a user's on-call schedule across all teams from the VictorOps API.

  Args:
    * `user` - User to get from VictorOps
    * `options` - orddict of options to pass in the request

  Options:
    * `days_forward` - Days to include in returned schedule (30 max)
    * `days_skip` - Days to skip before computing schedule to return (90 max)
    * `step` - Step of escalation policy (3 max)

  Returns `ExVictorOps.Entities.OnCall` if successful.
  """
  @spec get_user(String.t, [{atom(), String.t}]) :: %ExVictorOps.Entities.OnCall{}
  def get_user(user, options \\ []) do
    qs = %{
      daysForward: options[:days_forward] || 14,
      daysSkip: options[:days_skip] || 0,
      step: options[:step] || 0
    }
    qs = Enum.map_join(qs, "&", fn({k, v}) -> "#{k}=#{v}" end)
    response = Api.get("user/#{user}/oncall/schedule?#{qs}")
    if response.status_code == 200 do
      Poison.decode response.body, as: [Entities.OnCall]
    else
    end
  end
end
