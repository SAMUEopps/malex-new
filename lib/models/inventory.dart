class InventoryItem {
  final String name;
  final String sku;
  final String category;
  final int stockLevel;
  final String unit;
  final String location;
  final int lowStockThreshold;

  InventoryItem(this.name, this.sku, this.category, this.stockLevel, this.unit,
      this.location, this.lowStockThreshold);
}