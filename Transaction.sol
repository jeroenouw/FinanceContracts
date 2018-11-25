pragma solidity 0.4.24;
pragma experimental "v0.5.0";
pragma experimental ABIEncoderV2;

contract Transactions {
    address owner;
    uint256 timestamp;

    event logTransaction(
        address indexed owner,
        uint256 indexed timestamp,
        bytes32 indexed participantType,
        bytes32 participantFName,
        bytes32 participantLName,
        uint256 coins,
        uint256 cash,
        bytes32 service
    );

    struct TransactionData {
        address owner;
        bytes32 participantType;
        bytes32 participantFName;
        bytes32 participantLName;
        uint256 coins;
        uint256 cash;
        bytes32 service; 
        uint256 timestamp;
    }

    mapping(address => TransactionData) TransactionsData;

    modifier validTransaction() {
        // TODO
        _;
    }

    constructor() public {
        timestamp = now;
        owner = msg.sender;
    }

    /** 
     * @dev Gives more detailed information about transaction
     * @param _participantType Type of participant, e.g. freelancer, bank
     * @param _participantFName First name of participant
     * @param _participantLName Last name of participant
     * @param _coins Amount of coins involved in transaction
     * @param _cash Amount of cash involved in transaction
     * @param _service Provided service in transaction
     * @return TransactionData struct
     */
    function Transaction(
        bytes32 _participantType, 
        bytes32 _participantFName, 
        bytes32 _participantLName,
        uint256 _coins,
        uint256 _cash,
        bytes32 _service) external validTransaction returns (TransactionData) 
    {
        TransactionsData[owner].participantType = _participantType;
        TransactionsData[owner].participantFName = _participantFName;
        TransactionsData[owner].participantLName = _participantLName;
        TransactionsData[owner].coins = _coins;
        TransactionsData[owner].cash = _cash;
        TransactionsData[owner].service = _service;
        emit logTransaction(
            owner, 
            timestamp,
            _participantType, 
            _participantFName, 
            _participantLName, 
            _coins, 
            _cash, 
            _service
        );
        return TransactionsData[owner];
    }

    function TransactionInfo() public validTransaction view returns (TransactionData) {
        return TransactionsData[owner];
    }

}
