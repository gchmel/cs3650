    .global main

    .data
fmt:
    .string "avg(7, 3) = %d\n"

    .text

    // Argument registers
    // - %rdi, %rsi, %rdx, %rcx, %r8, %r9
    //
    // Return registers
    //  - %rax, (%rdx)


// avg(x, y) = (x + y) / 2
avg:
    enter $0, $0
    // x = rdi
    // y = rsi

    add %rdi, %rsi
    mov %rsi, %rax

    mov $2, %r10

    // cqo clears the upper 64 bits of %rdx
    cqo
    // idiv divides %rax by the argument
    idiv %r10

    leave
    ret


main:
    enter $0, $0

    mov $7, %rdi
    mov $3, %rsi
    call avg

    mov $fmt, %rdi
    mov %rax, %rsi
    mov $0, %al
    call printf

    leave
    ret
