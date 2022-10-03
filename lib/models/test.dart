class Test {
  Test({
    required this.name,
    required this.price,
    required this.rate,
    required this.updateAt,
  });
  late final String name;
  late final String price;
  late final String rate;
  late final String updateAt;

  Test.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    rate = json['rate'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['rate'] = rate;
    data['update_at'] = updateAt;
    return data;
  }
}

main() {
  Test test = Test.fromJson(
      {"name": "BTC", "price": "123", "rate": "123", "update_at": "123"});
  print(test);
}
