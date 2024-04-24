// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title OwnershipManager
 * @dev Manages the ownership and ownership history of artworks. Allows for the transfer of artwork ownership and retrieval of ownership history.
 */
contract OwnershipManager is AccessControl {
    struct OwnershipChange {
        uint256 artworkId;
        address previousOwner;
        address newOwner;
        uint256 timestamp;
    }

    // Mapping from artwork ID to ownership history
    mapping(uint256 => OwnershipChange[]) private _ownershipHistories;

    // Mapping from artwork ID to current owner
    mapping(uint256 => address) private _currentOwners;

    // Events
    event OwnershipTransferred(uint256 indexed artworkId, address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Transfers ownership of an artwork from one user to another.
     * @param artworkId The ID of the artwork being transferred.
     * @param newOwner The address of the new owner.
     */
    function transferOwnership(uint256 artworkId, address newOwner) public {
        require(newOwner != address(0), "OwnershipManager: new owner is the zero address");
        require(_currentOwners[artworkId] == msg.sender, "OwnershipManager: caller is not the current owner");

        address previousOwner = _currentOwners[artworkId];
        _currentOwners[artworkId] = newOwner;

        // Recording the ownership change
        _ownershipHistories[artworkId].push(OwnershipChange({
            artworkId: artworkId,
            previousOwner: previousOwner,
            newOwner: newOwner,
            timestamp: block.timestamp
        }));

        emit OwnershipTransferred(artworkId, previousOwner, newOwner);
    }

    /**
     * @dev Retrieves the entire ownership history of an artwork.
     * @param artworkId The ID of the artwork.
     * @return OwnershipChange[] The ownership history of the specified artwork.
     */
    function getOwnershipHistory(uint256 artworkId) public view returns (OwnershipChange[] memory) {
        return _ownershipHistories[artworkId];
    }

    /**
     * @dev Gets the current owner of an artwork.
     * @param artworkId The ID of the artwork.
     * @return address The current owner of the specified artwork.
     */
    function getCurrentOwner(uint256 artworkId) public view returns (address) {
        return _currentOwners[artworkId];
    }
}
