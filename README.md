![alt text](image/Bothoven Faixa.png)

# Maestro Bothoven 🎼

O **Maestro Bothoven** é um assistente musical para Discord desenvolvido como projeto final da disciplina de **Programação Funcional** (UNIFOR). O bot combina uma estética *Synthwave/Cyberpunk* com o poder do Elixir para oferecer consultas a APIs musicais e gestão de acervo pessoal.

---

### NOTA PARA A AVALIAÇÃO (AV2)

> **Professor**, ao iniciar o bot, utilize o comando `!prova`.
> Ele exibirá um card de auditoria que mapeia cada comando realizado às 7 APIs REST distintas exigidas, demonstrando o cumprimento de todos os requisitos de parâmetros e encadeamento solicitados no PDF.

---

## Tecnologias Utilizadas

* **Elixir 1.19+**: Linguagem funcional com foco em concorrência, imutabilidade e resiliência.
* **Nostrum**: Framework para integração com a API do Discord.
* **HTTPoison**: Cliente HTTP para consumo de APIs REST.
* **Jason**: Serialização e desserialização de dados JSON.

## Arquitetura do Projeto

A estrutura segue o princípio de responsabilidade única e modularização:

```text
beethoven_bot/
├── config/             # Configurações e Tokens (Variáveis de Ambiente)
├── lib/
│   ├── commands/       # Módulos especializados das 7 APIs + Extras
│   ├── consumer.ex     # Cérebro do Bot (Dispatcher via Pattern Matching)
│   └── store.ex        # Lógica de Persistência (Interface com o JSON)
├── favoritos.json      # Banco de Dados Local (Persistência)
└── mix.exs             # Gerenciador de Dependências
```

## Configuração e Execução

### 1. Variáveis de Ambiente

Para garantir a segurança, o projeto não possui credenciais no código-fonte. Configure as variáveis de ambiente no seu terminal (PowerShell) antes de iniciar a aplicação:

```powershell
$env:DISCORD_TOKEN="SEU_TOKEN_AQUI"
$env:LASTFM_TOKEN="SUA_CHAVE_AQUI"
```

### 2. Iniciar o Maestro

Com as variáveis carregadas, instale as dependências e inicie o bot no modo interativo:

```bash
# Instalar dependências
mix deps.get

# Iniciar o bot 
iex.bat -S mix
```

## Acervo de Comandos

Todos os comandos foram projetados para tratar falhas de rede de forma resiliente e retornar cards visuais customizados (Embeds).

### 📋 Oficiais da Avaliação (As 7 APIs)


| Comando         | API Utilizada        | Tipo          | Descrição                                            | Exemplo de Uso                        |
| :-------------- | :------------------- | :------------ | :----------------------------------------------------- | :------------------------------------ |
| `!prova`        | **-**                | **Especial**  | **Valida e lista todos os requisitos da prova.**       | `!prova`                              |
| `!musica`       | **iTunes**           | 0 Params      | Sugere um hit pop aleatório.                          | `!musica`                             |
| `!bio`          | **Wikipedia**        | 1 Param       | Resumo biográfico dinâmico do artista.               | `!bio Post Malone`                    |
| `!hit`          | **Deezer**           | 1 Param       | Busca o sucesso nº 1 do artista no ranking.           | `!hit The Weeknd`                     |
| `!letra`        | **Lyrics.ovh**       | 2 Params      | Busca a letra da canção informada.                   | `!letra Skank - Vamos Fugir`          |
| `!comparar`     | **Last.fm**          | 2 Params      | Batalha de estatísticas de ouvintes.                  | `!comparar Queen x Beatles`           |
| `!filosofia`    | **Kanye + MyMemory** | **Mista**     | **Encadeamento:** Gera citação e traduz o resultado. | `!filosofia`                          |
| `!favoritar`    | **JSON Local**       | Persistência | Salva uma música no`favoritos.json`.                  | `!favoritar Mágica - Calcinha Preta` |
| `!favoritos`    | **JSON Local**       | Persistência | Lista todas as músicas do seu acervo.                 | `!favoritos`                          |
| `!desfavoritar` | **JSON Local**       | Persistência | Remove uma música do seu acervo.                      | `!desfavoritar Mágica`               |

### 🌟 Funcionalidades Extras (Bônus)


| Comando   | Descrição                                             | Exemplo de Uso                      |
| :-------- | :------------------------------------------------------ | :---------------------------------- |
| `!help`   | Exibe o guia visual completo do Bothoven.               | `!help`                             |
| `!top`    | Lista o ranking das 5 mais ouvidas por região e ritmo. | `!top Brasil - Forró`              |
| `!cantar` | Une a letra com a capa do álbum e prévia de áudio.   | `!cantar Bob Marley - Is This Love` |

---

**Desenvolvido por Ricardo André Rodrigues Bandeira**
