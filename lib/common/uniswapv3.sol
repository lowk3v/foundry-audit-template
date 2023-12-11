// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "forge-std/Test.sol";

import "";

contract CommonUniswapV3 {

    

    /// @notice Swap tokens for tokens. Remember Approve before.
    /// @param router The address of the router. Suggests: 0x13f4EA83D0bd40E75C8222255bc855a974568Dd4 for bsc
    /// @param fromToken The address of the token to swap from.
    /// @param toToken The address of the token to swap to.
    /// @param receiver The address to send the swapped tokens to.

    function swapExactInput(
        address routerAddr,
        address fromToken,
        address toToken,
        address recipient,
        uint amount,
        uint24 fee
    ) external returns (uint256) {
        ISwapRouterV3 Router = ISwapRouterV3(routerAddr);
        bytes memory path = abi.encodePacked(toToken, fee, fromToken);
        uint256 amountIn = amount;
        uint256 amountOutMinimum = 0;

        ISwapRouterV3.ExactInputParams memory ExactInputParams =
            ISwapRouterV3.ExactInputParams(path, recipient, amountIn, amountOutMinimum);
        Router.exactInput(ExactInputParams);
    }
    
}

interface ISwapRouterV3 {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }

    struct ExactOutputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountOut;
        uint256 amountInMaximum;
        uint160 sqrtPriceLimitX96;
    }

    struct ExactInputParams {
        bytes path;
        address recipient;
        uint256 amountIn;
        uint256 amountOutMinimum;
    }

    struct ExactOutputParams {
        bytes path;
        address recipient;
        uint256 amountOut;
        uint256 amountInMaximum;
    }

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to
    ) external payable returns (uint256 amountOut);

    function exactInputSingle(ExactInputSingleParams memory params) external payable returns (uint256 amountOut);

    function exactOutputSingle(ExactOutputSingleParams calldata params) external payable returns (uint256 amountIn);

    function exactInput(ExactInputParams memory params) external payable returns (uint256 amountOut);

    function exactOutput(ExactOutputParams calldata params) external payable returns (uint256 amountIn);
}