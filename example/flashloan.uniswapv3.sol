// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.0;

import "forge-std/Test.sol";

contract Flashloan is Test {

    interface IUniswapPairV3 {
        function token0() external view returns (address);
        function token1() external view returns (address);
        function swap(
            address recipient,
            bool zeroForOne,
            int256 amountSpecified,
            uint160 sqrtPriceLimitX96,
            bytes calldata data
        ) external returns (int256 amount0, int256 amount1);
        function flash(address recipient, uint256 amount0, uint256 amount1, bytes calldata data) external;
    }

    function pancakeV3FlashCallback(
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external {
        uint8 num;
        uint256 amount;
        BUSD.transfer(msg.sender, amount + fee1);
    }
}