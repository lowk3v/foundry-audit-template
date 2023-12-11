// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract CommonUniswapV2 {
    function swapExactInput(
        address routerAddr,
        address fromToken,
        address toToken,
        address recipient,
        uint amount
    ) internal {
        IUniswapRouterV2 router = IUniswapRouterV2(routerAddr);

        address[] memory path = new address[](2);
        path[0] = address(fromToken);
        path[1] = address(toToken);
        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amount,
            0,
            path,
            recipient,
            block.timestamp + 1000
        );
    }
}
    

interface IUniswapRouterV2 {
    function WETH() external view returns (address);
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external;
}