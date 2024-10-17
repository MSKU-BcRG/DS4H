// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ZKSnarkVerifier.sol";

contract CrisisZKProofSystem {

    ZKSnarkVerifier public verifierContract;

    struct Information {
        string description;
        address submitter;
        bool verified;
    }

    mapping(uint256 => Information) public informationList;
    uint256 public infoCount = 0;

    event InformationSubmitted(uint256 infoId, address submitter, string description);
    event InformationVerified(uint256 infoId);

    constructor(address _verifierAddress) {
        verifierContract = ZKSnarkVerifier(_verifierAddress);
    }

    function submitInformation(string memory _description) public {
        infoCount++;
        informationList[infoCount] = Information({
            description: _description,
            submitter: msg.sender,
            verified: false
        });

        emit InformationSubmitted(infoCount, msg.sender, _description);
    }

    function verifyInformation(
        uint256 _infoId,
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[1] memory input
    ) public {
        require(_infoId > 0 && _infoId <= infoCount, "Invalid information ID");

        // zk-SNARK doğrulamasını çağırıyoruz
        bool proofIsValid = verifierContract.verifyProof(a, b, c, input);
        require(proofIsValid, "ZK-SNARK proof is invalid");

        informationList[_infoId].verified = true;
        emit InformationVerified(_infoId);
    }

    function isVerified(uint256 _infoId) public view returns (bool) {
        require(_infoId > 0 && _infoId <= infoCount, "Invalid information ID");
        return informationList[_infoId].verified;
    }
}
