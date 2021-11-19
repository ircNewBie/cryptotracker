// import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'api_info.dart';
import 'package:http/http.dart' as http;

const List<String> cryptoCurrencyList = ['BTC', 'ETH', 'LTC'];
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const _apiKey = myAPI;
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  double marketPrice = 0.0;
  dynamic marketData;
  String assetIDBase;
  String assetIDQoute;

  // Class Constructor
  CoinData(this.assetIDBase, this.assetIDQoute);

  Future<double> getCoinMarketData() async {
    var _apiURL = coinAPIURL + '/$assetIDBase/$assetIDQoute?apikey=$_apiKey';
    final response = await http.get(Uri.parse(_apiURL));

    if (response.statusCode == 200) {
      Map<String, dynamic> marketData = jsonDecode(response.body);
      var _marketPrice = marketData['rate'].toDouble();
      // var _assetIDBase = marketData['asset_id_base'];
      // var _assetIDQoute = marketData['asset_id_quote'];

      marketPrice = _marketPrice;
      // print('$_assetIDBase/$_assetIDQoute:$marketPrice`');
      return _marketPrice;
    } else {
      // ignore: avoid_print
      print(response.statusCode);
      return 0.00;
    }
  }
}
