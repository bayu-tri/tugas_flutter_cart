import 'package:hive/hive.dart';
part 'products.g.dart';

@HiveType(typeId: 0)
class Products extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final int total;

  Products({
    required this.title,
    required this.price,
    required this.total,
  });
}
