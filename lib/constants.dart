import 'package:flutter/material.dart';

enum parts { performance, sales, categories }
enum units { weight, each, liters }
Color kBorderGreen = const Color(0xFF004C40);
Color kFillGreen = const Color(0xFF48A999);
Color kSelectedGreen = const Color(0xFFB2DFDB);
Color kTextGreen = const Color(0xFF00796B);
Color kBorderRed = const Color(0xFFB33425);
Color kFillRed = const Color(0xFFF98C80);
Color kBorderBlue = const Color(0xFF00BCD4);
Color kFillBlue = const Color(0xFF76D0DB);

String pathAPP;

class Currency {
  String continent;
  String nameCountry;
  String nameCurrency;
  String abbreviationCurrency;
  List<int> coins;
  List<int> bills;

  Currency(this.abbreviationCurrency, this.coins, this.bills, this.continent,
      this.nameCountry, this.nameCurrency);
}

Currency getEurope() {
  return Currency('EUR', [1, 2, 5, 10, 20, 50, 100, 200],
      [5, 10, 20, 50, 100, 200], 'Europe', 'Europe', 'Euro');
}

Currency getKenya() {
  return Currency('SHS', [1, 5, 10, 20, 40], [50, 100, 200, 500, 1000, 2000],
      'Africa', 'Kenya', 'Shilling');
}
