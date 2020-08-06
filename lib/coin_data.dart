import 'package:bitcointickr/keys.dart';
import 'dart:convert';
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

const apiKey = coinApiKey;
const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {

  Future getCoinData(String selectedCurrency) async {

    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestUrl = '$coinApiURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestUrl);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }

}