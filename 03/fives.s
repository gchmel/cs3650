/*
    - take a string as argv[1]
    - determine if all characters are '5'
    - print "all fives" if so
    - print "not all fives" if not

Examples:
    ./fives 5555 => all fives
    ./fives goat => not all fives
    ./fives 5a55 => not all fives

Pseudocode:
int main(int argc, char* argv[]) {
    if (all_match(argv[1], '5')) {
        puts(all_fives);
    } else {
        puts(not_all_fives);
    }
    return 0;
}

Variable mapping:
    - argc:
    - argv:
*/
    .global main
    .text

main:
    enter $0, $0

    mov 8(%rsi), %rdi
    // some ASM LSPs don't support this, but it works and is valid AMD64 ASM
    mov $'5, %sil
    call all_match
    cmp $0, %rax
    jne main_if
    jmp main_else
main_if:
    mov $all_fives, %rdi
    jmp main_done

main_else:
    mov $not_all_fives, %rdi
    jmp main_done

main_done:
    call puts
    mov $0, %rax
    leave
    ret

/*
Pseudocode:
int all_match(char* str[], char cc) {
    char xx = *str;
    while (xx) {
        if (xx != cc) {
            return 0;
        }
        str++;
    }
    return 1;
}
Variable mapping:
    - str - %rdi
    - cc - %sil
    - *str - %r10b
*/

all_match:
    enter $0, $0

all_match_loop_cond:
    mov (%rdi), %r10b
    cmp $0, %r10b
    je all_match_loop_done

    cmp %r10b, %sil
    je all_match_loop_next

    mov $0, %rax
    jmp all_match_done

all_match_loop_next:
    inc %rdi
    jmp all_match_loop_cond
all_match_loop_done:
    mov $1, %rax

all_match_done:
    leave
    ret


    .data
all_fives: .string "all fives"
not_all_fives: .string "not all fives"
