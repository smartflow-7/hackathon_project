// ignore: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/Widgets/simplestocktile.dart';
import 'package:hackathon_project/models/Providers/stock_provider.dart';
import 'package:hackathon_project/screens/main_screens/Tradescreens/sucessfull.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class Transactionpage extends StatefulWidget {
  const Transactionpage(
      {super.key,
      required this.name,
      required this.price,
      required this.symbol,
      required this.isbuy});
  final String symbol;
  final String name;
  final double price;
  final bool isbuy;

  @override
  State<Transactionpage> createState() => _TransactionpageState();
}

class _TransactionpageState extends State<Transactionpage> {
  final TextEditingController _controller = TextEditingController();
  double result = 0.0;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    String text = _controller.text;
    if (text.isNotEmpty) {
      double? number = double.tryParse(text);
      if (number != null) {
        setState(() {
          result = number * widget.price;
        });
      }
    } else {
      setState(() {
        result = 0.0;
        //  print(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double boxheight = height / 8.5;
    var themecolor = Theme.of(context).colorScheme;
    final value = Provider.of<StockProvider>(context);
    // final Auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<StockProvider>(builder: (context, my, child) {
        return SafeArea(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(
                          widget.isbuy ? 'Buy Stocks' : 'Sell ssStocks',
                          style: TextStyle(
                            color: themecolor.onPrimary,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
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
                            child: Icon(Iconsax.notification_bing_copy,
                                size: 20, color: themecolor.onPrimary),
                          ),
                        ),
                      ],
                    ),
                    ////////////////////////////////////////////////////////////////
                    const SizedBox(
                      height: 23,
                    ),

                    ///
                    ///
                    ///
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.symbol,
                              style: TextStyle(
                                color: themecolor.onPrimary,
                                fontSize: 32,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              viewlimitText(widget.name),
                              style: const TextStyle(
                                color: Color(0xFF94959D),
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          //spacing: 12,
                          children: [
                            Text(
                              '\$${widget.price}',
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
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    SizedBox(
                      height: 144,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 72,
                                decoration: const ShapeDecoration(
                                  //  color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: Color(0xFF94959D),
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Value',
                                        style: TextStyle(
                                          color: Color(0xFF94959D),
                                          fontSize: 16,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        result.toString(),
                                        style: TextStyle(
                                          color: themecolor.onPrimary,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 72,
                                decoration: const ShapeDecoration(
                                  //color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: Color(0xFF94959D),
                                    ),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16)),
                                  ),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Quantity",
                                          style: TextStyle(
                                            color: Color(0xFF94959D),
                                            fontSize: 16,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: _controller,
                                            style: TextStyle(
                                              color: themecolor.onPrimary,
                                              fontSize: 16,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly, // Only digits
                                            ],
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: ShapeDecoration(
                                  color: themecolor.surface,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: themecolor.onPrimary,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Iconsax.arrow_3,
                                      size: 20, color: themecolor.onPrimary),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 72,
                        // color: Colors.green,
                        decoration: ShapeDecoration(
                          color: themecolor.primaryContainer,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Limit Price',
                                style: TextStyle(
                                  color: Color(0xFF94959D),
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '127',
                                style: TextStyle(
                                  color: themecolor.onPrimary,
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 72,
                        // color: Colors.green,
                        decoration: ShapeDecoration(
                          color: themecolor.primaryContainer,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Duration',
                                    style: TextStyle(
                                      color: Color(0xFF94959D),
                                      fontSize: 16,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Day',
                                    style: TextStyle(
                                      color: themecolor.onPrimary,
                                      fontSize: 16,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                              const Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 72,
                        // color: Colors.green,
                        decoration: ShapeDecoration(
                          color: themecolor.primaryContainer,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Market Hours',
                                    style: TextStyle(
                                      color: Color(0xFF94959D),
                                      fontSize: 16,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'All',
                                    style: TextStyle(
                                      color: themecolor.onPrimary,
                                      fontSize: 16,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                              const Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 72,
                        // color: Colors.green,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Estimated Cost',
                                  style: TextStyle(
                                    color: Color(0xFF94959D),
                                    fontSize: 16,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  result.toString(),
                                  style: TextStyle(
                                    color: themecolor.onPrimary,
                                    fontSize: 16,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Funds Available',
                                  style: TextStyle(
                                    color: Color(0xFF94959D),
                                    fontSize: 16,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  value.balance.toStringAsFixed(3),
                                  style: TextStyle(
                                    color: themecolor.onPrimary,
                                    fontSize: 16,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    )
                  ],
                ),
              ),

              //////////////////////// BOTTOM BAR  ////////////////////////////////////
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: InkWell(
                      splashColor: Colors.blue,
                      onTap: _isLoading ? null : () => _executeTrade(my),
                      child: Ink(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: themecolor.primary,
                          ),
                          child: Center(
                            child: Text(
                              'Place Order',
                              style: TextStyle(
                                color: themecolor.primaryContainer,
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ////////////////////////////////////////////////////////////////////////////////////
            ],
          ),
        );
      }),
    );
  }

  // Alternative approach using showDialog for loading
  Future<void> _executeTrade(StockProvider stockProvider) async {
    final quantity = int.tryParse(_controller.text);
    if (quantity == null || quantity <= 0) {
      setState(() {
        _errorMessage = 'Please enter a valid quantity';
      });
      debugPrint(_errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Apptheme.primary,
          content: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.white, fontFamily: 'Gilroy'),
          ),
        ),
      );
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Apptheme.primary,
          ),
        );
      },
    );

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await const FlutterSecureStorage().read(key: 'auth_token');
      if (token == null) {
        Navigator.of(context).pop(); // Close loading dialog
        setState(() {
          _isLoading = false;
          _errorMessage = 'Authentication error';
        });
        debugPrint(_errorMessage);
        return;
      }

      final result = widget.isbuy
          ? await stockProvider.buyStock(
              symbol: widget.symbol,
              quantity: quantity,
              token: token,
            )
          : await stockProvider.sellStock(
              symbol: widget.symbol,
              quantity: quantity,
              token: token,
            );

      Navigator.of(context).pop(); // Close loading dialog

      if (result['success'] == true) {
        // Navigate to success screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Sucessfull(
              symbol: widget.symbol,
              name: widget.name,
            ),
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              result['message'] ?? 'Transaction failed',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
        setState(() {
          _errorMessage = result['message'];
        });
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close loading dialog
      debugPrint('Error during trade execution: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'An error occurred during the transaction',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      setState(() {
        _errorMessage = 'An error occurred during the transaction';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
