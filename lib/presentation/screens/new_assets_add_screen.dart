import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

class NewAssetsAddScreen extends StatelessWidget {
  const NewAssetsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select New Assets'),
        actions: const [
          Icon(Icons.add),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<NewAssetsTokenAddProvider>(
                builder: (context, value, child) => Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade200),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: value.allTokens.isNotEmpty,
                      replacement: const CircularProgressIndicator(),
                      child: _buildTokenList(
                        value.allTokens.keys.toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTokenList(List<String> tokens) {
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
        subtitle: Text('${token['NAME']}',style: const TextStyle(fontSize: 11),),
        trailing: Switch(
          activeColor: Colors.white,
          activeTrackColor: Colors.indigoAccent,
          inactiveTrackColor: Colors.black.withOpacity(0.75),
          inactiveThumbColor: Colors.white,
          trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
          value: value.enabledTokens.contains(key),
          onChanged: (bool values) {
            value.toggleToken(key);
          },
        ),
      ),
    );
  }
}
