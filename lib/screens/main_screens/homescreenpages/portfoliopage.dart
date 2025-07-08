import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/Widgets/simplestocktile.dart';
import 'package:hackathon_project/models/Providers/api_service.dart';
import 'package:hackathon_project/models/Providers/stock_provider.dart';
import 'package:hackathon_project/screens/main_screens/Tradescreens/ViewStock.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class Portfoliopage extends StatelessWidget {
  const Portfoliopage({super.key});

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    // final leaderProvider = Provider.of<LeaderboardProvider>(context);
    final value = Provider.of<StockProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: themecolor.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Portfolio',
                  style: TextStyle(
                    color: themecolor.onPrimary,
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w700,
                  ),
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
                    child: Icon(
                      Iconsax.more,
                      size: 20,
                      color: themecolor.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 163,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Assets',
                      style: TextStyle(
                        color: Color(0xFF94959D),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\$ ',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                  color: themecolor.onPrimary,
                                ),
                              ),
                              TextSpan(
                                text:
                                    value.balance.toStringAsFixed(3).toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w800,
                                  color: themecolor.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '4.5%',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Asset rate',
                              style: TextStyle(
                                color: Color(0xFF94959D),
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            //    SizedBox(height: 4),
                            // Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  Iconsax.arrow_up_1,
                                  size: 16,
                                  color: Color(0xFF018C49),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  value.percentageChange,
                                  style: const TextStyle(
                                    color: Color(0xFF018C49),
                                    fontSize: 12,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Max value',
                              style: TextStyle(
                                color: Color(0xFF94959D),
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            //    SizedBox(height: 4),
                            // Spacer(),
                            Text(
                              value.balance.toStringAsFixed(3).toString(),
                              style: TextStyle(
                                color: themecolor.onPrimary,
                                fontSize: 12,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Min value',
                              style: TextStyle(
                                color: Color(0xFF94959D),
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            //    SizedBox(height: 4),
                            // Spacer(),
                            Text(
                              value.balance.toStringAsFixed(3).toString(),
                              style: TextStyle(
                                color: themecolor.onPrimary,
                                fontSize: 12,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Row(
              children: [
                Expanded(
                  child: Container(
                    //
                    // width: 84,
                    height: 48,
                    decoration: ShapeDecoration(
                      color: themecolor.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      'Withdraw',
                      style: TextStyle(
                        color: themecolor.onPrimary,
                        fontSize: 12,
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
                  child: Container(
                    // width: 84,
                    height: 48,
                    decoration: ShapeDecoration(
                      color: themecolor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      'Deposit',
                      style: TextStyle(
                        color: themecolor.primaryContainer,
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My watchlist',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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
            Consumer<StockProvider>(builder: (context, provider, child) {
              if (provider.isLoading) {
                return Column(
                  children: List.generate(
                      8,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 14.0),
                            child: const Simplestocktile(
                              currentprice: '2223',
                              symbol: '2222',
                              name: 'fadadadada',
                            ).redacted(context: context, redact: true),
                          )),
                );
              } else if (provider.error != null) {
                return TextButton(
                  onPressed: () {
                    provider.refreshPortfolio(authProvider.token ?? '');
                  },
                  child: const Text('retry'),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.portfolio.length,
                  itemBuilder: (context, index) {
                    final stock = provider.portfolio[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: InkWell(
                        splashColor: const Color.fromARGB(134, 158, 158, 158),
                        onTap: () {
                          // CHART.changeSymbol(stock.symbol!);

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Viewstock(
                              balance: stock.buyPrice,
                              name: stock.symbol,
                              exchange: 'NASDAC',
                              symbol: stock.symbol,
                            ),
                          ));
                        },
                        child: Ink(
                          child: Simplestocktile(
                            currentprice: stock.buyPrice.toStringAsFixed(3),
                            name: stock.symbol ?? 'Unknown',
                            symbol: stock.symbol ?? 'N/A',
                            units: stock.quantity,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
