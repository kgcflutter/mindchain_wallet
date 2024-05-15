import 'dart:convert';

class AddTokenModel {
   String address;
   String symbol;
   bool enable;
   String balance;
   String image;
  AddTokenModel(this.address, this.symbol,this.enable,this.balance,this.image);
}



BalanceTokenModel tokenModelFromJson(String str) => BalanceTokenModel.fromJson(json.decode(str));


class BalanceTokenModel {
   int status;
   Data data;

   BalanceTokenModel({
      required this.status,
      required this.data,
   });

   factory BalanceTokenModel.fromJson(Map<String, dynamic> json) => BalanceTokenModel(
      status: json["status"],
      data: Data.fromJson(json["data"]),
   );

}

class Data {
   List<Market> market;

   Data({
      required this.market,
   });

   factory Data.fromJson(Map<String, dynamic> json) => Data(
      market: List<Market>.from(json["market"].map((x) => Market.fromJson(x))),
   );
}

class Market {
   String id;
   String ticker;
   String feeBuy;
   String feeSell;
   String name;
   String icon;
   String newPrice;
   String buyPrice;
   String sellPrice;
   String minPrice;
   String maxPrice;
   double change;
   double volume;

   Market({
      required this.id,
      required this.ticker,
      required this.feeBuy,
      required this.feeSell,
      required this.name,
      required this.icon,
      required this.newPrice,
      required this.buyPrice,
      required this.sellPrice,
      required this.minPrice,
      required this.maxPrice,
      required this.change,
      required this.volume,
   });

   factory Market.fromJson(Map<String, dynamic> json) => Market(
      id: json["id"],
      ticker: json["ticker"],
      feeBuy: json["fee_buy"],
      feeSell: json["fee_sell"],
      name: json["name"],
      icon: json["icon"],
      newPrice: json["new_price"],
      buyPrice: json["buy_price"],
      sellPrice: json["sell_price"],
      minPrice: json["min_price"],
      maxPrice: json["max_price"],
      change: json["change"]?.toDouble(),
      volume: json["volume"]?.toDouble(),
   );

}
