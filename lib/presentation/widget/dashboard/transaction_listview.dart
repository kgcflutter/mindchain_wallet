import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/screens/transaction_details.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:provider/provider.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({super.key});

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Transaction"),
        centerTitle: true,
      ),
      body: Consumer<AccountDetailsProvider>(
        builder: (context, value, child) => value.trxLoading == true
            ? const Center(child: CupertinoActivityIndicator())
            : value.trxResult.contains("Not")
                ? const Center(child: Text("No Transaction"))
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: value.transactionFulldata.length,
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
                                                value.transactionFulldata[index]
                                                    .to.hash
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
      ),
    );
  }
}
