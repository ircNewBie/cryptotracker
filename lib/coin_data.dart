// import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'api_info.dart';
import 'package:http/http.dart' as http;

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const _apiKey = myAPI;
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

// String _assetIDBase = 'BTC';
// String _assetIDQoute = 'USD';

class CoinData {
  dynamic marketData;
  void getCoinMarketData(assetIDBase, assetIDQoute) async {
    var _apiURL = coinAPIURL + '/$assetIDBase/$assetIDQoute?apikey=$_apiKey';
    final response = await http.get(Uri.parse(_apiURL));

    if (response.statusCode == 200) {
      Map<String, dynamic> marketData = jsonDecode(response.body);
//       print(marketData);
      var _marketPrice = marketData['rate'].toDouble();
      var _assetIDBase = marketData['asset_id_base'];
      var _assetIDQoute = marketData['asset_id_quote'];

      print('$_assetIDBase/$_assetIDQoute Price  ' + _marketPrice.toString());
    } else {
      print(response.statusCode);
    }
  }
}
