.model small
.stack

.data
    menu db 0
    ; 0 - Menu
    ; 1 - Setor
    ; 2 - Jogo
    ; 3 - Fim de Jogo
    ; 4 - Fim Setor
    tela db 0
    setor db 1
    

    
    timer_do_jogo dw 60
    last_rtc_timer db ?
    score db "00000$"

    string_score db "Score: $"
    string_tempo db "Tempo: $"
    
    timer dw 0
    ; Strings para o t?tulo e bot?es

    string  db 7 dup(" ")," _  __   ___ _            ",13,10
            db 7 dup(" "),"| |/ /__/ __| |_ __ _ _ _ ",13,10
            db 7 dup(" "),"| ' <___\__ \  _/ _` | '_|",13,10
            db 7 dup(" "),"|_|\_\  |___/\__\__,_|_|  ",13,10
            db 7 dup(" ")," ___      _           _   ",13,10
            db 7 dup(" "),"| _ \__ _| |_ _ _ ___| |  ",13,10
            db 7 dup(" "),"|  _/ _` |  _| '_/ _ \ |  ",13,10
            db 7 dup(" "),"|_| \__,_|\__|_| \___/_|  ",13,10

    comprimento_string equ $-string

    setor_um  db 5 dup(" "), " ___       _              _    ",13,10
              db 5 dup(" "), "/ __| ___ | |_ ___ _ _   / |   ",13,10
              db 5 dup(" "), "\__ \/ -_)|  _/ _ \ '_|  | |   ",13,10
              db 5 dup(" "), "|___/\___\ \__\___/_|    |_|   ",13,10

    setor_dois db 5 dup(" "), " ___       _              ___  ",13,10
               db 5 dup(" "), "/ __| ___ | |_ ___ _ _   |_  ) ",13,10
               db 5 dup(" "), "\__ \/ -_)|  _/ _ \ '_|   / /  ",13,10
               db 5 dup(" "), "|___/\___\ \__\___/_|    /___| ",13,10

    setor_tres db 5 dup(" "), " ___       _              ____ ",13,10
               db 5 dup(" "), "/ __| ___ | |_ ___ _ _   |__ / ",13,10
               db 5 dup(" "), "\__ \/ -_)|  _/ _ \ '_|   |_ \ ",13,10
               db 5 dup(" "), "|___/\___\ \__\___/_|    |___/ ",13,10

    comprimento_setor equ $-setor_tres

    vetor_setores dw offset setor_um, offset setor_dois, offset setor_tres

    btn_iniciar db  14 dup(" "),218,196,196,196,196,196,196,196,196,196,191,13,10
                 db 14 dup(" "),179,"  JOGAR  ",179,10,13
                 db 14 dup(" "),192,196,196,196,196,196,196,196,196,196,217,13,10

    comprimento_btn_iniciar equ $-btn_iniciar

    btn_sair db  14 dup(" "),218,196,196,196,196,196,196,196,196,196,191,13,10
              db 14 dup(" "),179,"  SAIR   ",179,10,13
              db 14 dup(" "),192,196,196,196,196,196,196,196,196,196,217,13,10

    comprimento_btn_sair equ $-btn_sair

    sprite_vazio db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    nave db 15,15,15,15,15,15,15,15,15,15,15,15,0,0,0
         db 0,0,15,15,0,0,0,0,0,0,0,0,0,0,0
         db 0,0,15,15,15,15,0,0,0,0,0,0,0,0,0
         db 0,0,15,15,15,15,15,15,0,0,0,0,0,0,0
         db 0,0,15,15,15,15,15,15,15,15,15,15,15,15,15
         db 0,0,15,15,15,15,15,15,0,0,0,0,0,0,0
         db 0,0,15,15,15,15,0,0,0,0,0,0,0,0,0
         db 0,0,15,15,0,0,0,0,0,0,0,0,0,0,0
         db 15,15,15,15,15,15,15,15,15,15,15,15,0,0,0

    posicao_nave dw 0

    vetor_pos_aliados dw 320 * 20, 320 * 40, 320 * 60, 320 * 80, 320 * 100, 320 * 120, 320 * 140, 320 * 160
    
    ; O nibble menos significativo representa a cor, o mais significativo representa morto/vivo (1/0)
    vetor_attr_aliados db 15H, 16H, 19H, 1AH, 1BH, 1CH, 1DH, 1EH

    nave_inimiga db 0,0,0,0,0,0,0,0,9,9,9,9,9,9,9
                 db 0,0,0,0,0,0,0,0,9,9,0,0,0,0,0
                 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                 db 0,0,0,0,9,9,9,9,0,0,0,0,0,0,0
                 db 9,9,9,9,9,9,9,9,9,9,9,9,0,0,0
                 db 0,0,0,0,9,9,9,9,0,0,0,0,0,0,0
                 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                 db 0,0,0,0,0,0,0,0,9,9,0,0,0,0,0
                 db 0,0,0,0,0,0,0,0,9,9,9,9,9,9,9

    posicao_nave_inimiga dw 0
    
    vetor_pos_inimigo dw 320 * 20 + 220, 320 * 40 + 240, 320 * 60 + 300, 320 * 80 + 210, 320 * 100 + 200, 320 * 120 + 180, 320 * 140 + 200, 320 * 160 + 260
    
    posicao_tiro_nave dw 0 ; Controle da posi??o do proj?til da nave l?der

    tiro_nave   db 15,15,15,15,15,15,15,15,15,0,0,0,0,0,0
                db 15 dup (0)
                db 15 dup (0)
                db 15 dup (0)
                db 0,0,0,0,0,0,15,15,15,15,15,15,15,15,15
                db 15 dup (0)
                db 15 dup (0)
                db 15 dup (0)
                db 15,15,15,15,15,15,15,15,15,0,0,0,0,0,0

   terreno db 320 dup(0)
        db 320 dup(0)
        db 168 dup(0),3 dup (6),149 dup(0)
        db 166 dup(0),6 dup (6),148 dup(0)
        db 34 dup(0),4 dup (6),7 dup(0),6 dup (6),63 dup(0),2 dup (6),25 dup(0),6 dup (6),18 dup(0),8 dup (6),87 dup(0),9 dup (6),51 dup(0)
        db 33 dup(0),6 dup (6),5 dup(0),9 dup (6),37 dup(0),9 dup (6),12 dup(0),7 dup (6),20 dup(0),10 dup (6),17 dup(0),9 dup (6),15 dup(0),5 dup (6),40 dup(0),5 dup (6),19 dup(0),11 dup (6),15 dup(0),4 dup (6),32 dup(0)
        db 12 dup(0),4 dup (6),16 dup(0),7 dup (6),4 dup(0),11 dup (6),17 dup(0),3 dup (6),15 dup(0),11 dup (6),10 dup(0),10 dup (6),15 dup(0),14 dup (6),15 dup(0),11 dup (6),13 dup(0),7 dup (6),8 dup(0),6 dup (6),23 dup(0),9 dup (6),15 dup(0),15 dup (6),12 dup(0),7 dup (6),30 dup(0)
        db 11 dup(0BH),7 dup (6),14 dup(0BH),23 dup (6),16 dup(0BH),3 dup (6),15 dup(0BH),11 dup (6),9 dup(0BH),11 dup (6),13 dup(0BH),17 dup (6),14 dup(0BH),12 dup (6),11 dup(0BH),9 dup (6),5 dup(0BH),9 dup (6),20 dup(0BH),12 dup (6),13 dup(0BH),17 dup (6),10 dup(0BH),9 dup (6),29 dup(0BH)
        db 1 dup (6),9 dup(0BH),10 dup (6),10 dup(0BH),26 dup (6),15 dup(0BH),5 dup (6),12 dup(0BH),34 dup (6),8 dup(0BH),21 dup (6),12 dup(0BH),14 dup (6),9 dup(0BH),11 dup (6),2 dup(0BH),13 dup (6),16 dup(0BH),17 dup (6),8 dup(0BH),20 dup (6),8 dup(0BH),11 dup (6),8 dup(0BH),3 dup (6),8 dup(0BH),6 dup (6),2 dup(0BH),1 dup (6)
        db 2 dup (6),7 dup(0BH),12 dup (6),8 dup(0BH),31 dup (6),10 dup(0BH),6 dup (6),10 dup(0BH),65 dup (6),11 dup(0BH),17 dup (6),7 dup(0BH),28 dup (6),12 dup(0BH),49 dup (6),5 dup(0BH),13 dup (6),5 dup(0BH),7 dup (6),4 dup(0BH),11 dup (6)
        db 3 dup (6),5 dup(0BH),14 dup (6),4 dup(0BH),36 dup (6),6 dup(0BH),10 dup (6),6 dup(0BH),68 dup (6),9 dup(0BH),19 dup (6),5 dup(0BH),109 dup (6),3 dup(0BH),8 dup (6),3 dup(0BH),12 dup (6)
        db 63 dup (6),4 dup(0BH),11 dup (6),4 dup(0BH),71 dup (6),7 dup(0BH),23 dup (6),1 dup(0BH),122 dup (6),1 dup(0BH),13 dup (6)
        db 320 dup (6)
        db 320 dup (6)
        db 320 dup (6)
        db 320 dup (6)
        db 320 dup (6)
        db 320 dup (6)
        db 320 dup (6)
        db 320 dup (6)

    terreno_pos dw 320 * 180
     
    
   vencedor db " __   __                  _         _ ",13,10
            db " \ \ / /__ _ _  __ ___ __| |___ _ _| |",13,10
            db "  \ V / -_) ' \/ _/ -_) _` / _ \ '_|_|",13,10
            db "   \_/\___|_||_\__\___\__,_\___/_| (_)",13,10

   comprimento_vencedor equ $-vencedor


    game_over   db 10 dup(" "), "  ___                ",13,10
                db 10 dup(" "), " / __|__ _ _ __  ___ ",13,10
                db 10 dup(" "), "| (_ / _` | '  \/ -_)",13,10
                db 10 dup(" "), " \___\__,_|_|_|_\___|",13,10
                db 10 dup(" "), " / _ \__ _____ _ _   ",13,10
                db 10 dup(" "), "| (_) \ V / -_) '_|  ",13,10
                db 10 dup(" "), " \___/ \_/\___|_|    ",13,10

    comprimento_game_over equ $-game_over
                
