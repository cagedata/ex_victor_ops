defmodule ExVictorOps.OnCallTest do
  use ExUnit.Case, async: false
  import Mock

  doctest ExVictorOps.OnCall

  setup do
    team = %HTTPotion.Response{
      body: File.read!("./test/support/team-on-call.json"),
      status_code: 200,
      headers: []
    }
    user = %HTTPotion.Response{
      body: File.read!("./test/support/user-on-call.json"),
      status_code: 200,
      headers: []
    }
    {:ok, team: team, user: user}
  end

  test_with_mock "get_team returns a single OnCall Entity instance", %{team: team}, ExVictorOps.Api, [], [get: fn(_url) -> team end] do
    {:ok, team} = ExVictorOps.OnCall.get_team("support-team")
    assert %ExVictorOps.Entities.OnCall{} = team
  end

  test_with_mock "get_user returns a list of OnCall Entity instances", %{user: user}, ExVictorOps.Api, [], [get: fn(_url) -> user end] do
    {:ok, user} = ExVictorOps.OnCall.get_user("dlong")
    assert is_list user
    for schedule <- user, do: assert %ExVictorOps.Entities.OnCall{} = schedule
  end
end
