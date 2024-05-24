import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
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
            Provider.of<NewAssetsTokenAddProvider>(context, listen: false)
                .showAddedTokenAndBalance(),
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
            itemBuilder: (context, index) =>
                ListTile(
                  leading: Image.asset(
                    value.enabledTokens[index]['image'],
                    width: 30,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 30);
                    },
                  ),
                  title: Text('${value.enabledTokens[index]['name']}'),
                  trailing: Text(value.enabledTokens[index]['balance']),
                ),),
        ),
      ),
    );
  }
}
