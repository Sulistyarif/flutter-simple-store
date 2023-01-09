class Products {
  int? id;
  String? name;
  String? description;
  int? categoryId;
  int? sellerId;
  int? price;
  String? image;

  Products(
      {this.id,
      this.name,
      this.description,
      this.categoryId,
      this.sellerId,
      this.price,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    categoryId = json['category_id'];
    sellerId = json['seller_id'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['seller_id'] = this.sellerId;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
