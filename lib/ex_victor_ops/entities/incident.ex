defmodule ExVictorOps.Entities.Incident do
  @moduledoc """
  Entity model to store incidents

    {
      "alertCount": 3,
      "currentPhase": "RESOLVED",
      "entityDisplayName": "Disk IO &gt; 90% for at least 15 minutes - CCG-SRV-01",
      "entityId": "newrelicV2-3738/*",
      "entityState": "OK",
      "entityType": "SERVICE",
      "host": "",
      "incidentNumber": "1316",
      "incidentUrl": "https://portal.victorops.com/client/cage-data-inc#/incident/1316",
      "lastAlertId": "bdf73e39-8273-4c7d-98fc-78e8fe8f0263",
      "lastAlertTime": "2016-04-09T08:54:26Z",
      "monitorType": "NewRelic",
      "service": "Disk IO &gt; 90% for at least 15 minutes - CCG-SRV-01",
      "startTime": "2016-04-09T06:20:18Z",
      "pagedTeams": [
        "support-team"
      ],
      "pagedUsers": [
        "aaldrich",
        "ctotzke"
      ],
      "transitions": [
        {
          "name": "ACKED",
          "at": "2016-04-09T07:07:42Z",
          "message": "",
          "manually": true
        },
        {
          "name": "RESOLVED",
          "at": "2016-04-09T08:54:26Z",
          "by": "SYSTEM",
          "manually": false
        }
      ]
    }
  """
  @derive [Poison.Encoder]
  defstruct incidentNumber: nil, startTime: nil, currentPhase: nil, alertCount: 0,
    lastAlertTime: nil, lastAlertId: nil, entityId: nil, host: nil, service: nil,
    pagedUsers: [], pagedTeams: [], transitions: []
end
