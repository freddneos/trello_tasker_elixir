defmodule TrelloTaskerElixir.Shared.Services.Trello do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.trello.com/1"
  plug Tesla.Middleware.Headers, [{"User-Agent", "request"}]
  plug Tesla.Middleware.JSON

  @token Application.get_env(:trello_tasker_elixir, :trello)[:token]
  @key Application.get_env(:trello_tasker_elixir, :trello)[:key]
  @list_id "5fe02f8cbc5b9b0af4762401"
  #@card_id "t4BEc9zf"

  def get_card(card_id) do
    {:ok, response} =
      ("/cards/#{card_id}?list=true&key=" <> @key <> "&token=" <> @token)
      |> get()

    status = response.status

    if status !== 200 do
      {:error, "error on request"}
    else
      body = response.body
      {:ok, post_date, _} = body["due"] |> DateTime.from_iso8601()

      %{
        post_title: body["name"],
        post_content: body["desc"],
        post_image: body["cover"]["scaled"] |> List.last() |> Map.get("url"),
        post_id: body["shortLink"],
        post_date: post_date |> DateTime.to_date(),
        post_author: body["idMembers"] |> List.first(),
        labels: body["labels"],
        list_id: body["list"]["id"],
        list_name: body["list"]["name"]
      }
      |> IO.inspect()
    end
  end

  def get_cards_all(list_id, keyword) do
    {:ok, response} =
      ("/lists/#{@list_id}/cards?&key=" <> @key <> "&token=" <> @token)
      |> get()

    status = response.status

    if status !== 200 do
      {:error, "error on request"}
    else
      body = response.body

      posts =
        body
        |> Enum.filter(fn x ->
          String.downcase(x["name"]) =~ String.downcase(keyword) ||
            String.downcase(x["desc"]) =~ String.downcase(keyword)
        end)
        |> Enum.map(fn elem ->
          {:ok, post_date, _} = elem["due"] |> DateTime.from_iso8601()

          %{
            post_title: elem["name"],
            post_content: elem["desc"],
            post_id: elem["shortLink"],
            post_date: post_date |> DateTime.to_date(),
            post_author: elem["idMembers"] |> List.first(),
            post_cover_id: elem["post_date"]
          }
        end)

      %{
        posts: posts
      }
      |> IO.inspect()
    end
  end

  def get_cards_all(list_id) do
    {:ok, response} =
      ("/lists/#{@list_id}/cards?&key=" <> @key <> "&token=" <> @token)
      |> get()

    status = response.status

    if status !== 200 do
      {:error, "error on request"}
    else
      body = response.body

      posts =
        body
        |> Enum.map(fn elem ->
          {:ok, post_date, _} = elem["due"] |> DateTime.from_iso8601()

          %{
            post_title: elem["name"],
            post_content: elem["desc"],
            post_id: elem["shortLink"],
            post_date: post_date |> DateTime.to_date(),
            post_author: elem["idMembers"] |> List.first(),
            post_cover_id: elem["post_date"]
          }
        end)
    end
  end
end

# card - t4BEc9zf
# list - 5fe02f8cbc5b9b0af4762401
# board - 5fe02f81cebf424c52b33f91
# Code -> TrelloTaskerElixir.Shared.Services.Trello.get_card "t4BEc9zf"
# Code -> TrelloTaskerElixir.Shared.Services.Trello.get_card_all "5fe02f8cbc5b9b0af4762401","dia"
