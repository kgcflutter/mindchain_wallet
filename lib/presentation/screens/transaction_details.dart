import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/copysystem.dart';
import 'package:mindchain_wallet/presentation/utils/uri_luncher.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

import '../utils/convert_to_eth.dart';

class TransactionDetails extends StatelessWidget {
  final int index;

  const TransactionDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundWidget(
        child: Consumer<AccountDetailsProvider>(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: screenSize.height * 0.6, // Adjusted for responsiveness
              child: Column(
                children: [
                  Lottie.asset(AssetsPath.sendLoading),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.myAddress.toLowerCase() ==
                                value.transactionFulldata[index].to.hash
                                    .toString()
                                    .toLowerCase()
                                ? "Received"
                                : "Send",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text("Status:"),InkWell(
                              onTap: () => launchWeb("https://mainnet.mindscan.info/tx/${value.transactionFulldata[index].hash}"),
                              child: const Text("View on block explorer",
                                style: TextStyle(color: Colors.blue),),
                            ),],),
                          const SizedBox(
                            height: 10,
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text("Confirmed",style: TextStyle(color: Colors.green),),
                              InkWell(
                                onTap: () => mnemonicListCopyText(context, value.transactionFulldata[index].hash),
                              child: const Text("Copy TrxID",
                                style: TextStyle(color: Colors.blue),),
                            )],),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "To",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                value.transactionFulldata[index].from.hash.length >
                                    12
                                    ? value.transactionFulldata[index].from.hash
                                    .substring(0, 12)
                                    : value.transactionFulldata[index].from.hash,
                              ),
                              const Icon(Icons.arrow_circle_right_outlined,color: Colors.green,),
                              Text(
                                value.transactionFulldata[index].to.hash.length > 5
                                    ? value.transactionFulldata[index].to.hash
                                    .substring(0, 12)
                                    : value.transactionFulldata[index].to.hash,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Transaction",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          rowData("Nonce", value.transactionFulldata[index].nonce.toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          rowData("Amount", publicConvertToEth(
                            BigInt.parse(value.transactionFulldata[index].value),
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          rowData("Gas Limit:", value.transactionFulldata[index].gasLimit),
                          const SizedBox(
                            height: 10,
                          ),
                          rowData("Gas Used:", value.transactionFulldata[index].gasUsed),
                          const SizedBox(
                            height: 10,
                          ),
                          rowData("Total", totalPublicConvertToEth(totalMind(
                            BigInt.parse(value.transactionFulldata[index].value),
                            BigInt.parse(value.transactionFulldata[index].fee.value),
                          ))),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rowData(String first, String second) {
    TextStyle myFontStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          first,
          style: myFontStyle,
        ),
        Text(second)
      ],
    );
  }
}
