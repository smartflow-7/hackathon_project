import 'package:flutter/material.dart';
import 'package:hackathon_project/Auth/api_service.dart';
import 'package:hackathon_project/components/Apptheme.dart';
import 'package:hackathon_project/components/newstile.dart';
import 'package:hackathon_project/components/stocktile.dart';
import 'package:hackathon_project/models/Providers/themeprovider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  // final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    return ListView(
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
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwaWNvbnxlbnwwfHwwfHx8MA%3D%3D"),
                        fit: BoxFit.cover,
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
                    child: Icon(Iconsax.lamp_charge_copy,
                        size: 20, color: themecolor.onPrimary),
                  ),
                ),
                const SizedBox(
                  width: 16,
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
                    child: Icon(Iconsax.notification_bing,
                        size: 20, color: themecolor.primary),
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
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
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
                              text: user?.balance.toString() ?? '0.00',
                              style: TextStyle(
                                color: themecolor.onPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Iconsax.arrow_up_1,
                              size: 16, color: Colors.green),
                          SizedBox(width: 4),
                          Text(
                            '4.32%',
                            style: TextStyle(
                              color: Color(0xFF018C49),
                              fontSize: 12,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
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
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                height: 160,
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
                          child:
                              Icon(Iconsax.cup, size: 20, color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '#',
                              style: TextStyle(
                                color: Color(0xFFFC6A03),
                                fontSize: 20,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: '127th',
                              style: TextStyle(
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
        const Newstile(),
        const Newstile(),
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              Stocktile(),
              Stocktile(),
              Stocktile(),
              Stocktile(),
              Stocktile(),
            ],
          ),
        ),
        const SizedBox(
          height: 200,
        ),
      ],
    );
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
