defmodule Extrakt.Context do
  defstruct method: "",
            path: "",
            response_body: "",
            status_code: nil,
            params: %{},
            headers: %{}

  def full_status(context), do: "#{context.status_code} #{status(context.status_code)}"

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
