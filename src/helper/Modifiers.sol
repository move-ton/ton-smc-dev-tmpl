pragma ton-solidity >= 0.45.0;
pragma AbiHeader time;


abstract contract CommonModifiers {

    modifier accept {
        tvm.accept();
        _;
    }

    modifier offchain {
        require(msg.sender == address(0), 101);
        _;
    }

    modifier onchain {
        require(msg.value > 0, 102);
        _;
    }
    
    modifier signed(uint256 key) {
        require(msg.pubkey() == key, 103);
        _;
    }

    modifier from(address addr) {
        require(msg.sender == addr, 104);
        _;
    }

}