.code

;====NAVEGA??O NO MENU UTILIZANDO AS SETAS==============================
TRATAR_ENTRADA PROC
    cmp ah, 48H
    je SETA_CIMA

    cmp ah, 50H
    je SETA_BAIXO
    

    jmp FIM_TRATAR    
    
    
SETA_CIMA:
    xor ah, ah
    mov menu, ah

    jmp RENDER_BOTOES

SETA_BAIXO:
    mov ah, 1
    mov menu, ah     

RENDER_BOTOES:
    mov al, tela
    cmp al, 0
    jne FIM_TRATAR
    call IMPRIMIR_BOTOES

FIM_TRATAR:
    ret
ENDP

;==================TRATA AS ENTRADAS W e S PARA A NAVE=======================
TRATAR_ENTRADA_NAVE proc



    cmp al, 'S'          ; Verifica se a tecla ? "S"
    je MOVER_NAVE_BAIXO
    cmp al, 's'          ; Verifica se a tecla ? "s"
    je MOVER_NAVE_BAIXO
    
    cmp al, 'W'          ; Verifica se a tecla ? "W"
    je MOVER_NAVE_CIMA
    cmp al, 'w'          ; Verifica se a tecla ? "w"
    je MOVER_NAVE_CIMA


    jmp FIM_TRATAR_NAVE
    

