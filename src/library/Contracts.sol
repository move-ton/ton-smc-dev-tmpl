pragma ton-solidity ^0.45.0;
pragma AbiHeader time;


contract Contract {
    constructor () public {}
}

library Contracts {
    struct Code {
        TvmCell cell;
        string name;
    }
}
