import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:mindchain_wallet/presentation/screens/transaction_sucess_screen.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

class TokenToTokenAmountScreen extends StatefulWidget {
  String contractAddress;
  String tokenName;

  TokenToTokenAmountScreen(
      {super.key,
      required this.contractAddress,
      required this.tokenName,});

  @override
  State<TokenToTokenAmountScreen> createState() =>
      _TokenToTokenAmountScreenState();
}

class _TokenToTokenAmountScreenState extends State<TokenToTokenAmountScreen> {
  @override
  void initState() {
    super.initState();
    loadAll();
  }

  loadAll() async {
    await Provider.of<SendTokenProvider>(context, listen: false)
        .addNewToken(widget.contractAddress);
    Provider.of<SendTokenProvider>(context, listen: false).loadMyAddress();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Token To Token"),),
      body: BackgroundWidget(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<SendTokenProvider>(
                builder: (context, value, child) => value.tokens.isEmpty
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: value.amountTEC,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Amount:",
                              hintStyle: TextStyle(fontSize: 12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  color: Color(0xff959595),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(14),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff959595)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: value.addressTEC,
                            keyboardType: TextInputType.text,
                            maxLength: 47,
                            decoration: const InputDecoration(
                              hintText: "Receiver Address:",
                              hintStyle: TextStyle(fontSize: 12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  color: Color(0xff959595),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(14),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff959595)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff28BAA7),
                              minimumSize: const Size(double.infinity,
                                  48), // Adjust button width based on screen width
                            ),
                            onPressed: () {
                              value.sendTokenTransactionOption();
                              if (value.addressTEC.text != null &&
                                  value.amountTEC.text.length != null) {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransActionSuccessScreen(
                                              tokenName: widget.tokenName,
                                              amount: value.amountTEC.text,
                                              toAddress: value.addressTEC.text),
                                    ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("please fill all input")));
                              }
                            },
                            child: const Text("Confirm",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
              ))),
    );
  }
}
