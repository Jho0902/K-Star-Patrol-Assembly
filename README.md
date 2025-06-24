# K-Star Patrol (8086 Assembly)

> Um simulador de batalha espacial retrô inspirado no jogo *K-Star Patrol*, desenvolvido em Assembly para a arquitetura x86.

## 🎮 Sobre o Jogo

K-Star Patrol é um jogo de nave no qual o jogador percorre três setores, enfrenta naves inimigas e acumula pontos evitando colisões. Desenvolvido inteiramente em Assembly 8086, o jogo simula uma batalha espacial em modo gráfico (video mode 13h - 320x200 com 256 cores).

### Telas e Estados do Jogo

- **Menu Inicial:** Opções "Jogar" e "Sair", com animação de naves.
- **Setor (1, 2 e 3):** Tela de introdução de cada setor com delay de 4 segundos.
- **Gameplay:** Nave controlável com teclas `W` e `S`, inimigos, tiros e pontuação.
- **Vencedor:** Tela final com score ao concluir os 3 setores.
- **Game Over:** Tela de encerramento caso a nave colida ou o tempo acabe.

---

## 🧠 Estrutura do Código

O projeto é dividido logicamente em estados e procedimentos que controlam:

### 🚀 Mecânicas de Jogo

- **Movimentação da Nave:** Teclas `W` e `S` controlam a nave verticalmente.
- **Tiros e Colisões:** Há detecção de colisão com inimigos e disparos.
- **Pontuação e Timer:** A pontuação é exibida dinamicamente no HUD.

### 📦 Organização do Código

- `INICIO`: Ponto de entrada, define o modo de vídeo e menu.
- `SETOR1`, `SETOR2`, `SETOR3`: Controlam a lógica de cada fase.
- `RENDERIZAR_*`: Procedimentos para desenhar sprites e HUD.
- `TRATAR_ENTRADA`: Captura de teclas e movimentações.
- `ATUALIZA_TEMPO`: Atualização do timer com base no RTC (`INT 1Ah`).
- `VENCEDOR` / `GAME_OVER`: Telas de encerramento.

---

## 🧰 Tecnologias

- **Assembly 8086**
- **EMU8086 / GUI Turbo Assembler**
- **BIOS interrupts** (`int 10h`, `int 15h`, `int 16h`, `int 1Ah`)

---

## 📊 Uso de Memória

- **Dados estáticos:** ~19 bytes
- **Código compilado:** ~16 KB
- **Variáveis:** `menu`, `setor`, `timer_do_jogo`, `score`, entre outras.

---

## 🎯 Funcionalidades de Destaque

- Modo gráfico com navegação animada.
- Timer real usando o RTC do BIOS.
- Organização modular por procedimentos (`PROC`).
- Sprites desenhados diretamente na memória de vídeo `A000h`.

---

## ⚠️ Desafios Enfrentados

- Dificuldades com geração de números pseudoaleatórios via RTC.
- Implementação de colisão e controle de fases.
- Familiarização com rotinas gráficas em modo real.

---

## ▶️ Como Executar

1. Abra o projeto com [GUI Turbo Assembler](https://github.com/ljnath/GUI-Turbo-Assembler)
2. Compile `jogo.asm`
3. Execute no emulador embutido ou em uma VM com DOSBox + TASM

> **Obs:** O jogo foi testado no Emu8086 e GUI Turbo Assembler.

---

## 👥 Autores

- [Bruna Chies](https://github.com/bruchies)
- [Jhonatan Martins](https://github.com/Jho0902)

---

## 📚 Referências

- [The Art of Assembly - Randall Hyde](https://www.artofasm.com/)
- [EMU8086 Help Docs](http://www.emu8086.com/doc.html)
- [Assembly Programming (Princeton)](https://www.cs.princeton.edu/courses/archive/spring98/cs217/lectures/8086/)
- [GUI Turbo Assembler](https://github.com/ljnath/GUI-Turbo-Assembler)

