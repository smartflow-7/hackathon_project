import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/Widgets/simplestocktile.dart';
import 'package:hackathon_project/Widgets/stocktile.dart';
import 'package:hackathon_project/models/Providers/chartdataprovider.dart';
import 'package:hackathon_project/models/Providers/getallstockprovider.dart';
import 'package:hackathon_project/models/nigerian_stocks.dart';
import 'package:hackathon_project/screens/main_screens/Tradescreens/ViewStock.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  final TextEditingController _searchController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadInitialStocks();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadInitialStocks() async {
    final token = await _storage.read(key: 'auth_token');
    final stockProvider = Provider.of<AllStockProvider>(context, listen: false);

    await stockProvider.loadAllStocks(token ?? '');
  }

  void _onSearchChanged() {
    // Debounce the search to avoid excessive filtering
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final stockProvider =
          Provider.of<AllStockProvider>(context, listen: false);
      stockProvider.filterStocks(searchQuery: _searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final CHART = Provider.of<Chartdataprovider>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 25),
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Markets',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
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
                          color: colorScheme.onPrimary,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.notification_bing,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Horizontal Stock Tiles
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
              const SizedBox(height: 40),
              Consumer<AllStockProvider>(
                builder: (context, stockProvider, child) {
                  if (stockProvider.isLoading) {
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
                  }

                  if (stockProvider.error != null) {
                    return Center(child: Text('Error: ${stockProvider.error}'));
                  }

                  return Column(
                    children: [
                      // Search Field
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: ShapeDecoration(
                          color: colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: Apptheme.primary,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Iconsax.search_normal_1_copy,
                              color: Apptheme.lightgrey,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Iconsax.setting_4_copy,
                                color: Apptheme.lightgrey,
                                size: 20,
                              ),
                              onPressed: () {
                                stockProvider.filterStocks(
                                    searchQuery: _searchController.text);
                              },
                            ),
                            hintText: 'Search stocks...',
                            hintStyle: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                              height: 1.50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Market Movers Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Market movers',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_sharp,
                              size: 24,
                            ),
                          ),
                        ],
                      ),

                      // Stock List
                      if (stockProvider.filteredStocks == null ||
                          stockProvider.filteredStocks!.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Text('No stocks found'),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 50,
                          itemBuilder: (context, index) {
                            final stock = stockProvider.filteredStocks![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: InkWell(
                                splashColor:
                                    const Color.fromARGB(134, 158, 158, 158),
                                onTap: () {
                                  // CHART.changeSymbol(stock.symbol!);

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Viewstock(
                                      balance: stock.price!,
                                      name: stock.name,
                                      exchange: stock.exchange,
                                      symbol: stock.symbol,
                                    ),
                                  ));
                                },
                                child: Ink(
                                  child: Simplestocktile(
                                    currentprice:
                                        stock.price?.toStringAsFixed(2) ??
                                            'N/A',
                                    name: stock.name ?? 'Unknown',
                                    symbol: stock.symbol ?? 'N/A',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
