import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.selectedCryptoAsset,
    required this.selectedCurrencyPrice,
    required this.selectedCurrency,
    required this.value,
  }) : super(key: key);

  final String selectedCryptoAsset;
  final String selectedCurrency;
  final double selectedCurrencyPrice;
  final NumberFormat value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade700,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.album, size: 50),
            title: Text(selectedCryptoAsset),
            subtitle: Text(
              '${value.format(selectedCurrencyPrice)}   $selectedCurrency',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
