import 'dart:convert';

List<Temperatures> temperaturesFromJson(String str) => List<Temperatures>.from(json.decode(str).map((x) => Temperatures.fromJson(x)));

String temperaturesToJson(List<Temperatures> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Temperatures {
  Token token;
  dynamic tokenId;
  dynamic tokenInstance;
  String value;

  Temperatures({
    required this.token,
    required this.tokenId,
    required this.tokenInstance,
    required this.value,
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
    token: Token.fromJson(json["token"]),
    tokenId: json["token_id"],
    tokenInstance: json["token_instance"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "token": token.toJson(),
    "token_id": tokenId,
    "token_instance": tokenInstance,
    "value": value,
  };
}

class Token {
  String address;
  dynamic circulatingMarketCap;
  String decimals;
  dynamic exchangeRate;
  String holders;
  dynamic iconUrl;
  String name;
  String symbol;
  String totalSupply;
  String type;

  Token({
    required this.address,
    required this.circulatingMarketCap,
    required this.decimals,
    required this.exchangeRate,
    required this.holders,
    required this.iconUrl,
    required this.name,
    required this.symbol,
    required this.totalSupply,
    required this.type,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    address: json["address"],
    circulatingMarketCap: json["circulating_market_cap"],
    decimals: json["decimals"],
    exchangeRate: json["exchange_rate"],
    holders: json["holders"],
    iconUrl: json["icon_url"],
    name: json["name"],
    symbol: json["symbol"],
    totalSupply: json["total_supply"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "circulating_market_cap": circulatingMarketCap,
    "decimals": decimals,
    "exchange_rate": exchangeRate,
    "holders": holders,
    "icon_url": iconUrl,
    "name": name,
    "symbol": symbol,
    "total_supply": totalSupply,
    "type": type,
  };
}
