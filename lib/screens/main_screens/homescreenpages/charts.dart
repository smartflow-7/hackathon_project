// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/Widgets/newstile.dart';

import 'package:hackathon_project/Widgets/simplestocktile.dart';
import 'package:hackathon_project/Widgets/stocktile.dart';
import 'package:hackathon_project/models/Providers/stock_provider.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  void initState() {
    super.initState();
    // Fetch data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await const FlutterSecureStorage()
          .read(key: 'auth_token'); // Replace with actual token
      Provider.of<StockProvider>(context, listen: false)
          .searchAllStocks(token ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    final textcontroller = TextEditingController();
    // final stockProvider = Provider.of<StockProvider>(context);
    // final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Markets',
                  style: TextStyle(
                    color: themecolor.onPrimary,
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w700,
                  ),
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
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: ShapeDecoration(
                color: themecolor.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Apptheme.primary,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                onEditingComplete: () => TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: textcontroller,
                style: const TextStyle(color: Color(0xFF94959D), fontSize: 15),
                decoration: InputDecoration(
                    // labelText: 'email',
                    contentPadding: const EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Iconsax.search_normal_1_copy,
                      color: Apptheme.lightgrey,
                    ),
                    suffixIcon: const Icon(Iconsax.setting_4_copy,
                        color: Apptheme.lightgrey, size: 20),
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: themecolor.onPrimaryContainer,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    )),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Market movers',
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
            Column(
              children: List.generate(
                  8,
                  (index) => const Simplestocktile()
                      .redacted(context: context, redact: true)),
            ),
            // StockSearchWidget(
            //   token: authProvider.token ?? '',
            // ),
          ],
        ),
      ),
    ));
  }
}
