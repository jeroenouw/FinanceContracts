pragma solidity 0.4.24;
pragma experimental "v0.5.0";
pragma experimental ABIEncoderV2;

/** @title Freelancer contract */
contract Freelancer {
    address public owner;
    uint256 private coins;
    uint256 private cash;
    bytes32 private service;

    event logFreelancerChanged(
        address indexed owner, 
        bytes32 firstname, 
        bytes32 lastname, 
        uint256 coins, 
        uint256 cash, 
        bytes32 service
    );
    event logAssetsChanged(address indexed owner, uint256 coins, uint256 cash, bytes32 service);

    struct FreelancerData {
        bytes32 firstname;
        bytes32 lastname;
        uint256 coins;
        uint256 cash;
        bytes32 service;
    }

    mapping (address => FreelancerData) FreelancersData;

    /**
     * @dev Modifier which checks if sender is equal to owner.
     */
    modifier onlyFreelancer() {
        require(owner == msg.sender, "Sender not authorized.");
        _;
    }

    /**
     * @dev Constructor which inits at contract creation.
     */
    constructor() public {
        owner = msg.sender;
        coins = 0;
        cash = 0;
        service = "";
    }

    /**
     * @dev Sets all data for freelancer
     * @param _firstname The first name of the freelancer
     * @param _lastname The last name of the freelancer
     * @param _coins Amount of coins available
     * @param _cash Amount of cash available
     * @param _service Service offered by the freelancer
     * @return FreelancerData struct of the owner
     */
    function setFreelancer(
        bytes32 _firstname,
        bytes32 _lastname,
        uint256 _coins,
        uint256 _cash,
        bytes32 _service) public onlyFreelancer returns (FreelancerData)
    {
        FreelancersData[owner].firstname = _firstname;
        FreelancersData[owner].lastname = _lastname;
        FreelancersData[owner].coins = _coins;
        FreelancersData[owner].cash = _cash;
        FreelancersData[owner].service = _service;
        emit logFreelancerChanged(owner, _firstname, _lastname, _coins, _cash, _service);
        return FreelancersData[owner];
    }

    /**
     * @dev Sets all assets for freelancer
     * @param _coins Amount of coins available
     * @param _cash Amount of cash available
     * @param _service Service offered by the freelancer
     * @return FreelancerData struct of the owner
     */
    function setAssets(uint256 _coins, uint256 _cash, bytes32 _service) 
        public 
        onlyFreelancer 
        returns (FreelancerData) {
        FreelancersData[owner].coins = _coins;
        FreelancersData[owner].cash = _cash;
        FreelancersData[owner].service = _service;
        emit logAssetsChanged(owner, _coins, _cash, _service);
        return FreelancersData[owner];
    }

    /**
     * @dev Gets the account data of the freelancer
     * @return FreelancerData struct of the owner
     */
    function myAccount() public onlyFreelancer view returns (FreelancerData) 
    {
        FreelancerData memory fdata = FreelancersData[owner];
        return fdata;
    }

}