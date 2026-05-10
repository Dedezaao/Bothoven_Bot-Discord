defmodule BeethovenBot.Commands.Cantar do
  alias Nostrum.Struct.Embed

  def executar(args) do
    texto_completo = Enum.join(args, " ")

    case String.split(texto_completo, " - ") do
      [artista, musica] ->
        misturar_apis(String.trim(artista), String.trim(musica))

      _ ->
        "⚠️ Maestro confuso! Use o formato: `!cantar Artista - Música`"
    end
  end

  defp misturar_apis(artista, musica) do
    with {:ok, capa_album, audio_preview} <- buscar_dados_itunes(artista, musica),
         {:ok, letra} <- buscar_letra(artista, musica) do

      letra_cortada = String.slice(letra, 0..1500)

      embed =
        %Embed{}
        |> Embed.put_title("🎤 #{musica} - #{artista}")
        |> Embed.put_description("#{letra_cortada}...\n\n🎧 **[Ouvir Prévia Original](#{audio_preview})**")
        |> Embed.put_thumbnail(capa_album)
        |> Embed.put_color(0x9D00FF)

      [embed: embed]
    else
      {:error, msg} -> "⚠️ #{msg}"
    end
  end

  defp buscar_dados_itunes(artista, musica) do
    termo = URI.encode("#{artista} #{musica}")
    url = "https://itunes.apple.com/search?term=#{termo}&media=music&entity=song&limit=1"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        resultados = Jason.decode!(body) |> Map.get("results", [])

        case resultados do
          [track | _] ->
            {:ok, track["artworkUrl100"], track["previewUrl"]}
          [] ->
            {:error, "Não achei a música no iTunes para pegar a capa."}
        end
      _ -> {:error, "Falha ao conectar no iTunes."}
    end
  end

  defp buscar_letra(artista, musica) do
    url = "https://api.lyrics.ovh/v1/#{URI.encode(artista)}/#{URI.encode(musica)}"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        letra = Jason.decode!(body) |> Map.get("lyrics")
        {:ok, letra}
      {:ok, %{status_code: 404}} ->
        {:error, "Não encontrei a letra dessa música."}
      _ ->
        {:error, "Falha ao conectar no site de letras."}
    end
  end
end
