import 'package:cryptotracker/components/card_component.dart' show CryptoCard;
import 'package:cryptotracker/coin_data.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCryptoAssetBTC = cryptoCurrencyList[0];
  String selectedCryptoAssetETH = cryptoCurrencyList[1];
  String selectedCryptoAssetLTC = cryptoCurrencyList[2];
  String selectedCurrency = 'USD';
  double selectedCurrencyPriceBTC = 0.0;
  double selectedCurrencyPriceETH = 0.0;
  double selectedCurrencyPriceLTC = 0.0;
  final valueFormat = NumberFormat("#,##0.00", "en_US");

  final String _appTiltle = '₿ CryptoTracker';

  @override
  void initState() {
    super.initState();
    getMarketData();
  }

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
          selectedCurrencyPriceBTC;
          selectedCurrencyPriceETH;
          selectedCurrencyPriceLTC;
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
      backgroundColor: Colors.grey.shade900,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getMarketData();
          selectedCurrencyPriceBTC;
          selectedCurrencyPriceETH;
          selectedCurrencyPriceLTC;
        });
      },
      children: pickerItems,
    );
  }

  //getMarketData() is to get the coin data from coin_data.dart
  void getMarketData() async {
    CoinData coinDataBTC = CoinData(selectedCryptoAssetBTC, selectedCurrency);
    CoinData coinDataETH = CoinData(selectedCryptoAssetETH, selectedCurrency);
    CoinData coinDataLTC = CoinData(selectedCryptoAssetLTC, selectedCurrency);

    selectedCurrencyPriceBTC = await coinDataBTC.getCoinMarketData();
    selectedCurrencyPriceETH = await coinDataETH.getCoinMarketData();
    selectedCurrencyPriceLTC = await coinDataLTC.getCoinMarketData();

    setState(() {
      selectedCurrencyPriceBTC;
      selectedCurrencyPriceETH;
      selectedCurrencyPriceLTC;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_appTiltle),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CryptoCard(
                    //BTC - Bitcoin
                    selectedCryptoAsset: selectedCryptoAssetBTC,
                    value: valueFormat,
                    selectedCurrencyPrice: selectedCurrencyPriceBTC,
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    //ETH - Etherium
                    selectedCryptoAsset: selectedCryptoAssetETH,
                    value: valueFormat,
                    selectedCurrencyPrice: selectedCurrencyPriceETH,
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    //LTC - LiteCoin
                    selectedCryptoAsset: selectedCryptoAssetLTC,
                    value: valueFormat,
                    selectedCurrencyPrice: selectedCurrencyPriceLTC,
                    selectedCurrency: selectedCurrency),
              ],
            ),
            Container(
              height: 100.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.black87,
              child:
                  // iOSPicker(),
                  Platform.isIOS
                      ? iOSPicker()
                      : androidDropdown(currenciesList),
            ),
          ],
        ),
      ),
    );
  }
}
