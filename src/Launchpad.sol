pragma ton-solidity >= 0.45.0;
pragma AbiHeader time;

import "./interface/ILaunchpad.sol";
import "./library/Contracts.sol";
import "./helper/Modifiers.sol";
import "./helper/Versionable.sol";
import "./helper/Transferable.sol";


abstract contract Batteries is Versionable, Transferable, CommonModifiers {}

contract Launchpad is ILaunchpad, Batteries {
    mapping (uint => TvmCell) public repo;

    constructor() public offchain signed(tvm.pubkey()) accept {}

    function fetchCode(uint index) external override onchain returns (uint, TvmCell) {
        return {value: 0, flag: 64} (index, repo.at(index));
    }

    function uploadCode(uint index, TvmCell image) external override offchain signed(tvm.pubkey()) accept {
        repo[index] = image;
    }

    function deploy(uint index) external override offchain signed(tvm.pubkey()) accept returns (address deployed) {
        TvmCell deployable = tvm.buildStateInit({
            code: repo[index].cell,
            pubkey: tvm.pubkey()
        });
        deployed = tvm.deploy(deployable, tvm.encodeBody(Contract), 1 ton, 0);
    }

    function upgrade() external override offchain signed(tvm.pubkey()) accept {
        TvmCell newCode = repo.at(0);
        upgradeWith(newCode);
    }

    function transfer(address to, uint128 value) external view offchain signed(tvm.pubkey()) accept {
        _transfer3(to, value);
    }

    

}
