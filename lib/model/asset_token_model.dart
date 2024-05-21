class Assets {
  final String logo;
  final String name;
  final String symbol;
  final String contractAddress;
  final String priceApi;

  Assets({
    required this.logo,
    required this.name,
    required this.symbol,
    required this.contractAddress,
    required this.priceApi,
  });

  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets(
      logo: json['LOGO'],
      name: json['NAME'],
      symbol: json['SYMBOL'],
      contractAddress: json['CONTRACT_ADDRESS'],
      priceApi: json['PRICE_API'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LOGO': logo,
      'NAME': name,
      'SYMBOL': symbol,
      'CONTRACT_ADDRESS': contractAddress,
      'PRICE_API': priceApi,
    };
  }
}

class AssetsTokenModel {
  final Assets musd;
  final Assets pmind;
  final Assets usdt;

  AssetsTokenModel({
    required this.musd,
    required this.pmind,
    required this.usdt,
  });

  factory AssetsTokenModel.fromJson(Map<String, dynamic> json) {
    return AssetsTokenModel(
      musd: Assets.fromJson(json['MUSD']),
      pmind: Assets.fromJson(json['PMIND']),
      usdt: Assets.fromJson(json['USDT']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MUSD': musd.toJson(),
      'PMIND': pmind.toJson(),
      'USDT': usdt.toJson(),
    };
  }
}
