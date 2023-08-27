class Rows {
  final int count;

  final Data data;

  const Rows({
    required this.count,
    required this.data,
  });

  factory Rows.fromJson(Map<String, dynamic> json) {
    return Rows(
      count: json['count'],
      data: json['data'],
    );
  }
}

class Data {
  final String description;
  final String productname;
  final String id;
  final String created;
  final int price;

  const Data(
      {required this.description,
      required this.productname,
      required this.id,
      required this.created,
      required this.price});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      description: json['description'],
      productname: json['productname'],
      id: json['id'],
      created: json['created'],
      price: json['price'],
    );
  }
}
