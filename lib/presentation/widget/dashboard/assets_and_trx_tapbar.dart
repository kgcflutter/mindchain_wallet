import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
import 'package:mindchain_wallet/presentation/screens/added_token_send_screen.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/transaction_listview.dart';
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
                        Provider.of<AccountDetailsProvider>(context,
                                listen: false)
                            .fetchUserTransactionData();
                      }
                    },
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: const Color(0xffFF8A00),
                    tabs: const [
                      Tab(text: 'Assets'),
                      Tab(text: 'Transactions'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: TabBarView(
                      children: [buildTokenList(), const TransactionListView()],
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

  Consumer<NewAssetsTokenAddProvider> buildTokenList() {
    return Consumer<NewAssetsTokenAddProvider>(
      builder: (context, value, child) => RefreshIndicator(
        color: Colors.orange,
        onRefresh: () =>
            Provider.of<NewAssetsTokenAddProvider>(context, listen: false)
                .showAddedTokenAndBalance(),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: value.allScreenTokenList.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xffC1C1C1),
                ),
              ),
              child: ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddedTokenSendScreen(
                        balance: value.allScreenTokenList[index]['balance'],
                        fullName: value.allScreenTokenList[index]['name'],
                        contractAddress: value.allScreenTokenList[index]['address'],
                      ),
                    )),
                trailing: Column(
                  children: [
                    Text(
                      value.allScreenTokenList[index]['balance'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                     Text(value.balanceMaker(value.allScreenTokenList[index]['balance'], value.allScreenTokenList[index]['value'])
                     )],
                ),
                title: Text(
                  value.allScreenTokenList[index]['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ), 
                subtitle:  Text(value.allScreenTokenList[index]['value']),
                leading: Image.asset(
                  value.allScreenTokenList[index]['image'],
                  height: 37,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
