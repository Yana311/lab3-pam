class WinesByModel {
  final String tag;
  final String name;

  WinesByModel({required this.tag, required this.name});

  factory WinesByModel.fromJson(Map<String, dynamic> json) {
    return WinesByModel(
      tag: json['tag'],
      name: json['name'],
    );
  }
}
