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
    error = %HTTPotion.Response{
      body: "",
      status_code: 500,
      headers: []
    }
    {:ok, team: team, user: user, error: error}
  end

  test_with_mock "get_team returns a single OnCall Entity instance", %{team: team}, ExVictorOps.Api, [], [get: fn(_url) -> team end] do
    {:ok, team} = ExVictorOps.OnCall.get_team("support-team")
    assert %ExVictorOps.Entities.OnCall{} = team
  end

  test_with_mock "get_team can return ApiError", %{error: error}, ExVictorOps.Api, [], [get: fn(_url) -> error end] do
    {:error, team} = ExVictorOps.OnCall.get_team("support-team")
    assert %ExVictorOps.ApiError{} = team
  end

  test_with_mock "get_user returns a list of OnCall Entity instances", %{user: user}, ExVictorOps.Api, [], [get: fn(_url) -> user end] do
    {:ok, user} = ExVictorOps.OnCall.get_user("dlong")
    assert is_list user
    for schedule <- user, do: assert %ExVictorOps.Entities.OnCall{} = schedule
  end

  test_with_mock "get_user can return ApiError", %{error: error}, ExVictorOps.Api, [], [get: fn(_url) -> error end] do
    {:error, error} = ExVictorOps.OnCall.get_user("dlong")
    assert %ExVictorOps.ApiError{} = error
  end
end