MOVER_NAVE_BAIXO:
    
    call APAGAR_PIXEL_NAVE          ; Limpa a posi??o atual da nave
    mov ax, posicao_nave
    cmp ax, 320 * 160 + 32          ; Verifica o limite inferior
    jae FIM_TRATAR_NAVE             ; Se ultrapassar, n?o move
    add ax, 640                     ; Move uma linha para baixo
    mov posicao_nave, ax            ; Atualiza a posi??o
    call RENDERIZAR_NAVE_LIDER      ; Renderiza a nave
    jmp FIM_TRATAR_NAVE
    
MOVER_NAVE_CIMA:

    call APAGAR_PIXEL_NAVE         ; Limpa a posi??o atual da nave
    mov ax, posicao_nave
    cmp ax, 320 * 20 + 32     ; Limite superior (primeira nave aliada)
    jbe FIM_TRATAR_NAVE       ; N?o permite mover acima do limite
    sub ax, 640               ; Move uma linha para cima
    mov posicao_nave, ax
    call RENDERIZAR_NAVE_LIDER
    jmp FIM_TRATAR_NAVE
    
FIM_TRATAR_NAVE:
    ret
ENDP


APAGAR_PIXEL_NAVE PROC
    push ax
    push si

    mov ax, posicao_nave      ; Obt?m a posi??o atual da nave
    mov si, offset sprite_vazio ; Usa o sprite vazio
    call RENDERIZAR_SPRITE    ; Renderiza o sprite vazio

    pop si
    pop ax
    ret
ENDP



;===================================================================================


IMPRIMIR_TITULO_MENU proc
    mov ax, ds 
    mov es, ax

    mov bp, offset string
    mov cx, comprimento_string ; tamanho da string
    mov bl, 02H ; Cor verde (se bit 1 de AL estiver limpo, usamos BL)
    xor dx, dx ; linha/coluna
    call IMPRIMIR_STRING

    ret
ENDP

;=================================================================================

; BH = p?gina de v?deo
IMPRIMIR_STRING PROC
    push AX
    push BX
    push DS
    push ES
    push SI
    push BP

    ; Configura os par?metros para a fun??o 13h
    mov ah, 13h         ; Fun??o para escrever string com atributos de cor
    mov al, 1           ; Modo: atualiza cursor ap?s a escrita
                        ; AL = 1 -> modo de atualiza??o do cursor
    xor bh, bh          ; P?gina de v?deo 0
    int 10h             ; Chamada de interrup??o para exibir a string

    pop BP
    pop SI
    pop ES
    pop DS
    pop BX
    pop AX
    ret
ENDP

;===========================================================================================

; EXIBIR BOTOES NO MENU
IMPRIMIR_BOTOES proc
    push ax
    mov bl, 0FH
    mov ah, menu
    cmp ah, 0
    jne BOTAO_INICIAR
    mov bl, 0CH

