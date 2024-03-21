import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:mindchain_wallet/widget/dashboard/transaction_listview.dart';
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
                  TabBar(
                    onTap: (index) {
                      if (index == 1) {
                        Provider.of<AccountDetailsProvider>(context,listen: false)
                            .fetchUserTransactionData();
                      }
                    },
                    indicatorColor: const Color(0xffFF8A00),
                    tabs: const [
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
                        const TransactionListView()
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
