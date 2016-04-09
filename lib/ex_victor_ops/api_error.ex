defmodule ExVictorOps.ApiError do
  defstruct [:code, :message]

  @doc """
  Returns the error code and error message for a specific status code in a tuple

  Args:
    * `status_code` - HTTP status code returned by VictorOps API

  Returns `{code, message}` for the status code
  """
  @spec error_for(Integer.t) :: %ExVictorOps.ApiError{}
  def error_for(status_code) do
    case status_code do
      200 -> %ExVictorOps.ApiError{code: :success, message: "Request successful"}
      400 -> %ExVictorOps.ApiError{code: :argument_error, message: "Problem with the request arguments."}
      401 -> %ExVictorOps.ApiError{code: :authentication_error, message: "Authentication parameters missing"}
      403 -> %ExVictorOps.ApiError{code: :authentication_error, message: "Authentication failed or rate-limit reached"}
      404 -> %ExVictorOps.ApiError{code: :resource_not_found, message: "Resource not found"}
      500 -> %ExVictorOps.ApiError{code: :server_error, message: "VictorOps server error"}
    end
  end
end
