.data
  buffer:       .space  324    # Buffer da entrada
  saida:         .space  324    # Buffer da saida
  arq_entrada:  .asciiz "texto.txt"
  arq_saida: .asciiz "texto1.txt"

.text
  main:
    # abertura do entrada.txt
    li   $v0, 13
    la   $a0, arq_entrada
    li   $a1, 0
    li   $a2, 0
    syscall

    move $s0, $v0

    # abertura do saida.txt
    li   $v0, 13
    la   $a0, arq_saida
    li   $a1, 1
    li   $a2, 0
    syscall

    move $s1, $v0

    # leitura do entrada.txt
    li   $v0, 14
    move $a0, $s0
    la   $a1, buffer
    li   $a2, 512
    syscall

    la   $t0, buffer
    la   $t1, saida

  loop:
    lb   $t2, 0($t0)
    beq  $t2, $zero, finaliza

    li   $t3, 'a'
    li   $t4, 'z'
    blt  $t2, $t3, maiuscula
    bgt  $t2, $t4, maiuscula

    subi $t2, $t2, 32

  maiuscula:
    sb   $t2, 0($t1)
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    j    loop

  finaliza:
    sb   $zero, 0($t1)

    # escreva no saida.txt
    li   $v0, 15
    move $a0, $s1
    la   $a1, saida
    li   $a2, 324
    syscall

    # fecha entrada.txt
    li   $v0, 16
    move $a0, $s0
    syscall

    # fecha saida.txt
    li   $v0, 16
    move $a0, $s1
    syscall

    # finaliza o programa
    li   $v0, 10
    syscall