BOTAO_INICIAR:
    ; Exibe o bot?o INICIAR
    mov bp, offset btn_iniciar
    mov cx, comprimento_btn_iniciar ; tamanho do bot?o
    xor dl, dl ; coluna
    mov dh, 18 ; linha
    call IMPRIMIR_STRING

    mov bl, 0FH
    mov ah, menu
    cmp ah, 1
    jne BOTAO_SAIR
    mov bl, 0CH

BOTAO_SAIR:
    mov bp, offset btn_sair
    mov cx, comprimento_btn_sair
    xor dl, dl ; coluna
    mov dh, 21 ; linha
    call IMPRIMIR_STRING

    pop ax
    ret
ENDP

;=====================================================================================

;PROCS PARA ALTERAR COR DAS NAVES E RENDERIZAR AS NAVES

; SI = ponteiro do sprite
; BL = cor
ALTERAR_COR_SPRITE proc
    push ax
    push bx
    push cx
    push si

    mov cx, 15*9

LOOP_PIXEL:
    mov al, [si]
    cmp al, 0
    jz PULAR_SUBSTITUIR
    mov [si], bl

PULAR_SUBSTITUIR:
    inc si
    loop LOOP_PIXEL

    pop si
    pop cx
    pop bx
    pop ax
    ret
endp

; AX = posi??o do sprite
; SI = ponteiro do sprite
RENDERIZAR_SPRITE proc
    push bx
    push cx
    push dx
    push di
    push es
    push ds
    push ax

    mov ax, @data
    mov ds, ax

    mov ax, 0A000h
    mov es, ax

    pop ax
    mov di, ax
    mov dx, 9
    push ax

DESENHAR_LINHA:
    mov cx, 15
    rep movsb
    add di, 320 - 15
    dec dx
    jnz DESENHAR_LINHA

    pop ax
    pop ds  
    pop es
    pop di
    pop dx
    pop cx
    pop bx
ret
endp


;==================================================


;PROCEDIMENTO PARA ANIMAR AS NAVES NO MENU
RESETAR_POSICOES_NAVES_MENU proc
    push ax

    mov ax, 100 * 320
    mov posicao_nave, ax
    add ax, 305
    mov posicao_nave_inimiga, ax

    pop ax
    ret
endp

NAVES_MENU proc
    mov ax, posicao_nave
    mov si, offset sprite_vazio
    
    push ax
    call RENDERIZAR_SPRITE
    pop ax

    cmp ax, 101*320-15
    je MOVER_NAVE_INIMIGA

    inc posicao_nave
    inc ax
    mov si, offset nave
    call RENDERIZAR_SPRITE

    xor cx, cx
    mov dx, 2710H
    mov ah, 86H
    int 15h
    jmp FIM_ATUALIZACAO

MOVER_NAVE_INIMIGA:
    mov ax, posicao_nave_inimiga
    mov si, offset sprite_vazio

    push ax
    cmp ax, 100*320
    pop ax

    je RESETAR_POSICOES
    call RENDERIZAR_SPRITE

    dec posicao_nave_inimiga
    dec ax
    mov si, offset nave_inimiga
    call RENDERIZAR_SPRITE
    
    xor cx, cx
    mov dx, 2710H
    mov ah, 86H
    int 15h
    jmp FIM_ATUALIZACAO

RESETAR_POSICOES:
    call RESETAR_POSICOES_NAVES_MENU

FIM_ATUALIZACAO:
    ret
ENDP

;=========================================================

CRIAR_NAVE_INIMIGA proc
    mov ax, posicao_nave_inimiga
    mov si, offset sprite_vazio

    push ax
    cmp ax, 100*320
    pop ax

    je RESETAR_POSICOES
    call RENDERIZAR_SPRITE

    dec posicao_nave_inimiga
    dec ax
    mov si, offset nave_inimiga
    call RENDERIZAR_SPRITE
    
    xor cx, cx
    mov dx, 2710H
    mov ah, 86H
    int 15h

ENDP
;=========================================================
;RENDERIZAR NAVES ALIADAS NOS SETORES

RENDERIZAR_NAVES_ALIADAS proc
    push dx
    push cx
    push bx
    push ax

    mov cx, 8
    mov bx, offset vetor_pos_aliados
    mov dx, offset vetor_attr_aliados

RENDERIZAR_NAVE_ALIADA:
    mov ax, [bx]
    mov si, offset nave

    push bx
    push ax

    mov bx, dx
    mov al, [bx]
    mov bl, al
    and bl, 0FH
    and al, 0F0H
    jnz NAO_REMOVE_NAVE ;verifica se o nibble mais significativo n?o ? zero (que significa que a nave esta ativa), caso o contrario ele ajusta o pontei de SI para o sprite_vazio
    mov si, offset sprite_vazio

