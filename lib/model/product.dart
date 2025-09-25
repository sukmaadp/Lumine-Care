import 'package:flutter/material.dart';

/// Base class Product
class Product {
  String _name;
  double _price;
  IconData _icon;
  String _category;
  String _description;
  double _rating;

  Product({
    required String name,
    required double price,
    required IconData icon,
    required String category,
    String description = "",
    double rating = 0.0,
  }) : _name = name,
       _price = price,
       _icon = icon,
       _category = category,
       _description = description,
       _rating = rating;

  /// Getter
  String get name => _name;
  double get price => _price;
  IconData get icon => _icon;
  String get category => _category;
  String get description => _description;
  double get rating => _rating;

  /// Setter
  set name(String value) {
    if (value.isNotEmpty) _name = value;
  }

  set price(double value) {
    if (value > 0) _price = value;
  }

  set icon(IconData value) {
    _icon = value;
  }

  set description(String value) {
    _description = value;
  }

  set rating(double value) {
    if (value >= 0 && value <= 5) {
      _rating = value;
    }
  }
}

/// Subclass SkincareProduct
class SkincareProduct extends Product {
  SkincareProduct({
    required String name,
    required double price,
    required IconData icon,
    String description = "",
    double rating = 0.0,
  }) : super(
         name: name,
         price: price,
         icon: icon,
         category: "Skincare",
         description: description,
         rating: rating,
       );
}

/// Subclass HaircareProduct
class HaircareProduct extends Product {
  HaircareProduct({
    required String name,
    required double price,
    required IconData icon,
    String description = "",
    double rating = 0.0,
  }) : super(
         name: name,
         price: price,
         icon: icon,
         category: "Haircare",
         description: description,
         rating: rating,
       );
}

/// Subclass BodycareProduct
class BodycareProduct extends Product {
  BodycareProduct({
    required String name,
    required double price,
    required IconData icon,
    String description = "",
    double rating = 0.0,
  }) : super(
         name: name,
         price: price,
         icon: icon,
         category: "Bodycare",
         description: description,
         rating: rating,
       );
}
