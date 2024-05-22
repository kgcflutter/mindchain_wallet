import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            child: _buildTokenList(value.enabledTokens),
          ),
        ),
      ),
    );
  }

  Widget _buildTokenList(List tokens) {
    return Consumer<NewAssetsTokenAddProvider>(
      builder: (context, value, child) => ListView(
        shrinkWrap: true,
        children:
            tokens.map((key) => _tokenCard(key, value.allTokens[key])).toList(),
      ),
    );
  }

  Widget _tokenCard(String key, dynamic token) {
    return Consumer<NewAssetsTokenAddProvider>(
      builder: (context, value, child) => ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Image.network(
          token['LOGO'],
          width: 30,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, size: 30);
          },
        ),
        title: Text('${token['SYMBOL']}'),
        subtitle: Row(
          children: [
            Text(
              double.parse(token['PRICE_API']['price'].toString())
                  .toStringAsFixed(3),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              token['PRICE_API']['change'].toString(),
              style: TextStyle(
                  fontSize: 11,
                  color: token['PRICE_API']['change'].toString().contains("-")
                      ? Colors.red
                      : Colors.green),
            ),
          ],
        ),
        trailing: const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "0",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "\$0.0",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
