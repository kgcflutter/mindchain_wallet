import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/presentation/widget/gredient_background_bottom.dart';
import 'package:provider/provider.dart';

class NewAssetsAddScreen extends StatelessWidget {
  const NewAssetsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select New Assets'),),
      body: BackgroundWidget(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<NewAssetsTokenAddProvider>(
              builder: (context, value, child) => Expanded(
                child: ListView.builder(
                  itemCount: value.allTokenList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 7),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0x41eaeaea),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.fromBorderSide(
                          BorderSide(
                              color: Color(0xffBABABA),
                              style: BorderStyle.solid),
                        ),
                      ),
                      child: ListTile(
                        subtitle: Text(value.allTokenList[index]['name']),
                        leading: const Icon(
                          Icons.token,
                          color: Colors.deepOrangeAccent,
                        ),
                        trailing: Switch(
                          activeColor: Colors.blue,
                          value: true,
                          onChanged: (value) {},
                        ),
                        title: Text(value.allTokenList[index]['symbol']),
                        shape: Border.all(
                            color: const Color(0xffBABABA),
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: GredientBackgroundBtn(onTap: () => Navigator.pop(context),
              child: const Text("SAVE")),
            )
          ],
        ),
      )),
    );
  }
}
