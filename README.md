# Food Supply Chain Management Smart Contract

The **FoodSupplyChain** smart contract is designed to track the authenticity and movement of farm products through their lifecycle, from harvest to consumer purchase. The contract uses blockchain technology to ensure transparency and traceability in the food supply chain.

## Key Functions

### `harvestProduct`

- **Description**: Registers a new product by assigning it a unique asset ID and records its initial details.
- **Parameters**:
  - `_productDescription`: Description of the product.
  - `_producerName`: Name of the producer.
  - `_producerAddress`: Address of the producer.
  - `_harvestDate`: Date when the product was harvested (timestamp).
- **Returns**: The unique `assetId` of the newly created product.

### `transferToDistributor`

- **Description**: Transfers the product from the producer to the distributor and updates the product’s details.
- **Parameters**:
  - `_assetId`: The ID of the asset to transfer.
  - `_distributerName`: Name of the distributor.
  - `_distributerAddress`: Address of the distributor.
  - `_prodToDistDate`: Date when the product was transferred to the distributor (timestamp).

### `transferToRetailer`

- **Description**: Transfers the product from the distributor to the retailer and updates the product’s details.
- **Parameters**:
  - `_assetId`: The ID of the asset to transfer.
  - `_retailerName`: Name of the retailer.
  - `_retailerAddress`: Address of the retailer.
  - `_distToRetaDate`: Date when the product was transferred to the retailer (timestamp).

### `sellToConsumer`

- **Description**: Marks the product as sold when purchased by a consumer.
- **Parameters**:
  - `_assetId`: The ID of the asset being purchased.

## Data Structures

### `FarmProduct`

- **Description**: Struct to store details of each farm product including asset ID, product description, producer and distributor details, and transfer dates.
- **Fields**:
  - `assetId`: Unique identifier for the product.
  - `productDescription`: Description of the product.
  - `producerName`: Name of the producer.
  - `producerAddress`: Address of the producer.
  - `harvestDate`: Date of harvest.
  - `distributerName`: Name of the distributor.
  - `distributerAddress`: Address of the distributor.
  - `prodToDistDate`: Date of transfer from producer to distributor.
  - `retailerName`: Name of the retailer.
  - `retailerAddress`: Address of the retailer.
  - `distToRetaDate`: Date of transfer from distributor to retailer.
  - `isSold`: Boolean indicating whether the product has been sold.

## Events

### `ProductHarvested`

- **Description**: Emitted when a new product is harvested and registered.
- **Parameters**:
  - `assetId`: Unique identifier of the product.
  - `productDescription`: Description of the product.
  - `producerName`: Name of the producer.
  - `producerAddress`: Address of the producer.
  - `harvestDate`: Date of harvest.

### `ProductTransferred`

- **Description**: Emitted when the product is transferred between stages (producer to distributor, distributor to retailer).
- **Parameters**:
  - `assetId`: Unique identifier of the product.
  - `fromStage`: Stage from which the product was transferred.
  - `toStage`: Stage to which the product was transferred.
  - `fromAddress`: Address from which the product was transferred.
  - `toAddress`: Address to which the product was transferred.
  - `transferDate`: Date of transfer.

### `ProductSold`

- **Description**: Emitted when the product is sold to a consumer.
- **Parameters**:
  - `assetId`: Unique identifier of the product.
  - `buyerAddress`: Address of the consumer.

## Overview

This contract ensures that every step in the food supply chain is recorded on the blockchain, providing a transparent and immutable record of the product's journey from farm to table.
