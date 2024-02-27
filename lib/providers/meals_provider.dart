import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/dummy_data/categories.dart';

final mealsProvider = Provider((ref) {
  return meals;
});
