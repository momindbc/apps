class Car {
  final String id;
  final String brand;
  final String model;
  final String image;
  final String price;
  final String milage;
  final String description;

  Car(
      {required this.id,
      required this.brand,
      required this.model,
      required this.image,
      required this.price,
      required this.milage,
      required this.description});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      brand: json['brand'] as String,
      model: json['model'] as String,
      image: json['image'] as String,
      price: json['price'] as String,
      milage: json['milage'] as String,
      description: json['description'] as String,
    );
  }
}