import 'package:flutter/material.dart';
import 'package:mindchain_wallet/app.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/authenticator/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/provider/main_bottom_nav_bar_controller.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:mindchain_wallet/presentation/provider/splash_Screen_provider.dart';
import 'package:provider/provider.dart';



void main(){
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CreateWalletProvider()),
        ChangeNotifierProvider(create: (context) => MainBottomNavBarController()),
        ChangeNotifierProvider(create: (context) => SendTokenProvider()),
        ChangeNotifierProvider(create: (context) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (context) => AccountDetailsProvider()),
        ChangeNotifierProvider(
            create: (context) => NewAssetsTokenAddProvider()),
      ],
      child: const MindWallet(),
    );
  }
}
