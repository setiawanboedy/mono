import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/repositories/models/category.dart';

class CategorySerializer
    with Encoder<Category, String>, Decoder<Category, String> {
  @override
  Category fromType(String data) {
    switch (data) {
      case 'shop':
        return Category.shop;
      case 'restaurant':
        return Category.restaurant;
      case 'portable':
        return Category.portable;
      case 'gasStation':
        return Category.gasStation;
      default:
        return Category.general;
    }
  }

  @override
  String toType(Category data) {
    return data.toString().split('.').last.toLowerCase();
  }
}
