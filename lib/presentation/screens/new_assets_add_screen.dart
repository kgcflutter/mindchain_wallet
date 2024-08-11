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
                      child:
                      ListView.builder(
                        itemCount: value.allTokens.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                          ListTile(
                            leading: Image.asset(
                              value.allTokens[index]['image'],
                              width: 30,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error, size: 30);
                              },
                            ),
                            title: Text('${value.allTokens[index]['name']}'),
                            trailing: Switch(
                              value:  value.enabledTokens.contains(value.allTokens[index]),
                              onChanged: (bool values) {
                                value.toggleToken(value.allTokens[index]);
                              },
                            ),
                          ),),
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
}
