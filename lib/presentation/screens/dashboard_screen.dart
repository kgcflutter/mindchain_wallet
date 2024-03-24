import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/widget/dashboard/dashboard_card.dart';
import '../../widget/dashboard/assets_and_trx_tapbar.dart';
import '../../widget/dashboard/send_receive_assets_row.dart';
import '../../widget/dashboard/wallet_balance_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      loadBal(context);
    });
  }

  loadBal(BuildContext context) async {
    Future.delayed(
      const Duration(milliseconds: 1000),
          () => Provider.of<CreateWalletProvider>(context, listen: false)
          .loadBalance(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                DashboardCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: walletCard(context),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SendReceiveAssetsRow(screenWidth: screenWidth),
                const SizedBox(height: 5,),
                const AssetsAndTrxTapbar(),
                const SizedBox(height: 30,)
              ].map((child) => Flexible(child: child)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
