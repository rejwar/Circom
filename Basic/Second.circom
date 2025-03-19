pragma circom 2.0.0;

// Template for a single hash function (e.g., Poseidon or SHA256)
template Hash() {
    signal input in[2];
    signal output out;

    // Example: Using a simple hash function (replace with Poseidon or another hash function)
    out <== in[0] + in[1]; // Replace this with an actual hash function
}

// Template for verifying a Merkle proof
template MerkleProof(levels) {
    signal input leaf;          // The leaf to prove
    signal input path_indices[levels]; // Binary path (0 = left, 1 = right)
    signal input siblings[levels];     // Sibling nodes along the path
    signal output root;         // Computed root of the Merkle tree

    // Hash component
    component hash = Hash();

    // Start with the leaf
    signal current[levels + 1];
    current[0] <== leaf;

    // Iterate through each level of the tree
    for (var i = 0; i < levels; i++) {
        // Select the left or right sibling based on path_indices
        signal left <== path_indices[i] == 0 ? current[i] : siblings[i];
        signal right <== path_indices[i] == 1 ? current[i] : siblings[i];

        // Hash the left and right nodes
        hash.in[0] <== left;
        hash.in[1] <== right;
        current[i + 1] <== hash.out;
    }

    // Output the computed root
    root <== current[levels];
}

// Main component
component main { public [leaf] } = MerkleProof(3); // 3 levels deep Merkle tree
