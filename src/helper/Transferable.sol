pragma ton-solidity >= 0.45.0;
pragma AbiHeader time;


abstract contract Transferable {
    function _transfer3(address addr, uint128 value) internal pure {
        addr.transfer(value, false, 3);
    }
}