NAO_REMOVE_NAVE:
    pop ax
    call ALTERAR_COR_SPRITE ;ALTERA A COR DAS NAVES ALIADAS
    call RENDERIZAR_SPRITE ;RENDERIZA A NAVE ALIADA

    pop bx
    add bx, 2
    inc dx
    loop RENDERIZAR_NAVE_ALIADA ;LOOP PARA RENDERIZAR TODAS AS NAVES ALIADAS 

    pop ax
    pop bx
    pop cx
    pop dx
    ret
ENDP


;RENDERIZAR NAVES ALIADAS NOS SETORES

RENDERIZAR_NAVES_INIMIGAS proc
    push dx
    push cx
    push bx
    push ax

    mov cx, 8
    mov bx, offset vetor_pos_inimigo

RENDERIZAR_NAVE_INIMIGA:
    mov ax, [bx]
    mov si, offset nave_inimiga

    push bx
    push ax

    mov bx, dx
    mov al, [bx]
    mov bl, al
    and bl, 0FH
    and al, 0F0H
    jmp CONTINUA_LOOP_INIMIGA

CONTINUA_LOOP_INIMIGA:
    pop ax
    call RENDERIZAR_SPRITE ;RENDERIZA A NAVE ALIADA

    pop bx
    add bx, 2
    inc dx
    loop RENDERIZAR_NAVE_INIMIGA ;LOOP PARA RENDERIZAR TODAS AS NAVES ALIADAS 

    pop ax
    pop bx
    pop cx
    pop dx
    ret
ENDP

;============================================================


;PROC PARA LIMPAR A TELA

LIMPAR_TELA proc
    push ax
    push cx
    push es
    push di

    mov ax,0A000h
    mov es,ax
    xor di, di
    mov cx, 32000d
    cld
    xor ax, ax
    rep stosw
    
    pop di
    pop es
    pop cx
    pop ax
    ret
ENDP

;==========================================================


;EXIBIR NOME DO SETOR (EX: SETOR 1)

;OBS: PARA ELE RENDERIZAR O SETOR 2 POR EXEMPLO, ANTES DE CHAMAR ESSA PROC FAZER UM -inc setor- 

RENDERIZAR_SETOR proc
    push ax
    push bx
    push cx
    push dx
    push bp

    call LIMPAR_TELA

    ; Imprimir Setor
    mov al, setor
    xor ah, ah
    dec al ; ?ndice do vetor

    shl al, 1 ; multiplica por 2 (como os valores no vetor s?o `dw`)
    mov bx, offset vetor_setores ; obt?m o vetor
    add bx, ax ; adiciona o ?ndice ao ponteiro do vetor
    mov bp, [bx] ; define BP para o endere?o base do setor
    mov cx, comprimento_setor
    xor dl, dl ; linha
    mov dh, 10
    mov bl, 0DH
    call IMPRIMIR_STRING

    pop bp
    pop dx
    pop cx
    pop bx
    pop ax
    ret
ENDP

;==================================================================


;SESS?O DA NAVE LIDER


;RESETA A NAVE PARA POSI??O INICIAL
RESETAR_NAVE_LIDER proc
    mov posicao_nave, 320 * 95 + 32 ; Posi??o inicial da nave
    ret
ENDP


ATUALIZAR_NAVE_LIDER proc
    ret
ENDP

;RENDERIZA A NAVE LIDER
RENDERIZAR_NAVE_LIDER proc
    push ax
    push bx
    push si

    mov ax, posicao_nave
    mov si, offset nave
    mov bl, 0FH ; branco

    call ALTERAR_COR_SPRITE ;DEFINE A COR DA NAVE LIDER P/ BRANCO
    call RENDERIZAR_SPRITE ;RENDERIZA A NAVE LIDER

    pop si
    pop bx
    pop ax
    ret
ENDP


;==================================================================

;FUN??ES PRATICAS

RESETAR proc ; Cont?m todos os procedimentos para redefinir valores
    call LIMPAR_TELA
    call RESETAR_NAVE_LIDER
    ret
ENDP

ATUALIZAR proc ; Cont?m todos os procedimentos para atualizar o estado do jogo
    call ATUALIZAR_NAVE_LIDER
    ret
ENDP

RENDERIZAR proc ; Cont?m todos os procedimentos para renderizar objetos do jogo 
    call RENDERIZAR_TERRENO
    call RENDERIZAR_NAVE_LIDER
    call RENDERIZAR_NAVES_ALIADAS
    call RENDERIZAR_NAVES_INIMIGAS
    ret
ENDP

;===================================================================
; Procedimento para inicializar o HUD (Heads-Up Display)
INICIA_HUD proc
    ; Escreve o t?tulo "SCORE"
    mov BL, 15   ; Cor branca
    mov DH, 0    ; Linha
    mov DL, 0    ; Coluna
    mov BP, offset string_score
    call ESC_STRING
    
    ; Exibe o valor do score inicial
    mov BL, 2    ; Cor verde
    add DL, 6    ; Ajusta a coluna para exibir o score
    mov BP, offset score
    call ESC_STRING
    
    ; Escreve o t?tulo "TEMPO"
    mov BL, 15   ; Cor branca
    mov DH, 0    ; Linha
    mov DL, 31   ; Coluna
    mov BP, offset string_tempo
    call ESC_STRING
    
    ; Configura o timer inicial e o exibe
    mov SI, offset timer
    mov SI, timer_do_jogo
    mov AX, SI
    call MUDA_TIMER

    stosw
    ret
