class Transaction {
  final String timestamp;
  final Fee fee;
  final String gasLimit;
  final int block;
  final String status;
  final int confirmations;
  final int type;
  final To to;
  final String hash;
  final String gasPrice;
  final From from;
  final String gasUsed;
  final int nonce;
  final List<String> txTypes;
  final String value;
  final List<double> confirmationDuration;

  Transaction({
    required this.timestamp,
    required this.fee,
    required this.gasLimit,
    required this.block,
    required this.status,
    required this.confirmations,
    required this.type,
    required this.to,
    required this.hash,
    required this.gasPrice,
    required this.from,
    required this.gasUsed,
    required this.nonce,
    required this.txTypes,
    required this.value,
    required this.confirmationDuration,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      timestamp: json['timestamp'],
      fee: Fee.fromJson(json['fee']),
      gasLimit: json['gas_limit'],
      block: json['block'],
      status: json['status'],
      confirmations: json['confirmations'],
      type: json['type'],
      to: To.fromJson(json['to']),
      hash: json['hash'],
      gasPrice: json['gas_price'],
      from: From.fromJson(json['from']),
      gasUsed: json['gas_used'],
      nonce: json['nonce'],
      txTypes: json['tx_types'].cast<String>(),
      value: json['value'],
      confirmationDuration: json['confirmation_duration'].cast<double>(),
    );
  }
}

class Fee {
  final String type;
  final String value;

  Fee({
    required this.type,
    required this.value,
  });

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      type: json['type'],
      value: json['value'],
    );
  }
}

class To {
  final String hash;

  To({
    required this.hash,
  });

  factory To.fromJson(Map<String, dynamic> json) {
    return To(
      hash: json['hash'],
    );
  }
}

class From {
  final String hash;

  From({
    required this.hash,
  });

  factory From.fromJson(Map<String, dynamic> json) {
    return From(
      hash: json['hash'],
    );
  }
}
