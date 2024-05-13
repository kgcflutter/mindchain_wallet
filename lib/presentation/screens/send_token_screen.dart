import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:mindchain_wallet/presentation/screens/Qr_screen.dart';
import 'package:mindchain_wallet/presentation/screens/token_send_confirm_screen.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/presentation/widget/custom_popup.dart';
import 'package:mindchain_wallet/presentation/widget/gredient_background_bottom.dart';
import 'package:provider/provider.dart';

import '../widget/input_design_widget.dart';

class SendToken extends StatefulWidget {
  const SendToken({Key? key}) : super(key: key);

  @override
  State<SendToken> createState() => _SendTokenState();
}

class _SendTokenState extends State<SendToken> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SendTokenProvider>(context, listen: false).loadGesPrice();
      Provider.of<SendTokenProvider>(context, listen: false).loadMyAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Card(
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              color: const Color(0x35d2d2d2),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Consumer<SendTokenProvider>(
                  builder: (context, provider, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Send Your Funds",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        onChanged: (value) {
                          provider.hideOpenInput(value);
                          print(value);
                        },
                        controller: provider.amountTEC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffix: InkWell(
                              onTap: () {
                                provider.amountTEC.text = '';
                                provider.amountTEC.text =
                                    '${double.parse(Provider.of<CreateWalletProvider>(context, listen: false).mindBalance.split('MIND')[0].trim()) - 0.03}';
                                provider.hideOpenInput("00");
                              },
                              child: const Text("max")),
                          hintStyle: const TextStyle(fontSize: 13),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff959595),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff959595),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff959595),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(14),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(color: Color(0xff959595)),
                          ),
                          hintText: "Amount",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Consumer<CreateWalletProvider>(
                        builder: (context, value, child) => Text(
                          " Your Balance ${value.mindBalance}",
                          style: const TextStyle(
                            color: Color(0xffFF8A00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      _buildTextField(provider, context),
                      const SizedBox(height: 5),
                      provider.hideOpen == true
                          ? buildColumn(provider)
                          : const Text(""),
                      const SizedBox(height: 20),
                      Consumer<SendTokenProvider>(
                        builder: (context, value, child) =>
                            GredientBackgroundBtn(
                          onTap: () {
                            if (value.addressTEC.text.length > 40 &&
                                value.amountTEC.text.isNotEmpty &&
                                value.gesLimitTEC.text.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TokenSendConfirmScreen(
                                      tokenName: 'MIND',
                                    ),
                                  ));
                            } else {
                              customPopUp(
                                context,
                                "Error",
                                const Text("Fill all input"),
                              );
                            }
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumn(SendTokenProvider provider) {
    return Column(
      children: [
        const Row(
          children: [
            Text("Gas Price (GWEI)"),
            SizedBox(width: 5),
            Icon(
              Icons.info,
              size: 18,
            ),
          ],
        ),
        InputDesign(
          hintText: "10.9999999999",
          inputType: TextInputType.text,
          controller: provider.gesPriceTEC,
        ),
        const SizedBox(height: 5),
        const Row(
          children: [
            Text("Gas Limit"),
            SizedBox(width: 5),
            Icon(
              Icons.info,
              size: 18,
            )
          ],
        ),
        InputDesign(
          hintText: "10.9999999999",
          inputType: TextInputType.text,
          controller: provider.gesLimitTEC,
        ),
      ],
    );
  }

  TextField _buildTextField(SendTokenProvider provider, BuildContext context) {
    return TextField(
      controller: provider.addressTEC,
      decoration: InputDecoration(
        hintText: "Receiver Address...",
        hintStyle: const TextStyle(fontSize: 12),
        suffixIcon: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrCodeScanScreen(),
                )),
            child: const Icon(Icons.qr_code_2)),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Color(0xff959595),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(14),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff959595)),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
