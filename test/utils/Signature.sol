// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract SignatureHelper {

    function sign65chars(uint256 pk, bytes32 data) public view returns (bytes memory signature) {
        bytes32 toEthSignedMessageHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", data));
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, toEthSignedMessageHash);
        signature = abi.encodePacked(v, r, s);
    }
}