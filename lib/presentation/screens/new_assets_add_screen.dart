import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
import 'package:provider/provider.dart';

class NewAssetsAddScreen extends StatelessWidget {
  const NewAssetsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select New Assets'),
        actions: [
          IconButton(
              onPressed: () {
                _showAddAssetDialog(
                    context,
                    Provider.of<NewAssetsTokenAddProvider>(context,
                        listen: false),);
              },
              icon: const Icon(Icons.add)),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<NewAssetsTokenAddProvider>(
                builder: (context, provider, child) => Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (text) {
                        provider.searchTokens(
                            text); // Update token list based on search query
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Visibility(
                      visible: provider.filteredTokens.isNotEmpty,
                      replacement: const CircularProgressIndicator(),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.filteredTokens.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var token = provider.filteredTokens[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ListTile(
                              leading: Image.asset(
                                token['image'],
                                width: 30,
                                errorBuilder: (context, error, stackTrace) {
                                  return CircleAvatar(
                                    child: Text(token['name'].toString()[0]),
                                  );
                                },
                              ),
                              title: Text('${token['symbol']}'),
                              subtitle: Text('${token['name']}'),
                              trailing: Switch(
                                value: provider.enabledTokens.contains(token),
                                onChanged: (bool isEnabled) {
                                  provider.toggleToken(token);
                                },
                              ),
                            ),
                          );
                        },
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

  void _showAddAssetDialog(
      BuildContext context, NewAssetsTokenAddProvider provider) {
    final TextEditingController contractController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Asset'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contractController,
                decoration:
                    const InputDecoration(labelText: 'Contract Address'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final contractAddress = contractController.text;

                if (contractAddress.isNotEmpty) {
                  final isValid =
                      await provider.validateContractAddress(contractAddress);
                  if (isValid) {
                    await provider.addNewAsset(contractAddress, context);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid contract address')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a contract address')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