endp

; Procedimento para atualizar o timer na HUD
MUDA_TIMER proc
    push ax
    push bx
    push cx
    push dx

    ; Limpa a ?rea do timer (espa?o reservado para "000")
    mov dh, 0        ; Linha
    mov dl, 38       ; Coluna
    call POS_CURSOR

    ; Exibe espa?os em branco para limpar o valor anterior
    mov cx, 3        ; Tr?s d?gitos no m?ximo
    mov al, ' '      ; Caractere espa?o
LIMPAR_TIMER:
    mov ah, 0Eh      ; Fun??o de sa?da de caractere
    int 10h
    loop LIMPAR_TIMER

    ; Exibe o novo valor do timer
    mov dh, 0        ; Linha
    mov dl, 38       ; Coluna
    call POS_CURSOR

    mov ax, [timer_do_jogo]   ; Carrega o valor do timer
    call ESC_UINT16           ; Exibe o valor atualizado

    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp


;=======================================================================

POS_CURSOR proc
    push ax
    push bx
    mov ah, 02                   ;Codigo da funcao
    int 10h                      ;Interrupcao
    pop bx
    pop ax
    ret
endp


ESC_UINT16 proc 
    push AX      ; Salvar registradores utilizados na proc
    push BX
    push CX
    push DX 
    ; Configurar o loop para processar cada d?gito
    mov bx, 10      ; Divisor para separa??o dos d?gitos (divis?o por 10)
    xor CX, CX      ; SI ser? usado para armazenar o n?mero de d?gitos (inicializa com 0)
convert_loop:
    xor dx, dx      ; Limpar o registrador DX (necess?rio para a divis?o)
    div bx          ; Dividir AX por 10. Quociente vai para AX e resto vai para DX (d?gito)
    push dx         ; Armazenar o d?gito no stack
    inc CX          ; Contar o n?mero de d?gitos
    cmp ax, 0     ; Verificar se ainda h? n?meros em AX
    jnz convert_loop ; Se AX n?o for zero, continuar o loop
    ; Exibir os d?gitos da pilha em ordem correta (do primeiro ao ?ltimo)
    mov AH, 09h    ; Fun??o de exibi??o (Teletype Output) via int 10h
    mov BL, 02h
print_loop:
    pop dx          ; Recuperar um d?gito da pilha
    add dl, '0'     ; Converter o d?gito (resto) para o c?digo ASCII
    mov AL, DL
    int 10h        ; Chamar interrup??o para exibir o caractere com a cor configurada
    
    call LER_CORDENADA_CURSOR
    
    inc DL
    call POS_CURSOR
    
    loop print_loop ; Continuar o loop at? que todos os d?gitos sejam exibidos
    
    pop DX
    pop CX
    pop BX
    pop AX
    ret     
endp

LER_CORDENADA_CURSOR proc
    push AX      ; Salvar registradores utilizados na proc
    push BX
    push CX
    
    mov AH, 03h
    int 10h    
    pop CX
    pop BX
    pop AX
    ret
endp

; Funcao para escrever texto na tela
; bl: cor
; dh: linha
; dl: coluna
; bp: end. inicio da string
ESC_STRING proc
    push es
    push ax
    push bx
    push dx
    push si
    push bp
    
    mov di, sp
    
    mov ax, ds
    mov es, ax
    
    mov bh, 0
    mov si, bp
    call CALCULA_TAM_STRING
    mov ah, 13h
    mov al, 1
    int 10h
    
    mov sp, di
    pop bp
    pop si
    pop dx
    pop bx
    pop ax
    pop es
    ret
endp

CALCULA_TAM_STRING proc
    push ax
    push si
    xor cx, cx
LOOP_TAM_STRING:
    xor ax, ax
    mov al, [si]
    cmp al, 36
    je FIM_TAM_STRING
    inc cx
    inc si
    
    jmp LOOP_TAM_STRING
    
FIM_TAM_STRING:
    pop si
    pop ax
    ret
endp


;===================================================================
;IMPLEMENTA??O DO TIMER

LER_RTC proc
    mov ah, 02h         ; Fun??o para ler hora do rel?gio
    int 1Ah             ; Interrup??o do BIOS para ler o RTC
    ret
endp

SALVAR_TEMPO_ATUAL proc
    push ax
    push dx
    call LER_RTC
    mov [last_rtc_timer], dh  ; Salva o valor dos segundos no RTC
    pop dx
    pop ax
    ret
endp

