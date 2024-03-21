import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  List<Item> items;
  dynamic nextPageParams;

  TransactionModel({
    required this.items,
    required this.nextPageParams,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    List<Item> items = [];
    if (json["items"] != null) {
      items = List<Item>.from(json["items"].map((x) => Item.fromJson(x)));
    }
    return TransactionModel(
      items: items,
      nextPageParams: json["next_page_params"],
    );
  }


  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "next_page_params": nextPageParams,
  };
}

class Item {
  DateTime timestamp;
  Fee fee;
  String gasLimit;
  int block;
  Status status;
  dynamic method;
  int confirmations;
  int type;
  dynamic exchangeRate;
  From to;
  dynamic txBurntFee;
  dynamic maxFeePerGas;
  Result result;
  String hash;
  String gasPrice;
  dynamic priorityFee;
  dynamic baseFeePerGas;
  From from;
  dynamic tokenTransfers;
  List<TxType> txTypes;
  String gasUsed;
  dynamic createdContract;
  int position;
  int nonce;
  bool? hasErrorInInternalTxs;
  List<dynamic> actions;
  dynamic decodedInput;
  dynamic tokenTransfersOverflow;
  RawInput rawInput;
  String value;
  dynamic maxPriorityFeePerGas;
  dynamic revertReason;
  List<int> confirmationDuration;
  dynamic txTag;

  Item({
    required this.timestamp,
    required this.fee,
    required this.gasLimit,
    required this.block,
    required this.status,
    required this.method,
    required this.confirmations,
    required this.type,
    required this.exchangeRate,
    required this.to,
    required this.txBurntFee,
    required this.maxFeePerGas,
    required this.result,
    required this.hash,
    required this.gasPrice,
    required this.priorityFee,
    required this.baseFeePerGas,
    required this.from,
    required this.tokenTransfers,
    required this.txTypes,
    required this.gasUsed,
    required this.createdContract,
    required this.position,
    required this.nonce,
    required this.hasErrorInInternalTxs,
    required this.actions,
    required this.decodedInput,
    required this.tokenTransfersOverflow,
    required this.rawInput,
    required this.value,
    required this.maxPriorityFeePerGas,
    required this.revertReason,
    required this.confirmationDuration,
    required this.txTag,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    timestamp: DateTime.parse(json["timestamp"]),
    fee: Fee.fromJson(json["fee"]),
    gasLimit: json["gas_limit"],
    block: json["block"],
    status: statusValues.map[json["status"]]!,
    method: json["method"],
    confirmations: json["confirmations"],
    type: json["type"],
    exchangeRate: json["exchange_rate"],
    to: From.fromJson(json["to"]),
    txBurntFee: json["tx_burnt_fee"],
    maxFeePerGas: json["max_fee_per_gas"],
    result: resultValues.map[json["result"]]!,
    hash: json["hash"],
    gasPrice: json["gas_price"],
    priorityFee: json["priority_fee"],
    baseFeePerGas: json["base_fee_per_gas"],
    from: From.fromJson(json["from"]),
    tokenTransfers: json["token_transfers"],
    txTypes: List<TxType>.from(json["tx_types"].map((x) => txTypeValues.map[x]!)),
    gasUsed: json["gas_used"],
    createdContract: json["created_contract"],
    position: json["position"],
    nonce: json["nonce"],
    hasErrorInInternalTxs: json["has_error_in_internal_txs"],
    actions: List<dynamic>.from(json["actions"].map((x) => x)),
    decodedInput: json["decoded_input"],
    tokenTransfersOverflow: json["token_transfers_overflow"],
    rawInput: rawInputValues.map[json["raw_input"]]!,
    value: json["value"],
    maxPriorityFeePerGas: json["max_priority_fee_per_gas"],
    revertReason: json["revert_reason"],
    confirmationDuration: List<int>.from(json["confirmation_duration"].map((x) => x)),
    txTag: json["tx_tag"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp.toIso8601String(),
    "fee": fee.toJson(),
    "gas_limit": gasLimit,
    "block": block,
    "status": statusValues.reverse[status],
    "method": method,
    "confirmations": confirmations,
    "type": type,
    "exchange_rate": exchangeRate,
    "to": to.toJson(),
    "tx_burnt_fee": txBurntFee,
    "max_fee_per_gas": maxFeePerGas,
    "result": resultValues.reverse[result],
    "hash": hash,
    "gas_price": gasPrice,
    "priority_fee": priorityFee,
    "base_fee_per_gas": baseFeePerGas,
    "from": from.toJson(),
    "token_transfers": tokenTransfers,
    "tx_types": List<dynamic>.from(txTypes.map((x) => txTypeValues.reverse[x])),
    "gas_used": gasUsed,
    "created_contract": createdContract,
    "position": position,
    "nonce": nonce,
    "has_error_in_internal_txs": hasErrorInInternalTxs,
    "actions": List<dynamic>.from(actions.map((x) => x)),
    "decoded_input": decodedInput,
    "token_transfers_overflow": tokenTransfersOverflow,
    "raw_input": rawInputValues.reverse[rawInput],
    "value": value,
    "max_priority_fee_per_gas": maxPriorityFeePerGas,
    "revert_reason": revertReason,
    "confirmation_duration": List<dynamic>.from(confirmationDuration.map((x) => x)),
    "tx_tag": txTag,
  };
}

class Fee {
  Type type;
  String value;

  Fee({
    required this.type,
    required this.value,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    type: typeValues.map[json["type"]]!,
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "value": value,
  };
}

enum Type {
  ACTUAL
}

final typeValues = EnumValues({
  "actual": Type.ACTUAL
});

class From {
  String hash;
  dynamic implementationName;
  bool isContract;
  bool isVerified;
  String? name;
  List<dynamic> privateTags;
  List<dynamic> publicTags;
  List<dynamic> watchlistNames;

  From({
    required this.hash,
    required this.implementationName,
    required this.isContract,
    required this.isVerified,
    required this.name,
    required this.privateTags,
    required this.publicTags,
    required this.watchlistNames,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
    hash: json["hash"],
    implementationName: json["implementation_name"],
    isContract: json["is_contract"],
    isVerified: json["is_verified"],
    name: json["name"],
    privateTags: List<dynamic>.from(json["private_tags"].map((x) => x)),
    publicTags: List<dynamic>.from(json["public_tags"].map((x) => x)),
    watchlistNames: List<dynamic>.from(json["watchlist_names"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "implementation_name": implementationName,
    "is_contract": isContract,
    "is_verified": isVerified,
    "name": name,
    "private_tags": List<dynamic>.from(privateTags.map((x) => x)),
    "public_tags": List<dynamic>.from(publicTags.map((x) => x)),
    "watchlist_names": List<dynamic>.from(watchlistNames.map((x) => x)),
  };
}

enum RawInput {
  THE_0_X
}

final rawInputValues = EnumValues({
  "0x": RawInput.THE_0_X
});

enum Result {
  AWAITING_INTERNAL_TRANSACTIONS,
  SUCCESS
}

final resultValues = EnumValues({
  "awaiting_internal_transactions": Result.AWAITING_INTERNAL_TRANSACTIONS,
  "success": Result.SUCCESS
});

enum Status {
  ERROR,
  OK
}

final statusValues = EnumValues({
  "error": Status.ERROR,
  "ok": Status.OK
});

enum TxType {
  COIN_TRANSFER,
  CONTRACT_CALL
}

final txTypeValues = EnumValues({
  "coin_transfer": TxType.COIN_TRANSFER,
  "contract_call": TxType.CONTRACT_CALL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
