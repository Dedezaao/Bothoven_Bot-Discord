defmodule BeethovenBot.Commands.Letra do

  def buscar_letra(args) do

    texto_completo = Enum.join(args, " ")

    case String.split(texto_completo, " - ") do
      [artista, musica] ->
        fazer_requisicao(String.trim(artista), String.trim(musica))

      _ -> "⚠️ Maestro confuso! Digite no formato: `!letra Artista - Nome da Música`"

    end
  end

  defp fazer_requisicao(artista, musica) do
    url = "https://api.lyrics.ovh/v1/#{URI.encode(artista)}/#{URI.encode(musica)}"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("lyrics")
        |> formatar_letra(artista, musica)

      {:ok, %{status_code: 404}} ->
        "🎼 Não encontrei a partitura para essa música. Certeza que o nome está certo?"

      {:error, _} ->
        "🎹 Minhas cordas arrebentaram tentando conectar na API. Tente novamente!"
    end
  end

  def formatar_letra(letra, artista, musica) do
    letra_cortada = String.slice(letra, 0..1800)
    "🎤 **#{musica}** - _#{artista}_\n\n#{letra_cortada}..."
  end

end
