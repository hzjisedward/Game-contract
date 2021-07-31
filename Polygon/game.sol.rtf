{\rtf1\ansi\ansicpg936\cocoartf2580
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 //SPDX-Licesne-Identifier:GPL-3.0\
pragma solidity ^0.8.4;\
\
import "./nft/ERC721.sol";\
import "./ERC20token/IERC20.sol";\
\
// import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";\
import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/VRFConsumerBase.sol";\
\
interface NFT is IERC721 \{\
    function mint(address to) external;\
\}\
\
contract Game is VRFConsumerBase \{\
    address daiAddress = 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa;\
    address tokenAddress = 0xf294654CDFeb49BFb9df9adee4BD7e9Faa6308Ba;\
    address nftAddress = 0xda37F3E1428c706Fa6D7fE8341AFCFb665bf89D7;\
    \
    IERC20 dai = IERC20(daiAddress);\
    IERC20 token = IERC20(tokenAddress);\
    ERC721 nft = ERC721(nftAddress);\
    \
    bytes32 internal keyHash;\
    uint256 internal fee;\
    \
    uint256 public randomResult;\
    uint256 public AMOUNT;\
    \
    event RandomNumberGenerationDone(uint256 randomResult);\
    \
    constructor() \
        VRFConsumerBase(\
            0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9, // VRF Coordinator\
            0xa36085F69e2889c224210F603D836748e7dC0088  // LINK Token\
        ) public\
    \{\
        keyHash = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;\
        fee = 0.1 * 10 ** 18; // 0.1 LINK (Varies by network)\
        AMOUNT = 10;\
    \}\
    \
    \
    function exchange(uint256 amt) external \{\
        //exchange msg.sender token to this contract token\
        dai.transferFrom(msg.sender, address(this), amt);\
        token.transfer(msg.sender, amt);\
    \}\
    \
    // step 1: set amount\
    function setAmount(uint256 _AMOUNT) external \{\
        AMOUNT = _AMOUNT;\
    \}\
    \
    /** \
     * step 2: Requests randomness \
     */\
    function getRandomNumber() public returns (bytes32 requestId) \{\
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");\
        return requestRandomness(keyHash, fee);\
    \}\
    \
    function expand(uint256 randomValue, uint256 AMOUNT) public pure returns (uint256[] memory expandedValues) \{\
        expandedValues = new uint256[](AMOUNT);\
        for (uint256 i = 0; i < AMOUNT; i++) \{\
            expandedValues[i] = uint256(keccak256(abi.encode(randomValue, i)));\
        \}\
        return expandedValues;\
    \}\
\
\
    /**\
     * Step 3: wait for node to Callback function used by VRF Coordinator\
     */\
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override \{\
        randomResult = randomness;\
        emit RandomNumberGenerationDone(randomness);\
    \}\
    \
    function register(uint256 AMOUNT) external \{\
        uint256[] memory randomValues = expand(randomResult, AMOUNT);\
        \
        // transfer msg.sender to this contract token\
        token.transferFrom(msg.sender, address(this), AMOUNT);\
        \
        // mint 1 nft to msg.sender \
        nft.mint(msg.sender, randomValues[0] % AMOUNT);\
        \
        for (uint i = 1; i < AMOUNT; i++) \{\
            uint rand = randomValues[i] % AMOUNT;\
            nft.mint(msg.sender, rand);   \
        \}\
    \}\
\
\}\
\
}