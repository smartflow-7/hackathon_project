import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/Time_buttons.dart';
import 'package:hackathon_project/Widgets/simplestocktile.dart';
import 'package:hackathon_project/Widgets/stocklinechart.dart';
import 'package:hackathon_project/models/Providers/api_service.dart';
import 'package:hackathon_project/models/Providers/chartdataprovider.dart';
import 'package:hackathon_project/models/Providers/stock_provider.dart';
import 'package:hackathon_project/screens/main_screens/Tradescreens/Transactionpage.dart';
import 'package:hackathon_project/screens/main_screens/homescreenpages/charts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class Viewstock extends StatelessWidget {
  Viewstock(
      {super.key,
      required this.balance,
      this.exchange,
      this.name,
      this.symbol});
  String? symbol;
  String? name;
  double balance;
  String? exchange;

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context, listen: true);
    final auth = Provider.of<AuthProvider>(context, listen: true);
    final token = auth.token;

    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double boxheight = height / 8.5;
    var themecolor = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themecolor.surface,
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle tap event
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: themecolor.onPrimary,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.arrow_back_rounded,
                                size: 20, color: themecolor.onPrimary),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symbol!,
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            viewlimitText(name!),
                            style: const TextStyle(
                              color: Color(0xFF94959D),
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: themecolor.onPrimary,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Center(
                          child: Icon(Iconsax.send_2_copy,
                              size: 20, color: themecolor.onPrimary),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: themecolor.onPrimary,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Center(
                          child: Icon(Iconsax.notification_bing_copy,
                              size: 20, color: themecolor.onPrimary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //spacing: 12,
                        children: [
                          Text(
                            '\$$balance',
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 32,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // spacing: 4,
                            children: [
                              SizedBox(width: 16, height: 16, child: Stack()),
                              Text(
                                '+\$18.6',
                                style: TextStyle(
                                  color: Color(0xFF018C49),
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '(4.32%)',
                                style: TextStyle(
                                  color: Color(0xFF018C49),
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 16, height: 16, child: Stack()),
                            ],
                          ),
                          const Text(
                            'Price at close 6 Jun, 00:00, +4',
                            style: TextStyle(
                              color: Color(0xFF94959D),
                              fontSize: 12,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // spacing: 12,
                        children: [
                          Text(
                            'Nasdaq',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 16,
                              fontFamily: 'Okta Neue',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            'Market closed',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF94959D),
                              fontSize: 12,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'Opens at 6 Jun, 15:35',
                            style: TextStyle(
                              color: Color(0xFF94959D),
                              fontSize: 12,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  ////////////////////////////////////////////////////
                  // Stocklinechart(themecolor: themecolor),
                  Stocklinechart(themecolor: themecolor),
                  ////////////////////////////////////////
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(20),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.3,
                          color: themecolor.onPrimaryContainer,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        //first row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Overview',
                              style: TextStyle(
                                color: themecolor.onPrimary,
                                fontSize: 16,
                                fontFamily: 'Okta Neue',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '644.56',
                              style: TextStyle(
                                color: themecolor.onPrimary,
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Pricetile(
                                    mykey: 'Open',
                                    value: '319',
                                  ),
                                  Pricetile(mykey: 'Low', value: '319.27'),
                                  Pricetile(mykey: 'High', value: '644.56'),
                                  Pricetile(mykey: 'P/E', value: '1,000,000'),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            //////////////////////
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Pricetile(mykey: 'Volume', value: '319,000'),
                                  Pricetile(mykey: 'Avg Vol', value: '644.56'),
                                  Pricetile(
                                      mykey: 'Market', value: '1,000,000'),
                                  Pricetile(mykey: 'Ask', value: '1,000,000'),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Placed Orders',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_sharp,
                            size: 24,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
            //bottom button (buy and sell )
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: boxheight,
                decoration: BoxDecoration(
                  color: themecolor.surface,
                  // borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(111, 187, 187, 187),
                      blurRadius: 50,
                      spreadRadius: 13,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: themecolor.primaryContainer,
                          ),
                          child: Center(
                              child: Text(
                            'Sell',
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Transactionpage(
                              symbol: symbol!,
                              name: name!,
                              price: balance,
                            ),
                          )),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: themecolor.primary,
                            ),
                            child: const Center(
                                child: Text(
                              'Buy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Pricetile extends StatelessWidget {
  const Pricetile({
    super.key,
    required this.mykey,
    required this.value,
  });
  final String mykey;
  final String value;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme.onPrimary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Text(
            mykey,
            style: const TextStyle(
              color: Color(0xFF94959D),
              fontSize: 12,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: theme,
              fontSize: 12,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