ATUALIZA_TEMPO proc
    mov ax, [timer_do_jogo]   ; Carrega o valor do timer atual
    dec ax                    ; Decrementa o timer
    mov [timer_do_jogo], ax   ; Salva o novo valor do timer
    call MUDA_TIMER           ; Atualiza o HUD
    ret
ENDP
;===================================================================
;delay de 4seg do setor

DELAY_SETOR proc
    push ax
    push cx
    push dx

    mov cx, 4       ; N?mero de segundos para esperar
DELAY_LOOP:
    mov dx, 0FFFFh  ; Aproximadamente 1 segundo
    mov ah, 86h     ; Fun??o de espera (BIOS)
    int 15h
    loop DELAY_LOOP ; Repete at? CX ser zero

    pop dx
    pop cx
    pop ax
    ret
endp

;===================================================================

RENDERIZAR_TERRENO proc
    push bx
    push cx
    push dx
    push di
    push es
    push ds
    push ax

    mov ax, @data
    mov ds, ax

    mov ax, 0A000h
    mov es, ax

    mov si, offset terreno
    mov di, terreno_pos
    dec terreno_pos
    mov bx, terreno_pos
    cmp terreno_pos, 320*180 - 1
    jnz PULAR_POS_APOS_ATUALIZAR
    mov terreno_pos, 320*181 - 1 

PULAR_POS_APOS_ATUALIZAR:
    mov cx, 320*20
    rep movsb

    pop ax
    pop ds  
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    ret
endp


;================================================

;===================================================================

;SESS?O PARA OS SETORES

SETOR1 proc
     
    ; Exibe o setor atual
    call RENDERIZAR_SETOR

    ; Pausa para exibi??o (4 segundos)
    call DELAY_SETOR

    
    call RESETAR
    
    ; Certifique-se de que est? no estado "Jogo"
    cmp menu, 2
    jne FIM_SETOR1

    
    
    call INICIA_HUD
    ; Configura o temporizador para gerar interrup??es
    MOV [timer_do_jogo], 10
    call SALVAR_TEMPO_ATUAL
    
    ; Atualiza o jogo
    call ATUALIZAR
    ; Renderiza os objetos do jogo
    call RENDERIZAR
        
SETOR1_LOOP:
    ; Captura entrada do usu?rio
    mov ah, 1H
    int 16H
    jz CONTINUAR_LOOP         ; Volta ao loop se nenhuma tecla foi pressionada

    ; L? a tecla pressionada
    mov ah, 0
    int 16H
    call TRATAR_ENTRADA_NAVE

CONTINUAR_LOOP:
    call LER_RTC              ; L? o RTC atual
    cmp dh, [last_rtc_timer]  ; Verifica se os segundos mudaram
    jne TEMPORIZAR            ; Se mudou, atualiza o timer
    jmp SETOR1_LOOP           ; Volta ao loop principal

TEMPORIZAR:
    call ATUALIZA_TEMPO       ; Atualiza o timer
    call SALVAR_TEMPO_ATUAL   ; Salva o novo valor do RTC
    cmp [timer_do_jogo], 0    ; Verifica se o timer chegou a zero
    jz FIM_SETOR1             ; Finaliza o setor se o timer zerar
    jmp SETOR1_LOOP           ; Continua no loop do setor


FIM_SETOR1:
    ;call VENCEDOR
    call GAME_OVER
    ;inc setor
    ;call SETOR2
    ret
ENDP


;SESS?O PARA OS SETORES

SETOR2 proc
     
    ; Exibe o setor atual
    call RENDERIZAR_SETOR

    ; Pausa para exibi??o (4 segundos)
    call DELAY_SETOR

    
    call RESETAR
    
    ; Certifique-se de que est? no estado "Jogo"
    cmp menu, 2
    jne FIM_SETOR2

    
    
    call INICIA_HUD
    ; Configura o temporizador para gerar interrup??es
    MOV [timer_do_jogo], 10
    call SALVAR_TEMPO_ATUAL
    
    ; Atualiza o jogo
    call ATUALIZAR
    ; Renderiza os objetos do jogo
    call RENDERIZAR
        
SETOR2_LOOP:
    ; Captura entrada do usu?rio
    mov ah, 1H
    int 16H
    jz CONTINUAR2_LOOP         ; Volta ao loop se nenhuma tecla foi pressionada

    ; L? a tecla pressionada
    mov ah, 0
    int 16H
    call TRATAR_ENTRADA_NAVE

CONTINUAR2_LOOP:
    call LER_RTC              ; L? o RTC atual
    cmp dh, [last_rtc_timer]  ; Verifica se os segundos mudaram
    jne TEMPORIZAR2            ; Se mudou, atualiza o timer
    jmp SETOR2_LOOP           ; Volta ao loop principal

TEMPORIZAR2:
    call ATUALIZA_TEMPO       ; Atualiza o timer
    call SALVAR_TEMPO_ATUAL   ; Salva o novo valor do RTC
    cmp [timer_do_jogo], 0    ; Verifica se o timer chegou a zero
    jz FIM_SETOR2             ; Finaliza o setor se o timer zerar
    jmp SETOR2_LOOP           ; Continua no loop do setor


