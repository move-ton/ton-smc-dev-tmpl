pragma ton-solidity >= 0.45.0;
pragma AbiHeader time;


interface IVersionable {
    function upgrade() external;
}


abstract contract Versionable is IVersionable {
    uint16 public version;

    function upgrade() external override virtual {}

    function upgradeWith(TvmCell newcode) inline internal  {
        _upgrade(newcode, _onCodeUpgrade);
    }

    function _upgrade(TvmCell newcode, function (uint16) onUpgrade) private {
        tvm.commit();
        tvm.setcode(newcode);
        tvm.setCurrentCode(newcode);
        onUpgrade(version + 1);
    }

    function _onCodeUpgrade(uint16 v) private {
        tvm.resetStorage();
        version = v;
    }

}
