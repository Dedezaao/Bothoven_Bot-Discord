defmodule BeethovenBot.Commands.Bio do

  alias Nostrum.Struct.Embed

  def buscar(args) do
    artista = Enum.join(args, " ")
    |> String.trim()

    if artista == "" do
      "⚠️ Maestro confuso! Digite no formato: `!bio Nome do Artista`"
    else
      fazer_requisicao(artista)
    end

  end

  defp fazer_requisicao(artista) do

    api_key = System.get_env("LASTFM_TOKEN")


    url = "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{URI.encode(artista)}&api_key=#{api_key}&format=json&lang=pt"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> extrair_e_formatar(artista)

      {:ok, %{status_code: 404}} ->
        "🎼 Não encontrei a biografia para esse artista. Certeza que o nome está certo?"

      {:error, _} ->
        "🎹 Minhas cordas arrebentaram tentando conectar na API. Tente novamente!"
    end
  end

  defp extrair_e_formatar(json, _artista_buscado) do

    nome = get_in(json, ["artist", "name"])
    bio_completa = get_in(json, ["artist", "bio", "content"]) || "Biografia não disponível."
    url_artista = get_in(json, ["artist", "url"])

    imagens = get_in(json, ["artist", "image"]) || []
      img_url = case List.last(imagens) do
        %{"#text" => url} when url != "" -> url
        _ -> nil
    end

    bio_limpa =
      bio_completa
      |> String.split("<a href")
      |> List.first()
      |> String.trim()
      |> String.slice(0..1500)

    embed =
        %Embed{}
        |> Embed.put_title("📖 Biografia: #{nome}")
        |> Embed.put_description("#{bio_limpa}...\n\n🔗 **[Ler completa no Last.fm](#{url_artista})**")
        |> Embed.put_color(0x9D00FF)

    embed = if img_url, do: Embed.put_thumbnail(embed, img_url), else: embed

    [embed: embed]
  end

end
