# How to write an Assembly Program

## Design Recipe for Assembly Programs

- An assembly (or C) program is a collection of functions
- Figure out at least some functions we need

(Hint: you need a "main" function, start there.)

- Apply the recipe for each function below to write them.
- As you discover new functions, write those too.


## Design Recipe for Assembly Function

### Step 1: Signature

This is always a good place to start.

Figure out # on args, types, and return type.

### Step 2: Pseudocode

Thinking in assembly language is difficult.

Write pseudocode can mean just writing almost-working C.

### Step 3: Variable Mappings

Pseudocode has named variables, assembly doesn't.

For each variable (or temporary value) in the pseudocode, decide where it lives.

- Register? Which one.
- On the stack? Where.
- Global variable? What label.

You should explicitly write down this mapping as a comment in the assembly code.

Which registers:

- There are two pure temporary registers: %r10 and %r11
  - Temporaries go bad if you call a function.
- There are five available safe registers: %rbx, %r12-%r15
  - These are safe across function calls.
  - You need to preserve the value of your caller.
- The first six arguments are passed in registers: %rdi, %rsi, %rdx, %rcx, %r8, %r9
  - These are temporaries.
  - If a value is already in one of these, you might be able to leave it there.
  - Remember that %rdx sometimes gets clobbered by function calls.
- The return value of a function goes in %rax
  - This is a temporary.
  - Remember that %rax sometimes gets clobbered by function calls.

### Step 4: Function Skeleton

```asm
label:
    // Prologue:
    // push callee-save (safe) registers
    enter ??, $0
    // Stack allignemnt:
    //  - 8*(# of safe registers) + (bytes requsted in enter) / 16
    //    must be an integer

    /* TODO: function body */

    leave
    // Epilogue:
    // pop callee-save (safe) registers in reverse order from pushes
    ret
```

### Step 5: Write the Function Body

Translate your pseudocode into assembly.

Refer to your variable mappings.

Translate C to ASM is a mechanical process - literally, that's what compilers do.
