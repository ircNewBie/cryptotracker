import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final valueFormat = NumberFormat("#,##0.00", "en_US");
  final String _appTiltle = '₿ CryptoTracker';

  String selectedCurrency = 'USD';
  String selectedCryptoAssetBTC = 'BTC';
  double selectedCurrencyPrice = 0.0;

  DropdownButton<String> androidDropdown(List menuItemList) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in menuItemList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          getMarketData();
          selectedCurrencyPrice;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        // print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  //getMarketData() is to get the coin data from coin_data.dart
  void getMarketData() async {
    CoinData coinDataBTC = CoinData(selectedCryptoAssetBTC, selectedCurrency);
    double price = await coinDataBTC.getCoinMarketData();
    selectedCurrencyPrice = price;
    print('$selectedCryptoAssetBTC/$selectedCurrency:$selectedCurrencyPrice');
    print('$selectedCryptoAssetBTC/$selectedCurrency:$selectedCurrencyPrice');
    print('$selectedCryptoAssetBTC/$selectedCurrency:$selectedCurrencyPrice');
    setState(() {
      selectedCurrencyPrice;
    });
  }

  @override
  void initState() {
    super.initState();
    getMarketData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_appTiltle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(
              selectedCryptoAsset: selectedCryptoAsset,
              value: valueFormat,
              selectedCurrencyPrice: selectedCurrencyPrice,
              selectedCurrency: selectedCurrency),
          CryptoCard(
              selectedCryptoAsset: selectedCryptoAsset,
              value: valueFormat,
              selectedCurrencyPrice: selectedCurrencyPrice,
              selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.black87,
            child:
                Platform.isIOS ? iOSPicker() : androidDropdown(currenciesList),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.selectedCryptoAsset,
    required this.selectedCurrencyPrice,
    required this.selectedCurrency,
    required this.value,
  }) : super(key: key);

  final String selectedCryptoAsset;
  final NumberFormat value;
  final double selectedCurrencyPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.grey.shade900,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //Update the Text Widget with the live bitcoin data here.
            '1 $selectedCryptoAsset now is at: \n ${value.format(selectedCurrencyPrice)} \n $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
