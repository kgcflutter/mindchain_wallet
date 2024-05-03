import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/screens/token_to_token_amount_send_screen.dart';
import 'package:mindchain_wallet/presentation/screens/transaction_details.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/received_widget.dart';
import 'package:provider/provider.dart';

import '../provider/account_details_provider.dart';
import '../utils/convert_to_eth.dart';

class AddedTokenSendScreen extends StatelessWidget {
  String balance;
  String fullName;
  String contractAddress;

  AddedTokenSendScreen(
      {super.key,
      required this.balance,
      required this.fullName,
      required this.contractAddress,
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                  child: Consumer<AccountDetailsProvider>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      leading: const Icon(Icons.token),
                      title: Text(
                        balance,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(fullName),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 54),
                                  backgroundColor: const Color(0xff28BAA7)),
                              onPressed: () {
                                value.loadPrivateKeyAddress();
                                showBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      receivedWidget(value, context),
                                );
                              },
                              child: const Text(
                                "Receive",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 54),
                                backgroundColor: const Color(0xffE54C67)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TokenToTokenAmountScreen(
                                            contractAddress: contractAddress, tokenName: fullName,),
                                  ),);
                            },
                            child: const Text(
                              "Send",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.transactionFulldata.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransactionDetails(
                                  index: index,
                                ),
                              )),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    value.myAddress.toLowerCase() ==
                                            value.transactionFulldata[index].to
                                                .hash
                                                .toString()
                                                .toLowerCase()
                                        ? "Received"
                                        : "Send",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: value.myAddress ==
                                                value.transactionFulldata[index]
                                                    .to.hash
                                                    .toString()
                                                    .toLowerCase()
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                  Text(
                                    value.transactionFulldata[index].timestamp
                                        .split("T")[0]
                                        .toString(),
                                    style: const TextStyle(fontSize: 11),
                                  )
                                ],
                              )
                            ],
                          ),
                          trailing: Icon(
                            value.myAddress.toLowerCase() ==
                                    value.transactionFulldata[index].from.hash
                                        .toString()
                                        .toLowerCase()
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 19,
                            color: value.myAddress ==
                                    value.transactionFulldata[index].to.hash
                                        .toString()
                                        .toLowerCase()
                                ? Colors.green
                                : Colors.red,
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                publicConvertToEth(
                                    BigInt.parse(
                                      value.transactionFulldata[index].value,
                                    ),
                                    "MIND"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              value.transactionFulldata[index].status == "ok"
                                  ? Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: value.myAddress ==
                                                  value
                                                      .transactionFulldata[
                                                          index]
                                                      .to
                                                      .hash
                                                      .toString()
                                                      .toLowerCase()
                                              ? Colors.green.shade200
                                              : Colors.green.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Success",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: value.myAddress ==
                                                    value
                                                        .transactionFulldata[
                                                            index]
                                                        .to
                                                        .hash
                                                        .toString()
                                                        .toLowerCase()
                                                ? Colors.green
                                                : Colors.green),
                                      ))
                                  : const Text("Field")
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
