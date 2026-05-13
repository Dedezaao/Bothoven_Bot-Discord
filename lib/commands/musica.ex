defmodule BeethovenBot.Commands.Musica do

  alias Nostrum.Struct.Embed

  @itunes_api_url "https://itunes.apple.com/search?term=pop&media=music&entity=song&limit=50"

  def musica_aleatoria do
    case HTTPoison.get(@itunes_api_url) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("results")
        |> Enum.random()
        |> formar_embed()

      {:error, _} -> "🎹 Beethoven perdeu a batuta... tente novamente!"
    end
  end


  defp formar_embed(track) do
    embed =
      %Embed{}
      |> Embed.put_title("Receba essa Pedrada Musical!")
      |> Embed.put_description("🎼 **#{track["trackName"]}** de **#{track["artistName"]}**")
      |> Embed.put_color(0x9D00FF)
      |> Embed.put_image(@imagem_bothoven_filosofia)

    [embed: embed]
  end


end
