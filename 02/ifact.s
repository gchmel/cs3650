    .global main

    .data
scamfmt:
    .string "%ld"
printfmt:
    .string "fact(%ld) = %ld\n"

    .text

    /* Pseudocode:
    long x
    scanf("%ld", &x);
    long y = 1
    for (int ii = x; ii > 0; ii--) {
        y = y * ii;
    }
    printf(printfmt, x, y);
    */

    /*
    Values:
     - x  -> on the stack: 0(%rsp)
     - y  -> %rax
     - ii -> %rcx
    */
main:
    // first argument is the size of the stack we want to allocate
    // however, we can't allocate 8, we need to be divisible by 16
    enter $16, $0


    mov $scamfmt, %rdi
    // mov %rsp, %rsi // this does the right thing, but only for the first variable
    // mov 0(%rsp), %rsi // this moves the value, not the adress
    lea 0(%rsp), %rsi
    mov $0, %al
    call scanf

    mov $1, %rax
    mov 0(%rsp), %rcx
loop_cond:
    cmp $0, %rcx
    jle loop_done

    imul %rcx

    dec %rcx
    jmp loop_cond
loop_done:

    mov $printfmt, %rdi
    mov 0(%rsp), %rsi
    mov %rax, %rdx
    mov $0, %al
    call printf

    mov $0, %rax
    leave
    ret
