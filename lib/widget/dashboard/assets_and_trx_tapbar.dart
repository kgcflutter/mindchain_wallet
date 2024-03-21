import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:provider/provider.dart';

class AssetsAndTrxTapbar extends StatelessWidget {
  const AssetsAndTrxTapbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0XffBABABA),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DefaultTabController(
              length: 2, // Number of tabs
              child: Column(
                children: <Widget>[
                  const TabBar(
                    indicatorColor: Color(0xffFF8A00),
                    tabs: [
                      Tab(text: 'Assets'),
                      Tab(text: 'Transactions'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0XffBABABA),
                                ),
                              ),
                              child: const ListTile(
                                trailing: Text(
                                  "\$42.251",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                title: Text(
                                  "234 BNB",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                leading: Icon(
                                  Icons.paid_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Consumer<AccountDetailsProvider>(
                          builder: (context, value, child) => value.trxResult !=
                                  null
                              ? ListView.separated(
                                  itemCount: value.transactionFulldata.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: ListTile(
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Spacer(),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                value.myAddress.toLowerCase() ==
                                                        value
                                                            .transactionFulldata[
                                                                index]['from']
                                                                ['hash']
                                                            .toString()
                                                            .toLowerCase()
                                                    ? "Send"
                                                    : "Received",
                                                style: TextStyle(fontSize: 11),
                                              ),
                                              Text(
                                                "20.2.2023",
                                                style: TextStyle(fontSize: 11),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      trailing: Icon(
                                        value.myAddress.toLowerCase() ==
                                            value
                                                .transactionFulldata[
                                            index]['from']
                                            ['hash']
                                                .toString()
                                                .toLowerCase() ?
                                        Icons.arrow_upward : Icons.arrow_downward,
                                        size: 19,
                                      ),
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            publicConvertToEth(
                                              BigInt.parse(
                                                value.transactionFulldata[index]
                                                    ['value'],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text("\$42.251")
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                )
                              : Text(value.trxResult),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
