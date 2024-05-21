import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Token Toggle Interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TokenTogglePage(),
    );
  }
}

class TokenTogglePage extends StatefulWidget {
  @override
  _TokenTogglePageState createState() => _TokenTogglePageState();
}

class _TokenTogglePageState extends State<TokenTogglePage> {
  final String apiURL = 'https://assets-registry.vercel.app/';
  Map<String, dynamic> allTokens = {};
  List<String> enabledTokens = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchTokens();
    startDataRefreshTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startDataRefreshTimer() {
    const refreshInterval = Duration(seconds: 30); // Refresh every 30 seconds
    timer = Timer.periodic(refreshInterval, (Timer t) {
      fetchTokens();
    });
  }

  Future<void> fetchTokens() async {
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      setState(() {
        allTokens = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load tokens');
    }
  }

  void toggleToken(String tokenKey) {
    setState(() {
      if (enabledTokens.contains(tokenKey)) {
        enabledTokens.remove(tokenKey);
      } else {
        enabledTokens.add(tokenKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Token Toggle Interface'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return buildWideLayout();
          } else {
            return buildNarrowLayout();
          }
        },
      ),
    );
  }

  Widget buildWideLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: buildTokenList('All Tokens', allTokens.keys.where((key) => !enabledTokens.contains(key)).toList()),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: buildTokenList('Enabled Tokens', enabledTokens),
          ),
        ],
      ),
    );
  }

  Widget buildNarrowLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: buildTokenList('All Tokens', allTokens.keys.where((key) => !enabledTokens.contains(key)).toList()),
          ),
          const Divider(),
          Expanded(
            child: buildTokenList('Enabled Tokens', enabledTokens),
          ),
        ],
      ),
    );
  }

  Widget buildTokenList(String title, List<String> tokens) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView(
            children: tokens.map((key) => tokenCard(key, allTokens[key])).toList(),
          ),
        ),
      ],
    );
  }

  Widget tokenCard(String key, dynamic token) {
    return Card(
      child: ListTile(
        leading: Image.network(
          token['LOGO'],
          width: 30,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, size: 30);
          },
        ),
        title: Text('${token['NAME']} (${token['SYMBOL']})'),
        trailing: Switch(
          value: enabledTokens.contains(key),
          onChanged: (bool value) {
            toggleToken(key);
          },
        ),
      ),
    );
  }
}