defmodule BeethovenBot.Commands.Top do
  alias Nostrum.Struct.Embed

  def buscar(args) do
    texto_completo = Enum.join(args, " ")

    case String.split(texto_completo, " - ") do
      [pais, genero] ->
        fazer_requisicao(String.trim(pais), String.trim(genero))

      _ -> "⚠️ Maestro confuso! Use o formato: `!top País - Gênero` (Ex: `!top Brasil - Forró`)"
    end
  end

  defp fazer_requisicao(pais, genero) do
    termo_busca = URI.encode("#{pais} #{genero}")
    url = "https://itunes.apple.com/search?term=#{termo_busca}&media=music&entity=song&limit=10"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("results", [])
        |> formatar_ranking(pais, genero)

      {:error, _} ->
        "🎹 As cordas arrebentaram. O Maestro não conseguiu buscar o ranking agora!"
    end
  end

  defp formatar_ranking([], pais, genero) do
    "🎼 Não encontrei nenhum sucesso de **#{genero}** no **#{pais}**. Tente outro ritmo!"
  end

  defp formatar_ranking(musicas, pais, genero) do

    ranking_texto =
      musicas
      |> Enum.take(5)
      |> Enum.with_index(1)
      |> Enum.map(fn {track, index} ->
        "**#{index}.** #{track["trackName"]} - _#{track["artistName"]}_"
      end)
      |> Enum.join("\n\n")

    embed =
      %Embed{}
      |> Embed.put_title("🏆 Top 5: #{genero} (#{pais})")
      |> Embed.put_description(ranking_texto)
      |> Embed.put_color(0x9D00FF)

    [embed: embed]
  end
end
