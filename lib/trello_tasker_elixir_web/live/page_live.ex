defmodule TrelloTaskerElixirWeb.PageLive do
  use TrelloTaskerElixirWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect("Primeiro lugar")
    {:ok, assign(socket, query: "", results: %{})}
  end
end
