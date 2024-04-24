// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title ProvenanceTracker
 * @dev Tracks and manages the provenance (history of ownership and authentication) of each artwork.
 */
contract ProvenanceTracker is AccessControl {
    // Struct to hold provenance records
    struct ProvenanceRecord {
        uint256 artworkId;
        string description;
        uint256 timestamp;
    }

    // Mapping from artwork ID to list of its provenance records
    mapping(uint256 => ProvenanceRecord[]) private _provenanceRecords;

    // Events
    event ProvenanceRecordAdded(uint256 indexed artworkId, string description, uint256 timestamp);

    /**
     * @notice Adds a new provenance record to an artwork's history.
     * @param artworkId The ID of the artwork.
     * @param description Description of the provenance record.
     */
    function addProvenanceRecord(uint256 artworkId, string memory description) public {
        // Requires that the function caller has a specific role; adjust as per your access control design.
        // For instance, requiring that the caller is an admin or the artist themselves.
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "ProvenanceTracker: Caller lacks permission to add provenance records");

        _provenanceRecords[artworkId].push(ProvenanceRecord({
            artworkId: artworkId,
            description: description,
            timestamp: block.timestamp
        }));

        emit ProvenanceRecordAdded(artworkId, description, block.timestamp);
    }

    /**
     * @notice Retrieves the provenance history of an artwork.
     * @param artworkId The ID of the artwork.
     * @return ProvenanceRecord[] An array of provenance records for the specified artwork.
     */
    function getProvenanceRecords(uint256 artworkId) public view returns (ProvenanceRecord[] memory) {
        return _provenanceRecords[artworkId];
    }
}
