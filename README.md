# Ordle

Ordle é um jogo de adivinhação baseado na série **Ordem Paranormal**, com desafios diários onde o jogador deve descobrir o personagem ou monstro oculto.

---

## Funcionalidades

| ID  | Funcionalidade          | Descrição |
|-----|-------------------------|-----------|
| 1   | Ferramenta de Busca     | Permite pesquisar personagens por nome, listando apenas os que começam com a string digitada. |
| 2   | Categoria 1: Clássico   | O jogador escolhe um personagem e o sistema retorna comparativos dos atributos (gênero, idade, etc.), indicando se estão corretos, incorretos ou parcialmente corretos. |
| 2.1 | Dica                    | Após 5 tentativas no modo clássico, o jogador pode solicitar uma dica sobre o status do personagem (Vivo, Morto ou Indeterminado). |
| 3   | Categoria 2: Monstro    | Uma imagem do monstro é revelada aos poucos a cada tentativa errada (dividida em 9 partes). |
| 4   | Categoria 3: Emojis     | Emojis são revelados progressivamente como dicas sobre o personagem oculto. Após o acerto, todos os emojis são exibidos. |
| 5   | Categoria 4: Falas      | O jogador recebe uma frase dita por um personagem e deve adivinhar quem a disse. |
| 6   | Não-Repetição           | Controle para garantir que o mesmo personagem não seja escolhido novamente dentro de um período de 30 dias. |

---

## Como Executar

### Versão em Haskell

1. Certifique-se de ter o [Stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/) instalado.
2. Navegue até a pasta `ordle_haskell/`.
3. Execute os comandos:

```bash
stack setup
stack build
stack run
```

4. O jogo abrirá automaticamente no navegador usando a interface gráfica da biblioteca **Threepenny-GUI**.

---

### Versão em Prolog

1. Instale o [SWI-Prolog](https://www.swi-prolog.org/Download.html).
2. Navegue até a pasta `ordle_prolog/backend/src/`.
3. Inicie o backend.

```bash
swipl main.pl
```

4. Navegue até a pasta `ordle_prolog/frontend/src/`.

5. Inicie o frontend.

```bash
swipl main.pl
```

6. A partir disso, os predicados definidos estarão disponíveis para interação e execução do jogo.

---


