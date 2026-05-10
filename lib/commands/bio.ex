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

    termo = String.replace(artista, " ", "_")
    url = "https://pt.wikipedia.org/api/rest_v1/page/summary/#{URI.encode(termo)}"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> extrair_e_formatar(artista)

      {:ok, %{status_code: 404}} ->
        "🎼 Não encontrei a biografia para esse artista. Certeza que o nome está certo?"

      {:error, _} ->
        "🎹 Minhas cordas arrebentaram tentando conectar na Wikipedia. Tente novamente!"
    end
  end

  defp extrair_e_formatar(json, artista_buscado) do

    resumo = Map.get(json, "extract", "Biografia não disponível.")

    url_wiki = get_in(json, ["content_urls", "desktop", "page"]) || "https://pt.wikipedia.org"

    img_url = get_in(json, ["thumbnail", "source"])

    resumo_limpo = String.slice(resumo, 0..1500)

    embed =
        %Embed{}
        |> Embed.put_title("📖 Biografia: #{artista_buscado}")
        |> Embed.put_description("#{resumo_limpo}...\n\n🔗 **[Ler completa na Wikipedia](#{url_wiki})**")
        |> Embed.put_color(0x9D00FF)

    embed = if img_url, do: Embed.put_thumbnail(embed, img_url), else: embed

    [embed: embed]
    end
end
