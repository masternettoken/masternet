pragma solidity ^0.4.24;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "zeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";
import "./Ownable.sol";

contract MasterNet is StandardToken, BurnableToken, Ownable {
  string public constant name = "MasterNet";
  string public constant symbol = "MAS";
  uint8 public constant decimals = 8;  
  uint256 public constant INITIAL_SUPPLY = 200000000 * (10 ** uint256(decimals));

  constructor() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = totalSupply_;        
    emit Transfer(0x0, msg.sender, totalSupply_);
  }

  function batchTransfer(address[] _receivers, uint256[] _amounts) public returns(bool) {
    uint256 cnt = _receivers.length;
    require(cnt > 0 && cnt <= 20);
    require(cnt == _amounts.length);

    cnt = (uint8)(cnt);

    uint256 totalAmount = 0;
    for (uint8 i = 0; i < cnt; i++) {
      totalAmount = totalAmount.add(_amounts[i]);
    }

    require(totalAmount <= balances[msg.sender]);

    balances[msg.sender] = balances[msg.sender].sub(totalAmount);
    for (i = 0; i < cnt; i++) {
      balances[_receivers[i]] = balances[_receivers[i]].add(_amounts[i]);            
      emit Transfer(msg.sender, _receivers[i], _amounts[i]);
    }

    return true;
  }
  
}