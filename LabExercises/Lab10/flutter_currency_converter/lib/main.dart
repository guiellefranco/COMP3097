import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CurrencyInputScreen(),
    );
  }
}

class CurrencyInputScreen extends StatefulWidget {
  const CurrencyInputScreen({super.key});

  @override
  State<CurrencyInputScreen> createState() => _CurrencyInputScreenState();
}

class SummaryScreen extends StatelessWidget {
  final String usdValue;
  final String cadValue;
  final double exchangeRate;

  const SummaryScreen({
    super.key,
    required this.usdValue,
    required this.cadValue,
    required this.exchangeRate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion Summary'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Conversion Summary',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'USD: $usdValue',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'CAD: $cadValue',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Exchange Rate: 1 USD = $exchangeRate CAD',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyInputScreenState extends State<CurrencyInputScreen> {
  final TextEditingController usdController = TextEditingController();
  final TextEditingController cadController = TextEditingController();

  final double exchangeRate = 1.35;
  bool isUpdating = false;

  void convertFromUSD(String value) {
    if (isUpdating) return;
    isUpdating = true;

    if (value.isEmpty) {
      cadController.clear();
      isUpdating = false;
      return;
    }

    final double? usd = double.tryParse(value);
    if (usd != null) {
      final double cad = usd * exchangeRate;
      cadController.text = cad.toStringAsFixed(2);
    }

    isUpdating = false;
  }

  void convertFromCAD(String value) {
    if (isUpdating) return;
    isUpdating = true;

    if (value.isEmpty) {
      usdController.clear();
      isUpdating = false;
      return;
    }

    final double? cad = double.tryParse(value);
    if (cad != null) {
      final double usd = cad / exchangeRate;
      usdController.text = usd.toStringAsFixed(2);
    }

    isUpdating = false;
  }

  @override
  void dispose() {
    usdController.dispose();
    cadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'USD ↔ CAD Converter',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: usdController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: convertFromUSD,
              decoration: const InputDecoration(
                labelText: 'USD',
                hintText: 'Enter amount in USD',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cadController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: convertFromCAD,
              decoration: const InputDecoration(
                labelText: 'CAD',
                hintText: 'Enter amount in CAD',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Exchange Rate: 1 USD = $exchangeRate CAD',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (usdController.text.isEmpty || cadController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid amount first.'),
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SummaryScreen(
                      usdValue: usdController.text,
                      cadValue: cadController.text,
                      exchangeRate: exchangeRate,
                    ),
                  ),
                );
              },
              child: const Text('Go to Summary'),
            ),
          ],
        ),
      ),
    );
  }
}
