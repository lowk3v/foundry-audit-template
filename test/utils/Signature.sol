// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract SignatureHelper is Test {

    function signEthMessage(uint pk, bytes32 data) public pure returns (bytes memory sig) {
        bytes32 digest = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", data));
        return signMessage(pk, digest);
    }

    function signMessage(uint256 pk, bytes32 data) public pure returns (bytes memory signature) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, data);
        signature = abi.encodePacked(r, s, v);
    }
}
