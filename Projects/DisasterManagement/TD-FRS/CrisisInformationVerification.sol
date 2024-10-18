// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrisisInformationVerification {

    struct Information {
              string description; // Information about the disaster situation
              address submitter; // Person who submitted the information
              uint256 verificationCount; // Number of approvers
              bool verified; // Whether the information was verified
              mapping(address => bool) verifiers; // List of addresses that voted
    }

    mapping(uint256 => Information) public informationList;
    uint256 public infoCount = 0;
    uint256 public verificationThreshold = 3; // Kaç doğrulayıcı onayı gerektiği
    
    event InformationSubmitted(uint256 infoId, address submitter, string description);
    event InformationVerified(uint256 infoId, address verifier);
    
    function submitInformation(string memory _description) public {
        infoCount++;
        Information storage newInfo = informationList[infoCount];
        newInfo.description = _description;
        newInfo.submitter = msg.sender;
        newInfo.verificationCount = 0;
        newInfo.verified = false;
        
        emit InformationSubmitted(infoCount, msg.sender, _description);
    }
    
    function verifyInformation(uint256 _infoId) public {
        require(_infoId > 0 && _infoId <= infoCount, "Invalid information ID");
        Information storage info = informationList[_infoId];
        require(!info.verified, "Information already verified");
        require(!info.verifiers[msg.sender], "You have already verified this information");

        info.verificationCount++;
        info.verifiers[msg.sender] = true;
        
        emit InformationVerified(_infoId, msg.sender);
        
        if (info.verificationCount >= verificationThreshold) {
            info.verified = true;
        }
    }
    
    function isVerified(uint256 _infoId) public view returns (bool) {
        require(_infoId > 0 && _infoId <= infoCount, "Invalid information ID");
        return informationList[_infoId].verified;
    }
}
