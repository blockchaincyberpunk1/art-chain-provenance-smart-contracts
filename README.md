# Art Chain Provenance DApp Smart Contracts

This repository contains the smart contracts for the Art Chain Provenance DApp, which is designed to manage the registration, authentication, ownership, and provenance tracking of artworks on the ArtChain platform.

## Contracts Overview

### 1. ArtChainAccessControl.sol

- **Purpose**: Manages different roles and permissions within the ArtChain platform, such as artists, owners, verified experts, and administrators.
- **Inherits**: OpenZeppelin's AccessControl for robust role-based access control.
- **Roles**:
  - `ARTIST_ROLE`: Role for artists who can register artworks.
  - `OWNER_ROLE`: Role for owners of artworks.
  - `EXPERT_ROLE`: Role for verified experts who can authenticate artworks.
  - `ADMIN_ROLE`: Role for administrators with full control over roles and permissions.

### 2. ArtworkRegistry.sol

- **Purpose**: Manages the registration, verification, and tracking of artworks on the ArtChain platform.
- **Features**:
  - Artwork registration by artists or administrators.
  - Verification of artworks by verified experts.
  - Retrieval of artwork details and verification status.

### 3. AuthenticationVerifier.sol

- **Purpose**: Manages the authentication of artworks by experts or authenticated bodies, enhancing the provenance tracking system.
- **Features**:
  - Requesting authentication of artworks by owners.
  - Authentication of artworks by verified experts.
  - Retrieval of authentication status for artworks.

### 4. OwnershipManager.sol

- **Purpose**: Manages the ownership and ownership history of artworks. Allows for the transfer of artwork ownership and retrieval of ownership history.
- **Features**:
  - Transfer of artwork ownership between users.
  - Retrieval of ownership history for artworks.

### 5. ProvenanceTracker.sol

- **Purpose**: Tracks and manages the provenance (history of ownership and authentication) of each artwork.
- **Features**:
  - Addition of provenance records to an artwork's history.
  - Retrieval of provenance records for artworks.

## Usage

Please refer to the individual contract files for detailed documentation and usage instructions.
