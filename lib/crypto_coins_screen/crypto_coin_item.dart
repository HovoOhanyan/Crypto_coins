import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_application_for_review/model/crypto_coin_model.dart';

class CryptoCoinItem extends StatelessWidget {
  const CryptoCoinItem({required this.item, super.key});

  final CryptoCoinModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: generateRandomColor(),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  item.symbol,
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    height: 24 / 17,
                    letterSpacing: -0.41,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),

          Text(
            '\$${parsePrice(item.priceUsd)}',
            style: TextStyle(
              fontFamily: 'SFProText',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
              height: 24 / 17,
              letterSpacing: -0.41,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  String parsePrice(String? price) {
    if (price == null || price.isEmpty) return '0.00';
    final parts = price.split('.');
    if (parts.length == 1) return '${parts[0]}.00';
    final decimal = parts[1].length >= 2
        ? parts[1].substring(0, 2)
        : parts[1].padRight(2, '0');
    return '${parts[0]}.$decimal';
  }

  Color generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      0.1,
    );
  }
}
