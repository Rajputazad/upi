import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:upi/razorpay.dart';

void main() {
  // dotenv.load(fileName: "lib/.env");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RazorPayIntegration _integration = RazorPayIntegration();
  TextEditingController amount = TextEditingController();
  final logger = Logger();
  @override
  void initState() {
    super.initState();
    _integration.intiateRazorPay();
  }

  late String data = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay"),
      ),
      body: Column(children: [
        FloatingActionButton(
          onPressed: ()async  {
            double amountValue = double.tryParse(amount.text) ?? 00;
             await _integration.openSession(amount: amountValue);
setState(() {
  
            logger.d(data);
});
          },
          tooltip: 'Razorpay',
          child: const Icon(Icons.add),
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: amount,
          decoration: const InputDecoration(
            labelText: 'Enter amount',
          ),
        ),
        
        Text(data)
        //  SuccessResponseWidget()
      ]),
    );
  }
}
// class SuccessResponseWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final paymentState = Provider.of<PaymentState>(context);
//     return Text(paymentState.successResponse);
//   }
// }

// class PaymentState {
// }