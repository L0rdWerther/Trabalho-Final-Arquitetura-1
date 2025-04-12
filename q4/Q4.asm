.data
    pitch: .byte 69, 74, 76, 74, 70, 69, 74, 62, 74, 62, 74, 63, 75, 63, 75, 61, 73, 69, 68, 72, 68, 69, 62, 69
    instrument: .byte 6 # Piano eletrico 1
    volume: .byte 100
    duration: .byte 5, 128, 128, 128, 210, 128, 200, 210, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 210, 128, 128, 128, 128, 128, 128, 128
    delay: .byte 3, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0

.text
    main:
        la $t0, pitch
        la $t3, duration
        la $t4, delay
        li $t1, 23
        li $t2, 0
    loop:
        bge $t2, $t1, exit
        lb $a0, ($t0)
        li $v0, 33
        lb $a1, ($t3)
        lb $a2, instrument
        lb $a3, volume
        syscall
        lb $t5, ($t4)
        li $v0, 32
        move $a0, $t5
        syscall
        addi $t0, $t0, 1
        addi $t3, $t3, 1
        addi $t4, $t4, 1
        addi $t2, $t2, 1
        j loop
    exit:
        li $v0, 10
        syscall
