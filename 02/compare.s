/*
./compare 3 5

main(int argc, char *argv[]) {
    // argv[0] -> "./compare"

    long aa = atol(argv[1]);
    long bb = atol(argv[2]);
    if (aa > bb) {
        print "{aa} > {bb}";
    }
    else {
        print "{aa} <= {bb}";
    }
}
*/

    .global main
    .text
main:
    // argv -> %r12
    // aa -> %r14
    // bb -> %r15
    push %r12
    push %r14
    push %r15
    enter $8, $0

    mov %rsi, %r12

    cmp $3, %rdi
    je main_cmp

    mov $usage, %rdi
    call puts
    mov $1, %rax
    jmp done

main_cmp:
    // argv[1]
    mov 8(%r12), %rdi
    call atol
    mov %rax, %r14

    // argv[2]
    mov 16(%r12), %rdi
    call atol
    mov %rax, %r15

    cmp %r15, %r14
    // if aa > bb
    jg big
    // else
    jmp sml

big:
    mov $gt, %rax
    jmp print

sml:
    mov $le, %rax
    jmp print

print:
    mov $msg, %rdi
    mov %r14, %rsi
    mov %rax, %rdx
    mov %r15, %rcx
    mov $0, %al
    call printf
    mov $0, %rax
done:
    leave
    pop %r15
    pop %r14
    pop %r12
    ret


    .data
msg: .string "%d %s %d\n"
usage: .string "Usage: ./compare <num1> <num2>"
gt: .string ">"
le: .string "<="
