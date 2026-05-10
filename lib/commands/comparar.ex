defmodule BeethovenBot.Commands.Comparar do
  alias Nostrum.Struct.Embed

  def batalha(args) do

    texto_completo = Enum.join(args, " ")

    case String.split(texto_completo, " x ") do
      [artista1, artista2] ->
        processar_batalha(String.trim(artista1), String.trim(artista2))

      _ ->
        "⚠️ Maestro confuso! Use o formato: `!comparar Artista 1 x Artista 2`"
    end
  end

  defp processar_batalha(art1, art2) do
    with {:ok, nome1, ouv1} <- pegar_dados_artista(art1),
         {:ok, nome2, ouv2} <- pegar_dados_artista(art2) do

      vencedor = if ouv1 > ouv2, do: nome1, else: nome2

      formatar_numero = fn num ->
        num |> Integer.to_charlist() |> Enum.reverse() |> Enum.chunk_every(3) |> Enum.join(".") |> String.reverse()
      end

      embed =
        %Embed{}
        |> Embed.put_title("⚔️ Batalha de Titãs do Bothoven")
        |> Embed.put_description("""
        **#{nome1}**
        🎧 Ouvintes: #{formatar_numero.(ouv1)}

        🆚

        **#{nome2}**
        🎧 Ouvintes: #{formatar_numero.(ouv2)}

        🏆 **Vencedor:** #{vencedor}!
        """)
        |> Embed.put_color(0x9D00FF)

      [embed: embed]
    else
      {:error, msg} -> "⚠️ Erro na batalha: #{msg}"
    end
  end

  defp pegar_dados_artista(artista) do
    api_key = System.get_env("LASTFM_TOKEN")
    url = "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{URI.encode(artista)}&api_key=#{api_key}&format=json"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        json = Jason.decode!(body)

        if Map.has_key?(json, "error") do
          {:error, "Não achei a partitura de #{artista}."}
        else
          nome = get_in(json, ["artist", "name"])
          ouvintes = get_in(json, ["artist", "stats", "listeners"]) |> String.to_integer()

          {:ok, nome, ouvintes}
        end

      _ ->
        {:error, "A API falhou na conexão."}
    end
  end
end
