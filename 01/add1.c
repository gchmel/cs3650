#include <stdio.h>

long add1(long x) {
    return x + 1;
}

int main(int argc, char *argv[]) {
    long x = add1(5);
    printf("x = %ld\n", x);
    return 0;
}
