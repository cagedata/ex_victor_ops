defmodule ExVictorOps.Entities.OnCall do
  @moduledoc """
  Entity model to store on-call rotations for a team

  {
    "team": "string",
    "schedule": [
      {
        "oncall": "string",
        "overrideoncall": "string",
        "policyType": "string",
        "rotationName": "string",
        "shiftName": "string",
        "shiftRoll": 0,
        "rolls": [
          {
            "change": 0,
            "until": 0,
            "oncall": "string",
            "isRoll": true
          }
        ]
      }
    ],
    "overrides": [
      {
        "orig": "string",
        "over": "string",
        "start": 0,
        "end": 0
      }
    ]
  }
  """
  @derive [Poison.Encoder]
  defstruct team: nil, schedule: [], overrides: []

end
