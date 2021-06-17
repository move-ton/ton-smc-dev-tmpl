pragma ton-solidity ^0.45.0;
pragma AbiHeader time;

import "../library/Contracts.sol";


interface ILaunchpad {
    function fetchCode(uint index) external returns (uint, TvmCell);
    function uploadCode(uint index, TvmCell code) external;
    function deploy(uint index) external returns (address deployed);
}
