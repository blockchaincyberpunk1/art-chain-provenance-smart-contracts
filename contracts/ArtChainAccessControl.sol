// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Importing OpenZeppelin's AccessControl contract
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title ArtChain Access Control
 * @dev Manages different roles and permissions within the ArtChain platform, 
 * such as artists, owners, verified experts, and administrators.
 * Inherits from OpenZeppelin's AccessControl for robust role-based access control.
 */
contract ArtChainAccessControl is AccessControl {
    // Defining roles with unique identifiers
    bytes32 public constant ARTIST_ROLE = keccak256("ARTIST_ROLE");
    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");
    bytes32 public constant EXPERT_ROLE = keccak256("EXPERT_ROLE");
    bytes32 public constant ADMIN_ROLE = DEFAULT_ADMIN_ROLE; // DEFAULT_ADMIN_ROLE is provided by AccessControl

    /**
     * @dev Constructor that sets up the default roles and their relationships.
     */
    constructor() {
        // Granting the deployer the default admin role
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

        // Setting up role hierarchies (Admins can manage all roles)
        _setRoleAdmin(ARTIST_ROLE, ADMIN_ROLE);
        _setRoleAdmin(OWNER_ROLE, ADMIN_ROLE);
        _setRoleAdmin(EXPERT_ROLE, ADMIN_ROLE);
    }

    /**
     * @dev Grants a specific role to an account.
     * Access restricted to admins.
     * @param role The role to grant.
     * @param account The account to grant the role to.
     */
    function grantRole(bytes32 role, address account) public override onlyRole(getRoleAdmin(role)) {
        super.grantRole(role, account);
    }

    /**
     * @dev Revokes a specific role from an account.
     * Access restricted to admins.
     * @param role The role to revoke.
     * @param account The account to revoke the role from.
     */
    function revokeRole(bytes32 role, address account) public override onlyRole(getRoleAdmin(role)) {
        super.revokeRole(role, account);
    }

    /**
     * @dev Checks if an account has a specific role.
     * Can be called by any user to verify roles.
     * @param role The role to check.
     * @param account The account to check the role for.
     * @return bool True if the account has the role, false otherwise.
     */
    function hasRole(bytes32 role, address account) public view override returns (bool) {
        return super.hasRole(role, account);
    }
}
