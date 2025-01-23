// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title MathLibrary
 * @dev A sample library that provides arithmetic functions.
 */
library MathLibrary {
    function safeAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            uint256 c = a + b;
            require(c >= a, "MathLibrary: addition overflow");
            return c;
        }
    }

    function safeSub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "MathLibrary: subtraction overflow");
        return a - b;
    }
}

/**
 * @title BaseContract
 * @dev Demonstrates inheritance by serving as a base for another contract.
 */
contract BaseContract {
    // State variable to demonstrate inheritance
    string public baseMessage;

    // Constructor in the base contract
    constructor(string memory _message) {
        baseMessage = _message;
    }

    // Virtual function to be overridden
    function getMessage() public view virtual returns (string memory) {
        return baseMessage;
    }
}

/**
 * @title MultiFeatureContract
 * @dev A contract showcasing multiple Solidity features for testing.
 */
contract MultiFeatureContract is BaseContract("Hello from BaseContract") {
    using MathLibrary for uint256;

    // Events
    event LogNewValue(uint256 indexed oldValue, uint256 indexed newValue, address changer);
    event ReceivedEther(address sender, uint256 amount);

    // Enums
    enum Status { Pending, Active, Inactive }

    // Structs
    struct UserInfo {
        uint256 id;
        string name;
        bool isActive;
    }

    // Mappings
    mapping(address => uint256) public balances;
    mapping(address => UserInfo) public userInfos;

    // Constants and immutable variables
    uint256 public constant MAX_SUPPLY = 10000;
    address public immutable owner;

    // State variables
    uint256 public totalSupply;
    Status public contractStatus;
    uint256[] public values;

    // Custom error
    error InvalidStatus(Status currentStatus, Status requiredStatus);

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    modifier inStatus(Status _status) {
        if (contractStatus != _status) {
            revert InvalidStatus(contractStatus, _status);
        }
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender; // set immutable variable
        totalSupply = 0; 
        contractStatus = Status.Pending;
    }

    /**
     * @dev Override a function from the base contract.
     */
    function getMessage() public view override returns (string memory) {
        return string(abi.encodePacked("Override: ", baseMessage));
    }

    /**
     * @dev Activate the contract, changing its status.
     */
    function activateContract() external onlyOwner inStatus(Status.Pending) {
        contractStatus = Status.Active;
    }

    /**
     * @dev Add a value to the values array.
     */
    function addValue(uint256 newValue) external inStatus(Status.Active) {
        uint256 oldValue = values.length > 0 ? values[values.length - 1] : 0;
        values.push(newValue);
        emit LogNewValue(oldValue, newValue, msg.sender);
    }

    /**
     * @dev Increase the totalSupply safely using MathLibrary.
     */
    function mint(uint256 amount) external onlyOwner inStatus(Status.Active) {
        totalSupply = totalSupply.safeAdd(amount);
        require(totalSupply <= MAX_SUPPLY, "Max supply exceeded");
    }

    /**
     * @dev Create or update UserInfo for the sender's address.
     */
    function setUserInfo(uint256 _id, string calldata _name, bool _isActive) external {
        userInfos[msg.sender] = UserInfo(_id, _name, _isActive);
    }

    /**
     * @dev Deposit Ether and track the balance.
     */
    function deposit() external payable {
        balances[msg.sender] = balances[msg.sender].safeAdd(msg.value);
    }

    /**
     * @dev Withdraw all Ether for the caller.
     */
    function withdrawAll() external {
        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");
    }

    /**
     * @dev Example of a fallback function to handle plain Ether transfers.
     */
    fallback() external payable {
        emit ReceivedEther(msg.sender, msg.value);
    }

    /**
     * @dev Example of a receive function for direct Ether.
     */
    receive() external payable {
        emit ReceivedEther(msg.sender, msg.value);
    }

    /**
     * @dev Deactivate the contract by setting the status.
     */
    function deactivateContract() external onlyOwner {
        contractStatus = Status.Inactive;
    }

    /**
     * @dev Helper function to retrieve current status as a string.
     */
    function getStatusString() external view returns (string memory) {
        if (contractStatus == Status.Pending) return "Pending";
        if (contractStatus == Status.Active) return "Active";
        if (contractStatus == Status.Inactive) return "Inactive";
        return "Unknown";
    }
}
