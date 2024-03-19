import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:mindchain_wallet/presentation/screens/trx_done_screen.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/widget/gredient_background_bottom.dart';
import 'package:provider/provider.dart';

class SendToken extends StatefulWidget {
  const SendToken({super.key});

  @override
  State<SendToken> createState() => _SendTokenState();
}

class _SendTokenState extends State<SendToken> {
  @override
  void initState() {
    super.initState();
    Provider.of<SendTokenProvider>(context, listen: false).loadGesPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                                  fontWeight: FontWeight.bold, fontSize: 21),
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
                        const SizedBox(
                          height: 60,
                        ),
                        InputDesign(
                          hintText: "Amount:",
                          inputType: TextInputType.number,
                          controller: provider.amountTEC,
                        ),
                        const SizedBox(
                          height: 05,
                        ),
                        Consumer<CreateWalletProvider>(
                          builder: (context, value, child) => Text(
                            " Your Balance ${value.mindBalance} MIND",
                            style: const TextStyle(
                                color: Color(0xffFF8A00),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 05,
                        ),
                        InputDesign(
                          hintText: "Receiver Address...",
                          inputType: TextInputType.text,
                          controller: provider.addressTEC,
                        ),
                        const SizedBox(
                          height: 05,
                        ),
                        const Row(
                          children: [
                            Text("Gas Price (GWEI)"),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.info,
                              size: 18,
                            )
                          ],
                        ),
                        InputDesign(
                          hintText: "10.9999999999",
                          inputType: TextInputType.text,
                          controller: provider.gesPriceTEC,
                        ),
                        const SizedBox(
                          height: 05,
                        ),
                        const Row(
                          children: [
                            Text("Gas Limit"),
                            SizedBox(
                              width: 5,
                            ),
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
                        const Spacer(),
                        Consumer<SendTokenProvider>(
                          builder: (context, value, child) => GestureDetector(
                            onTap: () {
                              value.sendEth();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TrxDoneScreen(),
                                ),
                              );
                            },
                            child: GredientBackgroundBtn(
                              child: const Text(
                                "Next",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class InputDesign extends StatelessWidget {
  TextInputType inputType;
  String hintText;
  TextEditingController controller;

  InputDesign(
      {super.key,
      required this.hintText,
      required this.inputType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
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
            borderSide: BorderSide(color: Color(0xff959595))),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
