pragma circom 2.0.0;

template AdditionCheck() {
    signal input a; // Input signal a
    signal input b; // Input signal b
    signal input c; // Input signal c (expected sum)
    signal output isValid; // Output signal to verify correctness

    // Constraint: a + b = c
    isValid <== (a + b === c);
}

component main = AdditionCheck();
