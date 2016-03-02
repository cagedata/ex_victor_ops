defmodule ExVictorOps.OnCallTest do
  use ExUnit.Case, async: false
  alias ExVictorOps.Api
  alias ExVictorOps.OnCall
  alias ExVictorOps.Config
  import Mock

  setup do
    doc = File.read!("./test/support/team-on-call.json")
    {:ok, doc: doc}
  end

  test_with_mock "calls the base module", %{doc: doc}, Api, [], [get: fn(_url) -> doc end] do
    OnCall.get_team("support-team")
    assert called Api.get(:_)
  end
end
