import 'package:flutter/material.dart';
import 'package:mindchain_wallet/conts/strings.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/widget/private_key_button_widget.dart';
import 'package:mindchain_wallet/presentation/widget/private_key_widget.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code/code/src/code_generate.dart';
import 'package:qr_bar_code/code/src/code_type.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  @override
  void initState() {
    super.initState();
    var data = Provider.of<AccountDetailsProvider>(context,listen: false);
    if(data.showKey == true){
      data.showMyKey();
    }
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<AccountDetailsProvider>(context).loadPrivateKeyAddress();
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Account Details'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              alertText(),
              const SizedBox(
                height: 30,
              ),
              Consumer<AccountDetailsProvider>(
                builder: (context, value, child) => Column(
                  children: [
                    SizedBox(
                      height: 0.01 * screenSize.height,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width - 200,
                      width: MediaQuery.of(context).size.width - 170,
                      child: Code(
                        data: value.myAddress,
                        codeType: CodeType.qrCode(),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Private key"),
                    const SizedBox(
                      height: 10,
                    ),
                    privateKeyBox(value, screenSize,context),
                    SizedBox(
                      height: 0.02 * screenSize.height,
                    ),
                    privateKeyCopyButton(screenSize, context, value),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget alertText() {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color(0xffFFECEF),
      ),
      child: const Text(
        AllStrings.alertText,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 11, color: Colors.red),
      ),
    );
  }
}
