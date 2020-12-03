    .text
    .global max
    .type fact, @function
max:
    movl    8(%ebp), %edx
    movl    $1, %eax
    cmpl    $1, %edx
    jle     L1

L0:
    imull   %edx, %eax
    subl    $1, %edx
    cmpl    $1, %edx
    jg  .L0

L1:         done:
x: 
    .zero 4
    .align 4


    .section    .rodata
STR0:
    .string "%d"
STR1:
    .string "%d\n"
STR2:
    .string "%d"


    .text
    .gloabal    main
    .type main, @function
main:
    pushl   $n
    pushl   $STR0
    call    scanf
    addl    $12, esp
    movel   n, %rbp+8
    pushl   %eax
    pushl   $STR1
    call    printf
    movl    x, %eax
    pushl   %eax
    pushl   $STR2
    call    printf
    addl    $8, %esp
    movl    $0, %eax
    ret

    .section    .note.GNU-stack,"",@progbits