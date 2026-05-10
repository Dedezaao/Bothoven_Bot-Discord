defmodule BeethovenBot.Commands.Filosofia do
  alias Nostrum.Struct.Embed

  @imagem_bothoven_filosofia "https://i.imgur.com/QlyLSeq.jpeg"

  def executar(_args) do
    try do
      with {:ok, frase_en} <- buscar_sabedoria(),
           {:ok, frase_pt} <- traduzir_frase(frase_en) do
        formar_embed(frase_en, frase_pt)
      else
        {:error, msg} -> "⚠️ Maestro confuso! #{msg}"
        _ -> "⚠️ Ocorreu um silêncio no acervo. As APIs estão fora do ar."
      end
    rescue
      _ -> "⚠️ As cordas arrebentaram (Erro interno ao processar a API). Tente novamente!"
    end
  end

  defp buscar_sabedoria do
    case buscar_citação_kanye() do
      {:ok, frase} when is_binary(frase) -> {:ok, frase}
      _ -> buscar_conselho_reserva() # Vai pro plano B se o Kanye falhar
    end
  end

  defp buscar_citação_kanye do
    url = "https://api.kanye.rest/"
    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        # Sem exclamação para não crashar se vier lixo da internet
        case Jason.decode(body) do
          {:ok, %{"quote" => quote}} when is_binary(quote) -> {:ok, quote}
          _ -> {:error, "Kanye enviou um formato inválido"}
        end
      _ -> {:error, "Kanye offline"}
    end
  end

  defp buscar_conselho_reserva do
    url = "https://api.adviceslip.com/advice"
    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, res} -> {:ok, get_in(res, ["slip", "advice"])}
          _ -> {:error, "Falha ao ler conselho reserva"}
        end
      _ -> {:error, "Todas as fontes falharam."}
    end
  end

  defp traduzir_frase(texto) when is_binary(texto) do
    termo_encode = URI.encode(texto)
    url = "https://api.mymemory.translated.net/get?q=#{termo_encode}&langpair=en|pt"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, json} ->
            traducao = get_in(json, ["responseData", "translatedText"])
            if traducao, do: {:ok, traducao}, else: {:error, "Tradução vazia."}
          _ -> {:error, "Falha na API de Tradução."}
        end
      _ -> {:error, "Serviço de tradução indisponível."}
    end
  end
  defp traduzir_frase(_), do: {:error, "Texto inválido para tradução"}

  defp formar_embed(en, pt) do
    embed =
      %Embed{}
      |> Embed.put_title("🔮 Reflexões do Maestro")
      |> Embed.put_description("""
      **Em português:**
      📜 _"#{pt}"_

      **Original (EN):**
      🗣️ _"#{en}"_
      """)
      |> Embed.put_color(0xFFD700)
      |> Embed.put_image(@imagem_bothoven_filosofia)

    [embed: embed]
  end
end
