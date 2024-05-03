import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/splash_Screen_provider.dart';
import 'package:mindchain_wallet/presentation/utils/assets_path.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SplashScreenProvider>(context,listen: false).runApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Image.asset(AssetsPath.mindLogoPng,height: 200,),
        ),
      ),
    );
  }
}
