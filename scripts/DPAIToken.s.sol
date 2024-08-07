// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {DeployScript} from "contracts/DeployScript.sol";
import {DPAIToken} from "contracts/DPAIToken.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol"; 

contract DeployContractManager is DeployScript {
    bytes32 private _salt = keccak256("DePin AI Token");
    constructor()
        DeployScript(
            vm.envUint("PRIVATE_KEY"),
            _salt,
            vm.envOr("DPAITOKEN_PROXY", address(0))
        )
    {}
    function _run() internal override createOrUpgrade {
        DPAIToken c = new DPAIToken{salt: _salt}();
        implementation = address(c);
        initialize = abi.encodeCall(
            c.initialize,
            (
                vm.envAddress("WALLET"),
                vm.envAddress("FEED"),
                vm.envUint("PRICE"),
                payable(vm.envAddress("PAYWALLET"))
            )
        );
        data = bytes.concat(
            c.initialize.selector,
            abi.encode(
                vm.envAddress("WALLET"),
                vm.envAddress("FEED"),
                vm.envUint("PRICE"),
                payable(vm.envAddress("PAYWALLET"))
            )
        );
        
    }
}
