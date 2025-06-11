// import 'package:flutter/material.dart';
// import 'package:hackathon_project/models/Providers/stock_provider.dart';
// import 'package:hackathon_project/models/stock_model.dart';
// import 'package:provider/provider.dart';

// class StockSearchWidget extends StatefulWidget {
//   final String token;

//   const StockSearchWidget({super.key, required this.token});

//   @override
//   // ignore: library_private_types_in_public_api
//   _StockSearchWidgetState createState() => _StockSearchWidgetState();
// }

// class _StockSearchWidgetState extends State<StockSearchWidget> {
//   final TextEditingController _searchController = TextEditingController();
//   late Future<List<StockData>> _stocksFuture;

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_handleSearchChange);
//     _stocksFuture = _fetchAllStocks();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<List<StockData>> _fetchAllStocks() async {
//     final provider = Provider.of<StockProvider>(context, listen: false);
//     return await provider.loadAllStocks(widget.token);
//   }

//   Future<List<StockData>> _searchStock(String query) async {
//     final provider = Provider.of<StockProvider>(context, listen: false);
//     final stock = await provider.searchStock(query, widget.token);
//     return stock != null ? [stock] : [];
//   }

//   void _handleSearchChange() {
//     setState(() {
//       if (_searchController.text.isEmpty) {
//         _stocksFuture = _fetchAllStocks();
//       } else {
//         _stocksFuture = _searchStock(_searchController.text);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search stocks...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder<List<StockData>>(
//               future: _stocksFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Center(child: Text('No stocks found'));
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final stock = snapshot.data![index];
//                     return ListTile(
//                       title: Text(stock.symbol),
//                       subtitle:
//                           Text('\$${stock.currentPrice.toStringAsFixed(2)}'),
//                       trailing: IconButton(
//                         icon: Icon(
//                           Provider.of<StockProvider>(context)
//                                   .isWatching(stock.symbol)
//                               ? Icons.star
//                               : Icons.star_border,
//                         ),
//                         onPressed: () {
//                           Provider.of<StockProvider>(context, listen: false)
//                               .toggleWatchlist(stock.symbol);
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
