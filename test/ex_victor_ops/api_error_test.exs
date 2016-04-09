defmodule ExVictorOps.ApiErrorTest do
  use ExUnit.Case, async: false
  alias ExVictorOps.ApiError

  doctest ExVictorOps.ApiError

  test "it returns success for 200 status code" do
    assert %ApiError{code: :success, message: _} = ApiError.error_for 200
  end

  test "it returns argument error for 400 status code" do
    assert %ApiError{code: :argument_error, message: _} = ApiError.error_for 400
  end

  test "it returns auth error for 401 status code" do
    assert %ApiError{code: :authentication_error, message: _} = ApiError.error_for 401
  end

  test "it returns auth error for 403 status code" do
    assert %ApiError{code: :authentication_error, message: _} = ApiError.error_for 403
  end

  test "it returns not found error for 404 status code" do
    assert %ApiError{code: :resource_not_found, message: _} = ApiError.error_for 404
  end

   test "it returns server error for 500 status code" do
     assert %ApiError{code: :server_error, message: _} = ApiError.error_for 500
   end
end
