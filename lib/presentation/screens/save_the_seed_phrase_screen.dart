import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/utils/text_style.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';

class SaveTheSeedPhraseScreen extends StatelessWidget {
  const SaveTheSeedPhraseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Save The Seed Phrase", style: TextStyler().textHeadingStyle),
          ],
        ),
      ),
    );
  }
}