FIM_SETOR2:
    inc setor
    call SETOR3
    ret
ENDP

SETOR3 proc
     
    ; Exibe o setor atual
    call RENDERIZAR_SETOR

    ; Pausa para exibi??o (4 segundos)
    call DELAY_SETOR

    
    call RESETAR
    
    ; Certifique-se de que est? no estado "Jogo"
    cmp menu, 2
    jne FIM_SETOR3

    
    
    call INICIA_HUD
    ; Configura o temporizador para gerar interrup??es
    MOV [timer_do_jogo], 10
    call SALVAR_TEMPO_ATUAL
    
    ; Atualiza o jogo
    call ATUALIZAR
    ; Renderiza os objetos do jogo
    call RENDERIZAR
        
SETOR3_LOOP:
    ; Captura entrada do usu?rio
    mov ah, 1H
    int 16H
    jz CONTINUAR3_LOOP         ; Volta ao loop se nenhuma tecla foi pressionada

    ; L? a tecla pressionada
    mov ah, 0
    int 16H
    call TRATAR_ENTRADA_NAVE

CONTINUAR3_LOOP:
    call LER_RTC              ; L? o RTC atual
    cmp dh, [last_rtc_timer]  ; Verifica se os segundos mudaram
    jne TEMPORIZAR3            ; Se mudou, atualiza o timer
    jmp SETOR3_LOOP           ; Volta ao loop principal

TEMPORIZAR3:
    call ATUALIZA_TEMPO       ; Atualiza o timer
    call SALVAR_TEMPO_ATUAL   ; Salva o novo valor do RTC
    cmp [timer_do_jogo], 0    ; Verifica se o timer chegou a zero
    jz FIM_SETOR3             ; Finaliza o setor se o timer zerar
    jmp SETOR3_LOOP           ; Continua no loop do setor


FIM_SETOR3:
    call VENCEDOR
    ret
ENDP

VENCEDOR proc
    call LIMPAR_TELA

    mov bp, offset vencedor
    mov cx, comprimento_vencedor
    mov bl, 0AH
    xor dl, dl
    mov dh, 7
    call IMPRIMIR_STRING

    mov bl, 0FH ; color = white

    mov bp, offset string_score
    mov dl, 12
    mov dh, 13
    call ESC_STRING

    mov bp, offset score
    mov dl, 20
    mov dh, 13
    call ESC_STRING

    xor ax, ax
    int 16h
    call INICIO

    ret
endp

GAME_OVER proc
    call LIMPAR_TELA

    mov bp, offset game_over
    mov cx, comprimento_game_over
    mov bl, 0AH
    xor dl, dl
    mov dh, 7
    call IMPRIMIR_STRING

    xor ax, ax
    int 16h
    call INICIO

    ret
endp


;===================================================================
;CONFIGURA??O DO MODO DE VIDEO, IMPRESS?O DO TITULO, BOTOES E NAVES DO MENU

INICIO:

mov AX, @data
    mov DS, AX
    mov AX, 0A000H
    mov ES, AX
    xor DI, DI

    ; Define o modo de v?deo
    xor ah, ah
    xor bh, bh
    mov al, 13h
    int 10h

    ; Exibe t?tulo e bot?es do menu
    call RESETAR
    call IMPRIMIR_TITULO_MENU
    call IMPRIMIR_BOTOES
    call RESETAR_POSICOES_NAVES_MENU

    
;LOOP DO MENU ATE SELECIONAR A OP??O PARA DAR INICIO AO JOGO OU SAIR    
LOOP_MENU:
    call NAVES_MENU
    
    ; Recebe entrada do usu?rio
    mov ah, 1H
    int 16H
    jz LOOP_MENU

    ; TRATAR AS SETAS P/ CIMA E P/ NA NAVEGA??O DO MENU
    call TRATAR_ENTRADA

    ;CONDI??O PARA INICIAR
    cmp ah, 1CH
    je SELECIONAR_OPCAO

    ; Retorno ao loop do menu
    xor ah, ah
    int 16H
    jmp LOOP_MENU

SELECIONAR_OPCAO:
    ; Limpa o registro AH (garantia de entrada limpa)
    xor ah, ah
    int 16H

    ; Verifica se a op??o "Sair" foi selecionada
    mov ah, menu
    cmp ah, 1
    je FINALIZAR

    ; Configura o jogo e entra no loop principal

    mov menu, 2      ; Atualiza o estado para "Jogo"
    jmp SETOR1 ;chamada do primeiro setor
    

;========================================================================

;FINALIZAR    

FINALIZAR:
    ; Retorna para o modo texto
    xor ah, ah
    mov al, 3h
    int 10h

    ; Encerra o programa
    mov ah, 4ch
    xor al, al
    int 21h
    ret


END INICIO

