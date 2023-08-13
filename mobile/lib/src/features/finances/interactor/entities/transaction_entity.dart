class TransactionEntity {
  String? id;
  DateTime? date;
  String? type;
  String? description;
  String? category;
  double? value;

  TransactionEntity({
    this.id,
    this.date,
    this.type,
    this.description,
    this.category,
    this.value,
  });

  TransactionEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    type = json['type'];
    category = json['category'];
    description = json['description'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date == null ? null : (date?.toIso8601String());
    data['type'] = type;
    data['category'] = category;
    data['description'] = description;
    data['value'] = value;
    return data;
  }
}
