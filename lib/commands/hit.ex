defmodule BeethovenBot.Commands.Hit do
  alias Nostrum.Struct.Embed

  def executar(args) do
    artista = Enum.join(args, " ") |> String.trim()

    if artista == "" do
      "⚠️ Maestro confuso! Digite: `!hit Nome do Artista`"
    else
      fazer_busca(artista)
    end
  end

  defp fazer_busca(artista) do
    # Buscamos pelo artista e ordenamos pela popularidade (ranking)
    url = "https://api.deezer.com/search?q=artist:\"#{URI.encode(artista)}\"&order=RANKING&limit=1"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> processar_resultado(artista)

      {:error, _} ->
        "🎹 A orquestra do Deezer desafinou. Tente novamente!"
    end
  end

  defp processar_resultado(%{"data" => [track | _]}, _artista) do

    titulo = track["title"]
    album = get_in(track, ["album", "title"])
    capa = get_in(track, ["album", "cover_medium"])
    link_ouvou = track["link"]
    preview = track["preview"]
    nome_artista = get_in(track, ["artist", "name"])

    embed =
      %Embed{}
      |> Embed.put_title("🔥 Hit do Momento: #{nome_artista}")
      |> Embed.put_description("""
      🎶 **Música:** #{titulo}
      💿 **Álbum:** #{album}

      🎧 **[Ouvir no Deezer](#{link_ouvou})** | **[Prévia](#{preview})**
      """)
      |> Embed.put_thumbnail(capa)
      |> Embed.put_color(0x9D00FF)

    [embed: embed]
  end

  defp processar_resultado(_, artista) do
    "🎼 Não consegui encontrar o maior hit de '#{artista}' no Deezer."
  end
end
