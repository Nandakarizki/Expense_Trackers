import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsMock = [
  {
    "icon": const FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    "color": Colors.yellow[700],
    "name": "Makanan",
    "totalAmount": "- Rp 12.000,00",
    "date": "Hari ini",
  },
  {
    "icon": const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    "color": Colors.purple,
    "name": "Belanja",
    "totalAmount": "- Rp 75.000,00",
    "date": "Hari ini",
  },
  {
    "icon": const FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white),
    "color": Colors.green,
    "name": "Kesehatan",
    "totalAmount": "- Rp 50.000,00",
    "date": "Kemarin",
  },
  {
    "icon": const FaIcon(FontAwesomeIcons.plane, color: Colors.white),
    "color": Colors.blue,
    "name": "Travel",
    "totalAmount": "- Rp 350.000,00",
    "date": "Kemarin",
  },
];
