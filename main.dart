import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//วาดครั้งเดียว
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A M A Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'AmA Shop'),
      debugShowCheckedModeBanner: false, // เอา debug ที่มุมขวาออก
    );
  }
}

//สามารถวาด widget ใหม่ได้ทุกครั้ง
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var price = TextEditingController();
  var quantity = TextEditingController();
  var change = TextEditingController();
  double _total = 0;
  double _change = 0;

  Widget priceTextfield() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: price,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'ราคาสินค้าต่อหน่วย',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget quantityTextfield() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: quantity,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'จำนวนสินค้าที่ซื้อ',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget calculateButton() {
    return ElevatedButton(
      onPressed: () {
        if (price.text.isNotEmpty && quantity.text.isNotEmpty) {
          setState(() {
            _total = double.parse(price.text) * double.parse(quantity.text);
          });
        }
      },
      child: const Text('คำนวณ'),
    );
  }

  Widget showTotalText() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('จำนวนเงินทั้งหมด :  $_total บาท'),
    );
  }

  Widget changeTextfield() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: change,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'ลูกค้าให้เงินมา',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget changeButton() {
    return ElevatedButton(
      onPressed: () {
        if (change.text.isNotEmpty && (double.parse(change.text) >= _total)) {
          setState(() {
            _change = double.parse(change.text) - _total;
          });
        } else {
          setState(() {
            _change = 0;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('คุณจ่ายเงินไม่ครบจำนวน')),
          );
        }
      },
      child: const Text('เงินทอน'),
    );
  }

  Widget showchangeText() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('เงินทอน : $_change บาท'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Column(
        children: [
          priceTextfield(),
          quantityTextfield(),
          calculateButton(),
          showTotalText(),
          changeTextfield(),
          changeButton(),
          showchangeText(),
        ],
      ),
    );
  }
}
