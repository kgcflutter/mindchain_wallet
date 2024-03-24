import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';

class TokenSendConfirmScreen extends StatelessWidget {
  const TokenSendConfirmScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04), // Adjust padding based on screen width
          child: SizedBox(
            child: Card(
              elevation: 0, // Remove card elevation
              color: const Color(0x35d2d2d2),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.02), // Adjust padding based on screen width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Send Account"),
                        Text("Receive Account"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.fromBorderSide(BorderSide(color: Colors.black45)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  AssetsPath.mindLogoPng,
                                  height: 30,
                                ),
                                const Text("grgheuyhfguewhfsuya"),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.green,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.fromBorderSide(BorderSide(color: Colors.black45)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  AssetsPath.mindLogoPng,
                                  height: 30,
                                ),
                                const SizedBox(width: 5),
                                const Text("grgheuyhfguewhfsuya"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.fromBorderSide(BorderSide(color: Color(0xffFF8A00))),
                      ),
                      child: const Text(
                        "Sending MIND",
                        style: TextStyle(
                          color: Color(0xffFF8A00),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.fromBorderSide(BorderSide(color: Colors.black45)),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Estimated Gas",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("5655 MIND"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Max Fee",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("5655 MIND"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "TOTAL",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("5655 MIND"),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff28BAA7),
                            minimumSize: Size(screenWidth * 0.35, 48), // Adjust button width based on screen width
                          ),
                          onPressed: () {},
                          child: const Text("Confirm", style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffE54C67),
                            minimumSize: Size(screenWidth * 0.35, 48), // Adjust button width based on screen width
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Reject", style: TextStyle(color: Colors.white)),
                        ),
                      ],
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
