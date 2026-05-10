![alt text](image/Bothoven Faixa.png)

# Bothoven 🎼

O **BeethovenBot** é um assistente musical para Discord desenvolvido como projeto da disciplina de **Programação Funcional**. O bot combina uma estética *Synthwave/Cyberpunk* com o poder do Elixir para oferecer consultas a APIs musicais e gestão de acervo pessoal.

## Tecnologias Utilizadas

* **Elixir 1.19+**: Linguagem funcional com foco em concorrência e resiliência.
* **Nostrum**: Framework para integração com a API do Discord.
* **HTTPoison**: Cliente HTTP para consumo de APIs REST.
* **Jason**: Serialização e desserialização de dados JSON.

## Arquitetura do Projeto

Seguindo os princípios de responsabilidade única e imutabilidade:

* `BeethovenBot.Application`: Supervisor da árvore de processos (OTP).
* `BeethovenBot.Consumer`: Handler central que realiza o despacho de comandos via **Pattern Matching**.
* `BeethovenBot.Store`: Módulo de persistência que gerencia o arquivo `favoritos.json`.
* `BeethovenBot.Commands.*`: Módulos especializados para cada comando (`Bio`, `Cantar`, `Top`, etc).

## Configuração e Execução

### 1. Variáveis de Ambiente

Para segurança, o projeto não contém tokens expostos no código. Configure-os no seu terminal antes de iniciar:

```powershell
# No PowerShell
$env:DISCORD_TOKEN="SEU_TOKEN_DO_DISCORD"
$env:LASTFM_TOKEN="SUA_CHAVE_DA_LASTFM"
```

### 2. Executando o Bot

```
# Instalar dependências
mix deps.get

# Iniciar o Maestro
iex.bat -S mix
```

## Comandos Disponíveis


| **Comando**     | **Descrição**                                            | **Exemplo de Uso**                    |
| --------------- | ---------------------------------------------------------- | ------------------------------------- |
| `!help`         | Exibe o guia visual com todos os comandos.                 | `!help`                               |
| `!musica`       | Sugere um hit pop aleatório (iTunes API).                 | `!musica`                             |
| `!letra`        | Busca a letra de uma música (Lyrics.ovh).                 | `!letra Skank - Vamos Fugir`          |
| `!bio`          | Biografia e foto do artista (Last.fm API).                 | `!bio Post Malone`                    |
| `!top`          | Lista o ranking das 5 mais ouvidas por região e ritmo.    | `!top Brasil - Forró`                |
| `!comparar`     | Batalha de ouvintes entre dois artistas (**with**).        | `!comparar Queen x Beatles`           |
| `!cantar`       | **[API Mista]**Une letra, capa do álbum e link de áudio. | `!cantar Bob Marley - Is This Love`   |
| `!favoritar`    | Salva uma música no seu acervo pessoal (**JSON**).        | `!favoritar Mágica - Calcinha Preta` |
| `!favoritos`    | Lista todas as músicas salvas no seu arquivo local.       | `!favoritos`                          |
| `!desfavoritar` | Remove uma música específica do seu acervo JSON.         | `!desfavoritar Mágica`               |
