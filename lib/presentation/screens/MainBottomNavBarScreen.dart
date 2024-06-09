import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/main_bottom_nav_bar_controller.dart';
import 'package:mindchain_wallet/presentation/provider/new_assets_token_add_provider.dart';
import 'package:mindchain_wallet/presentation/screens/dapp_screen.dart';
import 'package:mindchain_wallet/presentation/screens/earn_screen.dart';
import 'package:mindchain_wallet/presentation/screens/home_screen.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/transaction_listview.dart';
import 'package:provider/provider.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewAssetsTokenAddProvider>(context, listen: false)
        .loadBalances()
        .then((value) => Provider.of<NewAssetsTokenAddProvider>(context,
                listen: false)
            .showAddedTokenAndBalance()
            .then((value) =>
                Provider.of<NewAssetsTokenAddProvider>(context, listen: false)
                    .loadDollarValue()));
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const TransactionListView(),
    const EarnScreen(),
    const DappScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Consumer<MainBottomNavBarController>(
          builder: (context, value, child) => BottomNavigationBar(
            backgroundColor: Colors.white,
            useLegacyColorScheme: true,
            currentIndex: value.selectedIndex,
            onTap: value.changeIndex,
            selectedItemColor: Colors.black87,
            unselectedItemColor: const Color(0xff290059),
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.home_filled),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on), label: 'Earn'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.lock_clock), label: 'dApp'),
            ],
          ),
        ),
        body: Consumer<MainBottomNavBarController>(
          builder: (context, value, child) => _screens[value.selectedIndex],
        ),
      ),
    );
  }
}
