#include <stdio.h>
#include <stdlib.h>

long interate(long xx) {
    if (xx % 2 == 0) {
        return xx / 2;
    } else {
        return xx * 3 + 1;
    }
}


int main(int argc, char* argv[]) {
    long xx = atol(argv[1]);
    long ii = 0;

    while (xx > 1) {
        printf("%ld\n", xx);
        xx = interate(xx);
        ii++;
    }

    printf("Iterations: %ld\n", ii);
    return 0;
}
