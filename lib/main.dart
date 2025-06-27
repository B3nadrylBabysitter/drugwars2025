import 'package:flutter/material.dart';

void main() => runApp(DrugWarsApp());

class DrugWarsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drugwars 2025',
      theme: ThemeData.dark(),
      home: DrugWarsHomePage(),
    );
  }
}

class DrugWarsHomePage extends StatefulWidget {
  @override
  _DrugWarsHomePageState createState() => _DrugWarsHomePageState();
}

class _DrugWarsHomePageState extends State<DrugWarsHomePage> {
  String location = "New York";
  int cash = 2000;
  Map<String, int> inventory = {};

  final List<String> drugs = [
    "Xanax",
    "Adderall",
    "Oxy",
    "Coke",
    "Weed",
    "Shrooms",
    "Fentanyl"
  ];

  final List<String> cities = [
    "New York",
    "Chicago",
    "Atlanta",
    "Houston",
    "San Francisco",
    "Miami"
  ];

  final Map<String, int> prices = {
    "Xanax": 45,
    "Adderall": 60,
    "Oxy": 120,
    "Coke": 300,
    "Weed": 20,
    "Shrooms": 100,
    "Fentanyl": 500,
  };

  void travelTo(String newLocation) {
    setState(() {
      location = newLocation;
      _randomizePrices();
    });
  }

  void _randomizePrices() {
    drugs.forEach((drug) {
      prices[drug] = (20 + (500 * (0.5 + (0.5 * (new DateTime.now().millisecondsSinceEpoch % 10) / 10)))).toInt();
    });
  }

  void buyDrug(String drug) {
    int cost = prices[drug]!;
    if (cash >= cost) {
      setState(() {
        cash -= cost;
        inventory[drug] = (inventory[drug] ?? 0) + 1;
      });
    }
  }

  void sellDrug(String drug) {
    if ((inventory[drug] ?? 0) > 0) {
      setState(() {
        cash += prices[drug]!;
        inventory[drug] = inventory[drug]! - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drugwars 2025 - $location"),
      ),
      body: Column(
        children: [
          Text("💵 Cash: \$${cash}", style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: cities
                .map((c) => ElevatedButton(
                      onPressed: () => travelTo(c),
                      child: Text(c),
                    ))
                .toList(),
          ),
          Expanded(
            child: ListView(
              children: drugs
                  .map((drug) => ListTile(
                        title: Text(drug),
                        subtitle: Text("Price: \$${prices[drug]} | Owned: ${inventory[drug] ?? 0}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: () => buyDrug(drug), icon: Icon(Icons.add)),
                            IconButton(onPressed: () => sellDrug(drug), icon: Icon(Icons.remove)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
