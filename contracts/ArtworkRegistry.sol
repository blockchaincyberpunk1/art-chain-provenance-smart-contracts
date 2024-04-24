// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title ArtworkRegistry
 * @dev Manages the registration, verification, and tracking of artworks on the ArtChain platform.
 */
contract ArtworkRegistry is AccessControl {
    // Artwork data structure
    struct Artwork {
        uint256 id;
        string name;
        string description;
        address creator;
        bool verified;
    }

    // Role definitions
    bytes32 public constant VERIFIER_ROLE = keccak256("VERIFIER_ROLE");

    // Artwork storage
    Artwork[] private artworks;

    // Events
    event ArtworkRegistered(uint256 indexed id, address indexed creator);
    event ArtworkVerified(uint256 indexed id);

    /**
     * @dev Constructor to set up roles and permissions.
     */
    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender); // Granting default admin role to the deployer
        _setupRole(VERIFIER_ROLE, msg.sender); // Granting verifier role to the deployer, for testing
    }

    /**
     * @notice Registers a new artwork on the platform.
     * @dev Restricted to users with the artist role or admin role.
     * @param name The name of the artwork.
     * @param description A description of the artwork.
     */
    function registerArtwork(string memory name, string memory description) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender) || hasRole(VERIFIER_ROLE, msg.sender), "Caller does not have permission to register artwork");

        // Creating a new artwork object
        Artwork memory newArtwork = Artwork({
            id: artworks.length,
            name: name,
            description: description,
            creator: msg.sender,
            verified: false
        });

        // Adding the artwork to the array
        artworks.push(newArtwork);

        emit ArtworkRegistered(newArtwork.id, msg.sender);
    }

    /**
     * @notice Retrieves details about a specific artwork.
     * @param id The ID of the artwork to retrieve.
     * @return Artwork The artwork details.
     */
    function getArtworkDetails(uint256 id) public view returns (Artwork memory) {
        require(id < artworks.length, "Artwork ID does not exist");
        return artworks[id];
    }

    /**
     * @notice Marks an artwork as verified, indicating its authenticity has been confirmed.
     * @dev Restricted to users with the verifier role.
     * @param id The ID of the artwork to verify.
     */
    function verifyArtwork(uint256 id) public {
        require(hasRole(VERIFIER_ROLE, msg.sender), "Caller does not have permission to verify artwork");
        require(id < artworks.length, "Artwork ID does not exist");
        require(!artworks[id].verified, "Artwork is already verified");

        // Marking the artwork as verified
        artworks[id].verified = true;

        emit ArtworkVerified(id);
    }
}
