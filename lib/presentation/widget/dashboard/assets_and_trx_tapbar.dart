import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
import 'package:mindchain_wallet/presentation/screens/send_token_screen.dart';
import 'package:mindchain_wallet/presentation/screens/token_to_token_amount_send_screen.dart';
import 'package:provider/provider.dart';

class AssetsAndTrxTapbar extends StatelessWidget {
  const AssetsAndTrxTapbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: const Color(0XffBABABA),
        // ),
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
                    Tab(text: 'NFTs'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: TabBarView(
                    children: [
                      buildTokenList(),
                      const Center(child: Text("Coming soon"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Consumer<NewAssetsTokenAddProvider> buildTokenList() {
    return Consumer<NewAssetsTokenAddProvider>(
      builder: (context, value, child) => RefreshIndicator(
        color: Colors.orange,
        onRefresh: () =>
                value.showAddedTokenAndBalance(),
        child: Visibility(
          visible: value.enabledTokens.isNotEmpty,
          replacement: const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          ),
          child: ListView.builder(
            itemCount: value.enabledTokens.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SendToken(),
                    ),
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TokenToTokenAmountScreen(
                            contractAddress: value.enabledTokens[index]
                                ['contract'],
                            tokenName: value.enabledTokens[index]['name']),
                      ));
                }
              },
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${value.enabledTokens[index]['dollar']}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    value.enabledTokens[index]['change'] == '0'
                        ? ''
                        : value.enabledTokens[index]['change'],
                    style: TextStyle(
                        fontSize: 9,
                        color: value.enabledTokens[index]['change']
                                .toString()
                                .contains("-")
                            ? Colors.red
                            : Colors.green),
                  )
                ],
              ),
              leading: Image.asset(
                value.enabledTokens[index]['image'],
                width: 30,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 30);
                },
              ),
              title: Text('${value.enabledTokens[index]['name']}'),
              trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${value.enabledTokens[index]['balance']}',
                          style: const TextStyle(fontSize: 15),
                        ),
                        Consumer(
                          builder: (context, values, child) => Text(
                            value.balanceMaker(
                                value.enabledTokens[index]['balance'],
                                value.enabledTokens[index]['dollar']),
                            style: const TextStyle(fontSize: 9),
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
}
