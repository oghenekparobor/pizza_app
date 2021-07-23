import 'package:flutter/material.dart';

class Ingredient {
  const Ingredient(this.image, this.positions);
  final String image;
  final List<Offset> positions;

  bool compare(Ingredient ingredient) => ingredient.image == image;
}

final ingredient = const <Ingredient>[
  Ingredient('assets/images/chili.png', [
    Offset(0.2, 0.2),
    Offset(0.58, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.55),
  ]),
  Ingredient('assets/images/garlic.png', [
    Offset(0.2, 0.35),
    Offset(0.55, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.3, 0.5),
  ]),
  Ingredient('assets/images/olive.png', [
    Offset(0.25, 0.5),
    Offset(0.65, 0.5),
    Offset(0.5, 0.1),
    Offset(0.4, 0.2),
    Offset(0.2, 0.3),
  ]),
  Ingredient('assets/images/onion.png', [
    Offset(0.2, 0.52),
    Offset(0.55, 0.3),
    Offset(0.30, 0.25),
    Offset(0.40, 0.35),
    Offset(0.4, 0.55),
  ]),
  Ingredient('assets/images/pea.png', [
    Offset(0.2, 0.35),
    Offset(0.55, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.3, 0.5),
  ]),
  Ingredient('assets/images/pickle.png', [
    Offset(0.2, 0.55),
    Offset(0.65, 0.3),
    Offset(0.25, 0.25),
    Offset(0.45, 0.35),
    Offset(0.4, 0.55),
  ]),
  Ingredient('assets/images/potato.png', [
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.55),
  ]),
];
