// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title AuthenticationVerifier
 * @dev Manages the authentication of artworks by experts or authenticated bodies, enhancing the provenance tracking system.
 */
contract AuthenticationVerifier is AccessControl {
    // Define roles
    bytes32 public constant EXPERT_ROLE = keccak256("EXPERT_ROLE");

    // Struct to represent authentication requests
    struct AuthenticationRequest {
        uint256 artworkId;
        address requester;
        bool authenticated;
    }

    // Mapping of artwork IDs to their authentication requests
    mapping(uint256 => AuthenticationRequest) private _requests;

    // Events
    event AuthenticationRequested(uint256 indexed artworkId, address indexed requester);
    event ArtworkAuthenticated(uint256 indexed artworkId, address indexed expert);

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender); // Granting the deployer the default admin role
    }

    /**
     * @notice Allows an artwork owner to request authentication of their artwork.
     * @param artworkId The ID of the artwork for which authentication is requested.
     */
    function requestAuthentication(uint256 artworkId) public {
        // Ensure there's no existing request for the same artwork
        require(_requests[artworkId].artworkId == 0, "Authentication request already exists for this artwork");

        _requests[artworkId] = AuthenticationRequest({
            artworkId: artworkId,
            requester: msg.sender,
            authenticated: false
        });

        emit AuthenticationRequested(artworkId, msg.sender);
    }

    /**
     * @notice Allows a verified expert to authenticate an artwork.
     * @param artworkId The ID of the artwork to authenticate.
     */
    function authenticateArtwork(uint256 artworkId) public onlyRole(EXPERT_ROLE) {
        require(_requests[artworkId].artworkId != 0, "Authentication request does not exist");
        require(!_requests[artworkId].authenticated, "Artwork has already been authenticated");

        // Mark the artwork as authenticated
        _requests[artworkId].authenticated = true;

        emit ArtworkAuthenticated(artworkId, msg.sender);
    }

    /**
     * @notice Retrieves the authentication status of an artwork.
     * @param artworkId The ID of the artwork.
     * @return bool The authentication status.
     */
    function isArtworkAuthenticated(uint256 artworkId) public view returns (bool) {
        return _requests[artworkId].authenticated;
    }
}
