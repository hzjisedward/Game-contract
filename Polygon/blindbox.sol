{\rtf1\ansi\ansicpg936\cocoartf2580
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 pragma solidity ^0.5.0;\
\
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/token/ERC721/ERC721Full.sol";\
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/token/ERC20/ERC20.sol";\
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/math/SafeMath.sol";\
\
contract BlindBox is ERC721Full \{\
    using SafeMath for uint256;\
    \
    uint256 issuranceCount;\
    // one issurance => multiple boxes\
    struct Issurance \{\
        uint256 id;\
        address issuer;\
        address tokenAddress; // ERC20 token address\
        uint256 totalValue; // total value to be distributed to boxes\
        uint256 totalNumber; // number of boxes\
        uint256 unopenedCount;\
        uint256 unopenedValue;\
    \}\
    mapping(uint256 => Issurance) issurances;\
    \
    struct Box \{\
        uint256 id;\
        uint256 issuranceId;\
        bool opened;\
    \}\
    mapping(uint256 => Box) boxes;\
\
    uint256 burnedCounter = 0;\
\
    constructor(string memory _name, string memory _symbol) ERC721Full(_name, _symbol) public \{\
        issuranceCount = 0;\
    \}\
    \
    function mintErc20Boxes(address tokenAddress, uint256 value, uint256 number) public \{\
        ERC20 token = ERC20(tokenAddress);\
        require(token.transferFrom(msg.sender, address(this), value), "Insufficient funds");\
        uint256 issuranceId = issuranceCount;\
        issuranceCount += 1;\
        issurances[issuranceId] = Issurance(issuranceId, msg.sender, tokenAddress, value, number, number, value);\
        for(uint i = 0; i < number; i++) \{\
            uint256 boxId = _getNextBoxId();\
            boxes[boxId] = Box(boxId, issuranceId, false);\
            _mint(msg.sender, boxId);\
        \}\
    \}\
    \
    function openErc20Box(uint256 boxId) public \{\
        require(ownerOf(boxId) == msg.sender, "Not box owner");\
        require(boxes[boxId].opened == false, "Box already opened");\
        Issurance memory iss = issurances[boxes[boxId].issuranceId];\
        if(iss.unopenedValue == 0) \{\
            _burn(msg.sender, boxId);\
            return;\
        \}\
        // get random value in (0, unopenedValue)\
        uint256 rand = _getRandom(boxId.add(iss.id));\
        uint256 value = rand % iss.unopenedValue;\
        // only 1 box left, transfer all unopenedValue\
        if(iss.unopenedCount == 1) \{\
            value = iss.unopenedValue;\
        \}\
        ERC20 token = ERC20(iss.tokenAddress);\
        require(token.transfer(msg.sender, value), "Token transfer failed");\
        _burn(msg.sender, boxId);\
        issurances[iss.id].unopenedCount -= 1;\
        issurances[iss.id].unopenedValue -= value;\
    \}\
    \
    // TODO: replace this with chainlink VRF\
    function _getRandom(uint256 seed) private view returns (uint256) \{\
        return seed;\
    \}\
\
    function _getNextBoxId() private view returns (uint256) \{\
        return totalSupply().add(1).add(burnedCounter);\
    \}\
\
    function _burn(address _owner, uint256 _tokenId) internal \{\
        super._burn(_owner, _tokenId);\
        burnedCounter++;\
    \}\
\
    function tokensOfOwner(address _owner) external view returns(uint256[] memory ownerTokens) \{\
        uint256 tokenCount = balanceOf(_owner);\
\
        if (tokenCount == 0) \{\
            return new uint256[](0);\
        \} else \{\
            uint256[] memory result = new uint256[](tokenCount);\
            uint256 resultIndex = 0;\
\
            uint256 _tokenIdx;\
\
            for (_tokenIdx = 0; _tokenIdx < tokenCount; _tokenIdx++) \{\
                result[resultIndex] = tokenOfOwnerByIndex(_owner, _tokenIdx);\
                resultIndex++;\
            \}\
\
            return result;\
        \}\
    \}\
\}\
}
