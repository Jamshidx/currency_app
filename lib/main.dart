import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyApp());
}

class CurrencyApp extends StatelessWidget {
  const CurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController amountController;
  late TextEditingController convertedAmountController;

  String fromCurrency = "USD";
  String toCurrency = "UZS";

  double usdToUzsRate = 12600;
  double uzsToUsdRate = 1 / 12600;

  void convertCurrency() {
    if(amountController.text.isEmpty){
      convertedAmountController.text = "0";
      return;
    }

    double amount = double.tryParse(amountController.text) ?? 0.0;
    double result;

    if (fromCurrency == "USD" && toCurrency == "UZS") {
      result = amount * usdToUzsRate;
    } else if (fromCurrency == "UZS" && toCurrency == "USD") {
      result = amount * uzsToUsdRate;
    } else {
      result = amount;
    }

    convertedAmountController.text = result.toStringAsFixed(2);
  }

  //valyutani almashtirish
  void swapCurrencies() {
    String tempCurrency = fromCurrency;
    fromCurrency = toCurrency;
    toCurrency = tempCurrency;

    // Valyutalar almashganda konvertatsiyani qayta hisoblash
    convertCurrency();

    // UI ni yangilash
    setState(() {});
  }



  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: "1.00");
    convertedAmountController = TextEditingController(text: '12600.00');

    amountController.addListener(convertCurrency);
  }

  @override
  void dispose() {
    amountController.removeListener(convertCurrency);
    amountController.dispose();
    convertedAmountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(234, 238, 252, 1),
                    Color.fromRGBO(246, 246, 246, 1)
                  ]
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //title
              Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 15),
                child: Align(
                  child: Text(
                    "Currency Converter",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(31, 34, 97, 1),
                    ),
                  ),
                ),
              ),
              Text(
                "Check live rates, set rate alerts, receive \nnotifications and more.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(128, 128, 128, 1),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              //card
              Card(
                color: Colors.white,
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: 320,
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: AssetImage(fromCurrency == "USD" ? "assets/aqshFlag.png" : "assets/uzs.jpg"),),

                              ),
                            ),
                            SizedBox(width: 10),
                            Text(fromCurrency,
                              style: TextStyle(
                                  color: Color.fromRGBO(42, 43, 137, 1),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal
                              ),

                            ),
                            //Icon
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color.fromRGBO(128, 128, 128, 1),
                                size: 30,
                              ),
                            ),
                            // **TO'G'IRLANGAN QISM: Expanded widgeti qo'shildi**
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(239, 239, 239, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(
                                    controller: amountController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ///divide + icon
                        SizedBox(height: 20,),
                        Stack(
                            alignment: Alignment.center,
                            children: [
                              Divider(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(42, 43, 137, 1),
                                  ),
                                  child: IconButton(
                                      onPressed: swapCurrencies, // Metodga ulaymiz
                                      icon: Icon(Icons.import_export_rounded, color: Colors.white, size: 30,))
                              )
                            ]
                        ),
                        SizedBox(height: 18,),
                        // uzs convertor
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Converted Amount",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: AssetImage(toCurrency == "UZS" ? "assets/uzs.jpg" : "assets/aqshFlag.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text( toCurrency,
                              style: TextStyle(
                                  color: Color.fromRGBO(42, 43, 137, 1),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal
                              ),

                            ),
                            //Icon
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color.fromRGBO(128, 128, 128, 1),
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(239, 239, 239, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(
                                    controller: convertedAmountController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              ///Exchange
              Padding(
                padding: const EdgeInsets.only(left: 26, bottom: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Indicative Exchange Rate",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(128, 128, 128, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                        fromCurrency == "USD" ? "1 USD = ${usdToUzsRate.toStringAsFixed(2)} UZS"
                        : "1 UZS = ${uzsToUsdRate.toStringAsFixed(6)} USD", // Kichik raqamlar uchun kasr sonini oshiramiz
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(31, 34, 97, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}