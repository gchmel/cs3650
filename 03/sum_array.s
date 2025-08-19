    .global main
    .text

/*
long sum_array(long* xs, long size) {
    long sum = 0;
    for (long ii = 0; ii < size; ii++) {
        sum += xs[ii];
    }
    return sum;
}

Variable mappings:
    - xs -> %rdi
    - size -> %rsi
    - sum -> %rax
    - ii -> %rcx
*/
sum_array:
    enter $0, $0

    mov $0, %rax
    mov $0, %rcx

sum_array_for_cond:
    cmp %rsi, %rcx
    jge sum_array_for_done

    // sum += xs[ii];
    add (%rdi, %rcx, 8), %rax

    inc %rcx
    jmp sum_array_for_cond
sum_array_for_done:
    leave
    ret

/*
int main(int argc, char* argv[]) {
    if (argc != 2) {
        puts("Usage: ./sum_array N");
        return 1;
    }

    long nn = atol(argv[1]);
    long* xs = malloc(nn * sizeof(long));

    for (long ii = 0; ii < nn; ii++) {
        int count = scanf("%ld", &xs[ii]);
        if (count != 1) { abort(); }
    }

    printf("sum = %ld\n", sum_array(xs, nn));

    free(xs);
    return 0;
}
Variable mappings:
    - argc - %rdi
    - argv - %rsi
    - nn - %r12
    - xs - %r13
    - ii - %r14
    - count - %rax
*/
main:
    push %r12
    push %r13
    push %r14
    enter $8, $0

    cmp $2, %rdi
    je main_skip_usage

    mov $usage_msg, %rdi
    call puts
    mov $1, %rax
    jmp main_done

main_skip_usage:
    mov 8(%rsi), %rdi
    call atol
    mov %rax, %r12

    mov $8, %r10
    imul %r10
    mov %rax, %rdi
    call malloc
    mov %rax, %r13

    mov $0, %r14
main_for_cond:
    cmp %r12, %r14
    jge main_for_done

    mov $long_scan, %rdi
    lea (%r13, %r14, 8), %rsi
    mov $0, %al
    call scanf

    cmp $1, %rax
    jne call_abort

    inc %r14
    jmp main_for_cond
call_abort:
    call abort
main_for_done:
    mov %r13, %rdi
    mov %r12, %rsi
    call sum_array

    mov $out_fmt, %rdi
    mov %rax, %rsi
    mov $0, %al
    call printf

    mov %r13, %rdi
    call free
    mov $0, %rax
main_done:
    leave
    pop %r14
    pop %r13
    pop %r12
    ret

    .data
usage_msg: .string "Usage: ./sum_array N"
long_scan: .string "%ld"
out_fmt: .string "sum = %ld\n"
