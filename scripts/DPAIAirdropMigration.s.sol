// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol"; // solhint-disable
import {console} from "forge-std/console.sol";

import {DPAIToken} from "contracts/DPAIToken.sol";

contract DeployContractMigration is Script{
    uint256 public immutable privateKey;
    address payable public  contractAddress;
    constructor() {
        privateKey = vm.envUint("PRIVATE_KEY");
        contractAddress = payable(vm.envAddress("DPAIAIRDROP_PROXY"));
    }
    function run() external {
        vm.startBroadcast(privateKey);
        DPAIToken c = DPAIToken(contractAddress);
        console.log(
            "Balance before",
            c.balanceOf(contractAddress)
        );
        c.transferTo(vm.envAddress("DPAIAIRDROP_PROXY"), 10000000000000000000000000);
                console.log(
            "Balance transfered",
            c.balanceOf(contractAddress)
        );
                console.log(
            "Balance airdrop",
            c.balanceOf(vm.envAddress("DPAIAIRDROP_PROXY"))
        );
       /*  c.mint(contractAddress, 100000000000000000000000000);
        console.log(
            "Balance minted",
            c.balanceOf(contractAddress)
        );
        c.transferTo(vm.envAddress("TEST"), 10000000000000000000);
        console.log(
            "Balance transfered",
            c.balanceOf(contractAddress)
        ); */
        vm.stopBroadcast();
    }
}
