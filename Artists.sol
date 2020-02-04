pragma solidity ^0.5.5;
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol';

contract Artist is ERC721 {
    // Collection of artworks by this Artist
    mapping(uint => ArtWork) artworks;
    address artist;

    constructor() public {
        artist = msg.sender;
    }

    function createArtwork(uint hashIPFS, string memory Name) public returns (ArtWork) {
        ArtWork artContract = new ArtWork(hashIPFS, Name);
        artworks[hashIPFS] = artContract;
        return artContract;
    }

    function checkArtwork(uint hashIPFS) public view returns(bool) {
        if(artworks[hashIPFS] == ArtWork(0x0)) {
            return false;
        }
        return true;
    }
}


contract ArtWork is ERC721 {
    // Detail of artwork
    address artist;
    string  name;
    uint  hashIPFS;
    address owner;

    constructor(uint ipfsHash, string memory artName) public {
        artist = msg.sender;
        name = artName;
        hashIPFS = ipfsHash;
        owner = artist;
    }

    function setOwner(address newOwner) public {
        if(owner == msg.sender) {
            owner = newOwner;
        }
    }
}