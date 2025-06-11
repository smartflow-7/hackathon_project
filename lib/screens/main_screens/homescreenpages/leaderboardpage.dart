import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/Widgets/ranktile.dart';
import 'package:hackathon_project/models/Providers/leaderboardprovider.dart';
import 'package:hackathon_project/models/Providers/stock_provider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class Leaderboardpage extends StatefulWidget {
  const Leaderboardpage({super.key});

  @override
  State<Leaderboardpage> createState() => _LeaderboardpageState();
}

class _LeaderboardpageState extends State<Leaderboardpage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaderboardProvider>(context, listen: false).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double width = size.width;
    // double height = size.height;
    /// print('Leaderboard Page Width: $width, Height: $height');
    var themecolor = Theme.of(context).colorScheme;
    final leaderProvider = Provider.of<LeaderboardProvider>(context);
    final value = Provider.of<StockProvider>(context);
    return ListView(
      children: [
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Leaderboard',
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
                    Iconsax.info_circle_copy,
                    size: 20,
                    color: themecolor.onPrimary,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
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
                    Iconsax.medal_copy,
                    size: 20,
                    color: themecolor.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 246,
            decoration: BoxDecoration(
                color: themecolor.onPrimary,
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Assets',
                    style: TextStyle(
                      color: themecolor.primaryContainer,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        value.balance.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                          color: themecolor.primaryContainer,
                        ),
                      ),
                      Text(
                        '4.5%',
                        style: TextStyle(
                          color: themecolor.primaryContainer,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      Text(
                        '4.5%',
                        style: TextStyle(
                          color: themecolor.primaryContainer,
                        ),
                      ),
                      Text(
                        '4.5%',
                        style: TextStyle(
                          color: themecolor.primaryContainer,
                        ),
                      ),
                      Text(
                        '4.5%',
                        style: TextStyle(
                          color: themecolor.primaryContainer,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    // width: 84,
                    height: 48,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.355,
                          color: themecolor.primaryContainer,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      'Withdraw',
                      style: TextStyle(
                        color: themecolor.primaryContainer,
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 100,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Apptheme.tigerdark,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Ranking',
                        style: TextStyle(
                          color: themecolor.primary,
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '#',
                                style: TextStyle(
                                  color: themecolor.onPrimary,
                                  fontSize: 25,
                                  fontFamily: 'Okta Neue',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: leaderProvider.rank.toString(),
                                style: TextStyle(
                                  color: themecolor.onPrimary,
                                  fontSize: 25,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Task Completed',
                        style: TextStyle(
                          color: Apptheme.tigerdark,
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '2 ',
                                style: TextStyle(
                                  color: themecolor.onPrimary,
                                  fontSize: 25,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'of ',
                                style: TextStyle(
                                  color: themecolor.onPrimary,
                                  fontSize: 25,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '3',
                                style: TextStyle(
                                  color: themecolor.onPrimary,
                                  fontSize: 25,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 81,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFC9CACE),
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Ascend',
                        style: TextStyle(
                          color: themecolor.onPrimary,
                          fontSize: 10,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rankings',
                    style: TextStyle(
                      color: themecolor.onPrimary,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Gold tier',
                    style: TextStyle(
                      color: Color(0xFFFFDD00),
                      fontSize: 12,
                      fontFamily: 'Okta Neue',
                      fontWeight: FontWeight.w400,
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
                  child: Icon(
                    Iconsax.ranking_1_copy,
                    size: 20,
                    color: themecolor.onPrimary,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
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
                    Iconsax.candle_2_copy,
                    size: 20,
                    color: themecolor.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Consumer<LeaderboardProvider>(builder: (context, provider, child) {
          switch (provider.state) {
            case LeaderboardState.loading:
              return Column(
                children: List.generate(
                    8,
                    (index) => const Ranktile(
                          balance: 3131313,
                          id: 'gafafada',
                          index: 2,
                          name: 'fadadadada',
                        ).redacted(context: context, redact: true)),
              );

            // return Container(
            //   height: 50,
            //   color: Colors.green,
            // );
            case LeaderboardState.loaded:
              print(provider.users[0].name);
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.users.length,
                itemBuilder: (context, index) {
                  final players = provider.users[index];
                  return Ranktile(
                      balance: players.totalBalance,
                      id: players.id,
                      index: index,
                      name: players.name);
                },
              );
            //// TODO: Handle this case.
            case LeaderboardState.error:
              return Container(
                height: 50,
                color: Colors.red,
              );
            // TODO: Handle this case.
            case LeaderboardState.refreshing:
              return Column(
                children: List.generate(
                    8,
                    (index) => const Ranktile(
                          balance: 3131313,
                          id: 'gafafada',
                          index: 2,
                          name: 'fadadadada',
                        ).redacted(context: context, redact: true)),
              );
            // TODO: Handle this case.
          }
        }),
        const SizedBox(
          height: 200,
        ),
      ],
    );
  }
}
