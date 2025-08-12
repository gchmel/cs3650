    .global main

    .data
long_fmt: .string "%ld\n"

    .text

    // Argument registers:
    // - %rdi
    // - %rsi

    // Return registers:
    // - %rax

    // add2(x): return x + 2

add2:
    enter $0, $0

    // x = x + 2
    add $2, %rdi

    // return x
    mov %rdi, %rax

    leave
    ret

main:
    enter $0, $0

    mov $5, %rdi
    call add2

    // printf("%ld\n", add2(5))
    mov $long_fmt, %rdi
    mov %rax, %rsi
    mov $0, %al
    call printf

    mov $0, %rax
    leave
    ret
