defmodule ExVictorOps.IncidentsTest do
  use ExUnit.Case, async: false
  import Mock
  doctest ExVictorOps.Incidents

  setup do
    incidents = %HTTPotion.Response{
      body: File.read!("./test/support/incidents.json"),
      status_code: 200,
      headers: []
    }
    error = %HTTPotion.Response{
      body: "",
      status_code: 500,
      headers: []
    }

    {:ok, incidents: incidents, error: error}
  end

  test_with_mock "get returns a set of Incidents", %{incidents: incidents}, ExVictorOps.Api, [], [get: fn(_url) -> incidents end] do
    {:ok, incidents} = ExVictorOps.Incidents.get
    assert is_list incidents
    assert %ExVictorOps.Entities.Incident{} = List.first(incidents)
  end

  test_with_mock "get can return ApiError", %{error: error}, ExVictorOps.Api, [], [get: fn(_url) -> error end] do
    {:error, error} = ExVictorOps.Incidents.get
    assert %ExVictorOps.ApiError{} = error
  end

  test_with_mock "gets only triggered Incidents", %{incidents: incidents}, ExVictorOps.Api, [], [get: fn(_url) -> incidents end] do
    {:ok, incidents} = ExVictorOps.Incidents.get(:triggered)
    assert is_list incidents
    assert Enum.count(incidents) == 1
    assert List.first(incidents).incidentNumber == "1223"
  end

  test_with_mock "gets only dev team Incidents", %{incidents: incidents}, ExVictorOps.Api, [], [get: fn(_url) -> incidents end] do
    {:ok, incidents} = ExVictorOps.Incidents.get(nil, "dev-team")
    assert is_list incidents
    assert Enum.count(incidents) == 1
    assert List.first(incidents).incidentNumber == "1315"
  end
end
