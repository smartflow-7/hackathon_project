import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Add this import
import 'package:hackathon_project/Widgets/Time_buttons.dart';
import 'package:hackathon_project/Widgets/simplestocktile.dart';
import 'package:hackathon_project/Widgets/stocklinechart.dart';
import 'package:hackathon_project/models/Providers/Ai_model.dart';
import 'package:hackathon_project/models/Providers/api_service.dart';
import 'package:hackathon_project/models/Providers/chartdataprovider.dart';
import 'package:hackathon_project/models/Providers/leaderboardprovider.dart';
import 'package:hackathon_project/models/Providers/stock_provider.dart';
import 'package:hackathon_project/models/stock_model.dart';
import 'package:hackathon_project/screens/main_screens/Tradescreens/Transactionpage.dart';
import 'package:hackathon_project/screens/main_screens/homescreenpages/charts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class Viewstock extends StatefulWidget {
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
  State<Viewstock> createState() => _ViewstockState();
}

class _ViewstockState extends State<Viewstock> {
  StockData? _stockData;
  bool _isLoading = false;
  String? _error;
  String? userId; // Store the decoded user ID

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _extractUserIdFromToken();
    await _loadStockData();
    _fetchAISuggestion();
  }

  Future<void> _extractUserIdFromToken() async {
    try {
      final token = await const FlutterSecureStorage().read(key: 'auth_token');
      if (token != null) {
        // Decode the JWT token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        // Extract user ID - adjust the key based on your JWT structure
        // Common keys are: 'id', 'userId', 'user_id', 'sub', etc.
        userId = decodedToken['id']?.toString() ??
            decodedToken['userId']?.toString() ??
            decodedToken['user_id']?.toString() ??
            decodedToken['sub']?.toString();

        print('Extracted User ID: $userId');
      }
    } catch (e) {
      print('Error decoding JWT token: $e');
    }
  }

  void _fetchAISuggestion() {
    if (userId != null && widget.symbol != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<AISuggestionProvider>(context, listen: false)
            .fetchSuggestion(userId: userId!, symbol: widget.symbol!);
      });
    }
  }

  Future<void> _loadStockData() async {
    final stockProvider = Provider.of<StockProvider>(
      context,
      listen: false,
    );

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final token = await const FlutterSecureStorage().read(key: 'auth_token');
      if (token == null) {
        setState(() {
          _error = 'Authentication required';
          _isLoading = false;
        });
        return;
      }

      // First check cache
      if (widget.symbol != null &&
          stockProvider.stockCache.containsKey(widget.symbol!.toUpperCase())) {
        setState(() {
          _stockData = stockProvider.stockCache[widget.symbol!.toUpperCase()];
          _isLoading = false;
        });
        return;
      }

      // If not in cache, fetch from API
      final stockData = await stockProvider.searchStock(
        widget.symbol!,
        token,
      );

      setState(() {
        _stockData = stockData;
        _isLoading = false;
        print('Stock data loaded: $_stockData');
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context, listen: true);
    final ai = Provider.of<AISuggestionProvider>(context, listen: true);
    final auth = Provider.of<AuthProvider>(context, listen: true);
    final token = auth.token;

    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double boxheight = height / 8.5;
    var themecolor = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themecolor.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh AI suggestion with current user ID and symbol
          if (userId != null && widget.symbol != null) {
            ai.refreshSuggestion(userId: userId!, symbol: widget.symbol!);
          }
        },
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView(
                children: [
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
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
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.symbol!,
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            viewlimitText(widget.name!),
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
                          child: GestureDetector(
                            onTap: () {
                              if (ai.hasData && ai.suggestion != null) {
                                showStockDialog(
                                  context,
                                  widget.symbol!,
                                  ai.suggestion!
                                      .suggestion, // Use the AI suggestion text
                                );
                              } else if (ai.isLoading) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Loading AI suggestion...')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('No AI suggestion available')),
                                );
                              }
                            },
                            child: Icon(Iconsax.bubble_copy,
                                size: 20, color: themecolor.onPrimary),
                          ),
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
                  const SizedBox(height: 24),

                  // Add AI Suggestion Display Section
                  if (ai.hasData && ai.suggestion != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: themecolor.primaryContainer.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: themecolor.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.psychology,
                                color: themecolor.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'AI Suggestion',
                                style: TextStyle(
                                  color: themecolor.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ai.suggestion!.suggestion,
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 14,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Trades: ${ai.suggestion!.userSummary.trades}',
                                style: const TextStyle(
                                  color: Color(0xFF94959D),
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: themecolor.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  ai.suggestion!.userSummary.badge,
                                  style: TextStyle(
                                    color: themecolor.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  if (ai.isLoading)
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: themecolor.primaryContainer.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Getting AI suggestion...',
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Rest of your existing UI...
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${widget.balance}',
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 32,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  width: 16, height: 16, child: Stack()),
                              Text(
                                (_stockData?.changeAmount != null
                                    ? '\$${_stockData!.changeAmount}'
                                    : '-'),
                                style: TextStyle(
                                  color: _stockData?.isPositive == true
                                      ? const Color(0xFF018C49)
                                      : Colors.red,
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                (_stockData?.changePercent != null
                                    ? '${_stockData!.changePercent}%'
                                    : '-'),
                                style: TextStyle(
                                  color: _stockData?.isPositive == true
                                      ? const Color(0xFF018C49)
                                      : Colors.red,
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                  width: 16, height: 16, child: Stack()),
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
                  const SizedBox(height: 40),

                  // Continue with rest of your existing widgets...
                  Stocklinechart(
                    themecolor: themecolor,
                    symbol: widget.symbol!,
                  ),
                  const SizedBox(height: 40),

                  // Overview Container and other existing widgets...
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
                              widget.balance.toString(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Pricetile(
                                    mykey: 'Open',
                                    value: _stockData?.open != null
                                        ? _stockData!.open.toString()
                                        : '-',
                                  ),
                                  Pricetile(
                                    mykey: 'Low',
                                    value: _stockData?.low != null
                                        ? _stockData!.low.toString()
                                        : '-',
                                  ),
                                  Pricetile(
                                    mykey: 'High',
                                    value: _stockData?.high != null
                                        ? _stockData!.high.toString()
                                        : '-',
                                  ),
                                  const Pricetile(
                                      mykey: 'P/E', value: '1,000,000'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 40),
                            const Expanded(
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
                  const SizedBox(height: 40),
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
                  const SizedBox(height: 200),
                ],
              ),
            ),
            // Bottom buy/sell buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: boxheight,
                decoration: BoxDecoration(
                  color: themecolor.surface,
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
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Transactionpage(
                              symbol: widget.symbol!,
                              name: widget.name!,
                              price: widget.balance,
                              isbuy: false,
                            ),
                          )),
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
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Transactionpage(
                              symbol: widget.symbol!,
                              name: widget.name!,
                              price: widget.balance,
                              isbuy: true,
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

// Rest of your existing classes remain the same...
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

void showStockDialog(BuildContext context, String symbol, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(symbol),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

// Add this helper function if it doesn't exist
String viewlimitText(String text) {
  if (text.length <= 20) return text;
  return '${text.substring(0, 20)}...';
}
