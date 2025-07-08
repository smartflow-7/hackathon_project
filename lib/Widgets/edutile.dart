import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

class Edutile extends StatelessWidget {
  const Edutile(
      {super.key,
      required this.description,
      required this.title,
      required this.inageurl});
  final String title;
  final String description;
  final String? inageurl;

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    return Container(
      width: 262,
      height: 251,
      color: const Color.fromARGB(16, 193, 193, 193),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            // width: double.infinity,
            // height: 160,
            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 26, 25, 25),
            //   borderRadius: BorderRadius.circular(11),
            // ),
            borderRadius: BorderRadius.circular(11),
            child: CachedNetworkImage(
              width: double.infinity,
              height: 160,
              imageUrl: inageurl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(11),
                ),
              ).redacted(context: context, redact: true),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy',
                fontSize: 16,
                color: themecolor.onPrimary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class LargeEdutile extends StatelessWidget {
  final String description;
  final String title;
  final String? inageurl;

  const LargeEdutile({
    super.key,
    required this.description,
    required this.title,
    required this.inageurl,
  });

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      //height: 251,
      color: const Color.fromARGB(16, 193, 193, 193),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            // width: double.infinity,
            // height: 160,
            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 26, 25, 25),
            //   borderRadius: BorderRadius.circular(11),
            // ),
            borderRadius: BorderRadius.circular(11),
            child: CachedNetworkImage(
              width: double.infinity,
              height: 160,
              imageUrl: inageurl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(11),
                ),
              ).redacted(context: context, redact: true),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy',
                fontSize: 20,
                color: themecolor.onPrimary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class educontent {
  String? title;
  String? description;
  String? imageurl;
  educontent(this.description, this.title, this.imageurl);
}

List<educontent> courses = [
  educontent(
      'This beginner course explains the basics of stocks',
      'What is stocks',
      'https://media.istockphoto.com/id/1290864946/photo/e-learning-education-concept-learning-online.jpg?b=1&s=612x612&w=0&k=20&c=6wbE8yYtBdOmwesNj0f3Int-fk9mEfBFiaFgN2kdC58='),
  educontent(
      'This course explains the basics of dividend and how they work',
      'What are Dividend?',
      'https://plus.unsplash.com/premium_photo-1682309799578-6e685bacd4e1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW52ZXN0bWVudHxlbnwwfHwwfHx8MA%3D%3D'),
  educontent(
      'Learn the fundamentals of bonds and fixed-income investments',
      'Understanding Bonds',
      'https://img.freepik.com/premium-photo/bond-text-wooden-cube-blocks-with-coins-suggests-focus-investment-bonds-financial-stability-diversification-assets_384017-8407.jpg?ga=GA1.1.810705355.1738080835&semt=ais_hybrid&w=740'),
  educontent(
      'Master the art of creating and managing investment portfolios',
      'Portfolio Management Basics',
      'https://www.shutterstock.com/image-photo/inscription-bonds-next-american-dollars-260nw-2264579439.jpg'),
  educontent(
      'Discover different mutual fund types and investment strategies',
      'Introduction to Mutual Funds',
      'https://img.freepik.com/free-vector/business-stock-market-background-with-shiny-growth-arrow_1017-53572.jpg?ga=GA1.1.810705355.1738080835&semt=ais_hybrid&w=740'),
  educontent(
      'Learn how to analyze company financial statements effectively',
      'Financial Statement Analysis',
      'https://img.freepik.com/free-photo/person-office-analyzing-checking-finance-graphs_23-2150377127.jpg?ga=GA1.1.810705355.1738080835&semt=ais_hybrid&w=740'),
  educontent(
      'Understand market trends and technical analysis indicators',
      'Technical Analysis Fundamentals',
      'https://img.freepik.com/free-photo/market-trends-concept-top-view_23-2150372414.jpg?ga=GA1.1.810705355.1738080835&semt=ais_hybrid&w=740'),
  educontent(
      'Learn about risk assessment and diversification strategies',
      'Risk Management in Investing',
      'https://img.freepik.com/premium-vector/risk-speedometer-risk-gauge-icon-high-risk-meter_123447-5855.jpg?ga=GA1.1.810705355.1738080835&semt=ais_hybrid&w=740'),
  educontent(
      'Understand different trading strategies and market timing',
      'Trading Strategies for Beginners',
      'https://img.freepik.com/premium-photo/stock-market-investor-by-using-smartphone_941742-15698.jpg?ga=GA1.1.810705355.1738080835&semt=ais_hybrid&w=740'),
  educontent(
      'Explore real estate investment trusts and property investing',
      'Real Estate Investment Basics',
      'https://img.freepik.com/free-photo/real-estate-sector_23-2151925478.jpg?ga=GA1.1.810705355.1738080835&semt=ais_hybrid&w=740'),
  educontent(
      'Learn about cryptocurrency fundamentals and blockchain technology',
      'Introduction to Cryptocurrency',
      'https://img.freepik.com/free-photo/closeup-golden-bitcoins-dark-reflective-surface-histogram-decreasing-crypto_1268-19910.jpg?ga=GA1.1.810705355.1738080835&semt=ais_hybrid&w=740')
];
