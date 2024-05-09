defmodule Extrakt.Request do
  defstruct method: "", path: "", response_body: "", status_code: nil

  def full_status(request), do: "#{request.status_code} #{status(request.status_code)}"

  defp status(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error",
    }[code]
  end
end
