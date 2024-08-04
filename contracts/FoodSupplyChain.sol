// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FoodSupplyChain {
    
    struct FarmProduct {
        uint256 assetId;
        string productDescription;
        string producerName;
        address producerAddress;
        uint256 harvestDate; //use Unix Epoch date timestamp
        string distributerName;
        address distributerAddress;
        uint256 prodToDistDate;
        string retailerName;
        address retailerAddress;
        uint256 distToRetaDate;
        bool isSold;
    }
    
    mapping(uint256 => FarmProduct) public products;
    uint256 public assetId; //to return the generated asset id 

    event ProductHarvested(uint256 assetId, string productDescription, string producerName, address producerAddress, uint256 harvestDate);
    event ProductTransferred(uint256 assetId, string fromStage, string toStage, address fromAddress, address toAddress, uint256 transferDate);
    event ProductSold(uint256 assetId, address buyerAddress);

    // Function to harvest a new product
    function harvestProduct(string memory _productDescription, string memory _producerName, 
        address _producerAddress, uint256 _harvestDate) public returns (uint256){
        assetId++;
        products[assetId] = FarmProduct(
            assetId,
            _productDescription,
            _producerName,
            _producerAddress,
            _harvestDate,
            "",
            address(0),
            0,
            "",
            address(0),
            0,
            false
        );
        
        emit ProductHarvested(assetId, _productDescription, _producerName, _producerAddress, _harvestDate);
        assetId = assetId;
        return assetId;
    }
    
    // Function to transfer product from producer to distributor
    function transferToDistributor(uint256 _assetId, string memory _distributerName, address _distributerAddress, uint256 _prodToDistDate) public {
        require(_assetId <= assetId && _assetId > 0, "Invalid asset ID");
        require(products[_assetId].distributerAddress == address(0), "Product already transferred to distributor");

        FarmProduct storage product = products[_assetId];

        product.distributerName = _distributerName;
        product.distributerAddress = _distributerAddress;
        product.prodToDistDate = _prodToDistDate;

        emit ProductTransferred(_assetId, "Producer", "Distributor", product.producerAddress, _distributerAddress, _prodToDistDate);
    }
    
    // Function to transfer product from distributor to retailer
    function transferToRetailer(uint256 _assetId, string memory _retailerName, address _retailerAddress, uint256 _distToRetaDate) public {
        require(_assetId <= assetId && _assetId > 0, "Invalid asset ID");
        require(products[_assetId].retailerAddress == address(0), "Product already transferred to retailer");

        FarmProduct storage product = products[_assetId];

        product.retailerName = _retailerName;
        product.retailerAddress = _retailerAddress;
        product.distToRetaDate = _distToRetaDate;

        emit ProductTransferred(_assetId, "Distributor", "Retailer", product.distributerAddress, _retailerAddress, _distToRetaDate);
    }
    
    // Function for consumer to purchase the product
    function sellToConsumer(uint256 _assetId) public {
        require(_assetId <= assetId && _assetId > 0, "Invalid asset ID");
        require(!products[_assetId].isSold, "Product already sold");

        products[_assetId].isSold = true;

        emit ProductSold(_assetId, msg.sender);
    }
}