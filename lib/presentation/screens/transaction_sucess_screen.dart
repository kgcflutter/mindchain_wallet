import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:mindchain_wallet/presentation/screens/dashboard_screen.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/utils/convert_to_eth.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code/code/src/code_generate.dart';
import 'package:qr_bar_code/code/src/code_type.dart';

class TransActionSuccessScreen extends StatefulWidget {
  final String tokenName;
  final String amount;
  final String toAddress;

  const TransActionSuccessScreen({
    Key? key,
    required this.tokenName,
    required this.amount,
    required this.toAddress,
  }) : super(key: key);

  @override
  State<TransActionSuccessScreen> createState() => _TransActionSuccessScreenState();
}

class _TransActionSuccessScreenState extends State<TransActionSuccessScreen> {
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await Provider.of<SendTokenProvider>(context).loadMyAddress();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
                (route) => false,
          );
        },
        child: BackgroundWidget(
          child: SafeArea(
            child: Consumer<SendTokenProvider>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(18.0),
                child: value.trxResult.isNotEmpty
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Transaction Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      AssetsPath.donePng,
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    const Text(
                      "Transaction Success",
                      style: TextStyle(
                        color: Color(0xff28BAA7),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("- ${widget.amount} ${widget.tokenName}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 15),),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("From"),
                          const SizedBox(height: 10,),
                          FittedBox(child: Text(obscureString(value.address))),
                          const SizedBox(height: 20,),
                          const Text("To"),
                          const SizedBox(height: 10,),
                          FittedBox(child: Text(obscureString(value.addressTEC.text))),
                          const SizedBox(height: 20,),
                          const Text("Network Fee"),
                          const SizedBox(height: 10,),
                          Text(value.gesPriceTEC.text),
                          const SizedBox(height: 20,),
                          const Divider(),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Transaction Hash"),
                                  Text(obscureString(value.trxResult)),
                                  const SizedBox(height: 10),
                                  const Text("Time"),
                                  Text(DateTime.now().toString().split(" ")[1]),
                                ],
                              ),
                              Code(
                                height: 95,
                                data: "https://mainnet.mindscan.info/tx/${value.trxResult}",
                                codeType: CodeType.qrCode(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    : value.trxError.isEmpty && value.trxResult != null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AssetsPath.sendLoading),
                     Text(value.trxWaiting),
                  ],
                )
                    : Column(
                  children: [
                    Text(value.trxError),
                    TextButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                            (route) => false,
                      ),
                      child: const Text("Back To Dashboard"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
