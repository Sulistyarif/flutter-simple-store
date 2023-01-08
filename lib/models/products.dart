class Products {
  int? id;
  String? name;
  String? description;
  String? category;
  String? seller;
  int? price;
  String? image;

  Products(
      {this.id,
      this.name,
      this.description,
      this.category,
      this.seller,
      this.price,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    seller = json['seller'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category'] = this.category;
    data['seller'] = this.seller;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
