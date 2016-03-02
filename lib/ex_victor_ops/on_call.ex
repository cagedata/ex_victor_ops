defmodule ExVictorOps.OnCall do
  @moduledoc """
  Interacts with the On-Call endpoints of the VictorOps API.

  ## Examples

      ExVictorOps.OnCall.get_team "support"
      %HTTPotion.Response({...})

      ExVictorOps.OnCall.get_user "davejlong"
      %HTTPotion.Response({...})
  """
  alias ExVictorOps.Api
  alias __MODULE__

  @doc """
  Returns a team's on-call schedule from the VictorOps API.

  Args can contain any of the following:
  - days_forward (default: 14): Days to include in returned schedule
  - days_skip (default: 0): Days to skip before computing schedule to return
  - step (default: 0): Step of escalation policy
  """
  def get_team(team, args \\ %{}) do
    qs = %{
      daysForward: args[:days_forward] || 14,
      daysSkip: args[:days_skip] || 0,
      step: args[:step] || 0
    }
    qs = Enum.map_join(qs, "&", fn({k, v}) -> "#{k}=#{v}" end)
    Api.get("team/#{team}/oncall/schedule?#{qs}")
  end

  @doc """
  Returns a user's on-call schedule across all teams from the VictorOps API.

  Args can contain any of the following:
  - days_forward (default: 14): Days to include in returned schedule
  - days_skip (default: 0): Days to skip before computing schedule to return
  - step (default: 0): Step of escalation policy
  """
  def get_user(user, args \\ %{}) do
    qs = %{
      daysForward: args[:days_forward] || 14,
      daysSkip: args[:days_skip] || 0,
      step: args[:step] || 0
    }
    qs = Enum.map_join(qs, "&", fn({k, v}) -> "#{k}=#{v}" end)
    Api.get("user/#{user}/oncall/schedule?#{qs}")
  end
end
