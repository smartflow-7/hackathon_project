// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/logic/Date_time_format.dart';
import 'package:hackathon_project/logic/suffix.dart';
import 'package:hackathon_project/models/Providers/api_service.dart';
import 'package:hackathon_project/Widgets/newstile.dart';
import 'package:hackathon_project/Widgets/stocktile.dart';
import 'package:hackathon_project/models/Providers/leaderboardprovider.dart';
import 'package:hackathon_project/models/Providers/news_service.dart';
import 'package:hackathon_project/models/Providers/stock_provider.dart';
import 'package:hackathon_project/models/Providers/themeprovider.dart';
import 'package:hackathon_project/models/nigerian_stocks.dart';
import 'package:hackathon_project/screens/main_screens/Learning_screens/educationalcontent.dart';
import 'package:hackathon_project/screens/main_screens/homescreenpages/portfoliopage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';
//import 'package:shimmer_animation/shimmer_animation.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  // final PageController _controller = PageController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Safely access providers after the widget is built
      //  final stockProvider =
      // final token = await const FlutterSecureStorage()
      //     .read(key: 'auth_token'); // Replace with actual token

      Provider.of<NewsProvider>(context, listen: false).fetchAllNews();
      Provider.of<StockProvider>(context, listen: false).initialize();
      // final authProvider = Provider.of<AuthProvider>(context, listen: false);

      //stockProvider.refreshPortfolio(authProvider.token ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    // final stockProvider = Provider.of<StockProvider>(context, listen: true);
    final leaderProvider =
        Provider.of<LeaderboardProvider>(context, listen: true);
    var themecolor = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context);
    // stockProvider.refreshPortfolio(userId: '', token: authProvider.token ?? '');

    final user = authProvider.user;
    final amount = user?.balance.roundToDouble().toString();
    // final portfolioValue = stockProvider.balance;
    // final portfolioValue = stockProvider.portfolioValue;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    final contheight = size.height / 5.5;
    print('Leaderboard Page Width: $width, Height: $height');

    return Consumer<StockProvider>(builder: (context, provider, child) {
      //  String change = provider.percentageChange;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => themeProvider.toggleTheme(),
                      child: Container(
                        width: 48,
                        height: 48,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwaWNvbnxlbnwwfHwwfHx8MA%3D%3D",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                          ).redacted(context: context, redact: true),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello There',
                          style: TextStyle(
                            color: Color(0xFF94959D),
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          user?.name ?? 'User',
                          style: TextStyle(
                            color: themecolor.onPrimary,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Educationalcontent(),
                        ));
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
                          child: Icon(Iconsax.lamp_charge_copy,
                              size: 20, color: themecolor.onPrimary),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle notification tap
                        // For example, navigate to a notifications page
                        authProvider.signOut();
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
                          child: Icon(Iconsax.notification_bing,
                              size: 20, color: themecolor.primary),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      // CHART.changeSymbol(stock.symbol!);

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const Portfoliopage(),
                      ));
                    },
                    child: Container(
                      height: contheight,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Apptheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Portfolio Value',
                              style: TextStyle(
                                color: themecolor.primary,
                                fontSize: 12,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '₦ ',
                                    style: TextStyle(
                                      color: themecolor.onPrimary,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: provider.portfolioValue
                                        .toStringAsFixed(3)
                                        .toString(),
                                    style: TextStyle(
                                      color: themecolor.onPrimary,
                                      fontSize:
                                          (amount != null && amount.length > 13)
                                              ? 5
                                              : width / 17.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Iconsax.arrow_up_1,
                                    size: 16, color: Colors.green),
                                const SizedBox(width: 4),
                                Text(
                                  provider.percentageChange.toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF018C49),
                                    fontSize: 12,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Today',
                                  style: TextStyle(
                                    color: Color(0xFF018C49),
                                    fontSize: 12,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Deposit(themecolor: themecolor),
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
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
                                      Icons.more_vert_outlined,
                                      size: 20,
                                      color: themecolor.onPrimary,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    height: contheight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Apptheme.tigerlight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: Apptheme.tigerdark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Center(
                              child: Icon(Iconsax.cup,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                          const Spacer(),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: '#',
                                  style: TextStyle(
                                    color: Color(0xFFFC6A03),
                                    fontSize: 20,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: getRankWithSuffix(leaderProvider.rank),
                                  style: const TextStyle(
                                    color: Color(0xFFFC6A03),
                                    fontSize: 20,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            'Keep it up!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF03050B),
                              fontSize: 12,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trending News',
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
            Consumer<NewsProvider>(
              builder: (context, newsProvider, child) {
                if (newsProvider.isLoading) {
                  return const Column(
                    children: [
                      NewstilePlaceholder(),
                      NewstilePlaceholder(),
                    ],
                  );
                } else if (newsProvider.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${newsProvider.errorMessage}'),
                        ElevatedButton(
                          onPressed: () => newsProvider.fetchAllNews(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (newsProvider.allNews == null ||
                    newsProvider.allNews!.news!.isEmpty) {
                  return const Center(child: Text('No news available'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      final mynews = newsProvider.allNews!.news![index];
                      return Newstile(
                        heading: mynews.source ?? '',
                        image: mynews.image ?? '',
                        description: mynews.summary ?? '',
                        time: getRelativeTimetimestamp(mynews.datetime ?? 0),
                      ).redacted(
                          context: context, redact: newsProvider.isLoading);
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My watchlist',
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
            SizedBox(
              height: 158,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: nigerianStocks.length,
                itemBuilder: (context, index) {
                  final nstocks = nigerianStocks[index];
                  return Stocktile(
                    name: nstocks.name,
                    price: nstocks.price,
                    symbol: nstocks.symbol,
                    sector: nstocks.sector,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      );
    });
  }
}

class Deposit extends StatelessWidget {
  const Deposit({
    super.key,
    required this.themecolor,
  });

  final ColorScheme themecolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: themecolor.primary,
      ),
      child: const Center(
          child: Text(
        'Deposit',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w600,
        ),
      )),
    );
  }
}
