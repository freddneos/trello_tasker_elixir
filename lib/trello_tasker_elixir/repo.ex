defmodule TrelloTaskerElixir.Repo do
  use Ecto.Repo,
    otp_app: :trello_tasker_elixir,
    adapter: Ecto.Adapters.Postgres
end
