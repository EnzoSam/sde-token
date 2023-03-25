pragma solidity ^0.8.0;

import "./sdeToken.sol";

contract MyExchange {
    address public tokenAddress;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;
    uint256 public constant feePercent = 1;
    
    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);
    event Buy(address indexed buyer, uint256 amount);
    event Sell(address indexed seller, uint256 amount);
    
    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }
    
    function deposit(uint256 _amount) public {
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), _amount), "No se pudo realizar el depósito");
        balances[msg.sender] += _amount;
        emit Deposit(msg.sender, _amount);
    }
    
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Saldo insuficiente");
        balances[msg.sender] -= _amount;
        require(IERC20(tokenAddress).transfer(msg.sender, _amount), "No se pudo realizar el retiro");
        emit Withdraw(msg.sender, _amount);
    }
    
    function buy(uint256 _amount) public {
        require(msg.value == )
        uint256 fee = (_amount * feePercent) / 100;
        uint256 cost = _amount + fee;
        require(balances[msg.sender] >= cost, "Saldo insuficiente");
        balances[msg.sender] -= cost;
        balances[address(this)] += fee;
        require(IERC20(tokenAddress).transfer(msg.sender, _amount), "No se pudo realizar la compra");
        emit Buy(msg.sender, _amount);
    }
    
    function sell(uint256 _amount) public {
        uint256 fee = (_amount * feePercent) / 100;
        uint256 payout = _amount - fee;
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), _amount), "No se pudo realizar la venta");
        balances[msg.sender] += payout;
        balances[address(this)] += fee;
        emit Sell(msg.sender, _amount);
    }
    
    function approve(address _spender, uint256 _amount) public returns (bool) {
        allowed[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
}
