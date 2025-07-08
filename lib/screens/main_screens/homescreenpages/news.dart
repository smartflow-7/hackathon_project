import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/Widgets/newstile.dart';
import 'package:hackathon_project/logic/Date_time_format.dart';
import 'package:hackathon_project/models/Providers/news_service.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    super.initState();
    // Fetch data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await const FlutterSecureStorage()
          .read(key: 'auth_token'); // Replace with actual token
      Provider.of<NewsProvider>(context, listen: false).fetchAllNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    // final portfolioValue = stockProvider.portfolioValue;
    Size size = MediaQuery.of(context).size;
    // double width = size.width;
    double height = size.height;
    final contheight = size.height / 4.5;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Consumer<NewsProvider>(builder: (context, newsProvider, child) {
                return Container(
                  width: double.infinity,
                  height: contheight,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.50, -0.00),
                      end: Alignment(0.50, 1.00),
                      colors: [
                        Color.fromARGB(61, 0, 0, 0),
                        Color.fromARGB(153, 0, 0, 0)
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(newsProvider
                              .allNews?.news?.first.image ??
                          'https://images.africanfinancials.com/ng-dangce-logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        Text(
                          newsProvider.allNews?.news?.first.source ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          newsProvider.allNews?.news?.first.headline ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              getRelativeTimetimestamp(
                                  newsProvider.allNews?.news?.first.datetime ??
                                      0),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ).redacted(context: context, redact: newsProvider.isLoading);
              }),

              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 64,
                color: themecolor.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://images.africanfinancials.com/ng-dangce-logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        children: [
                          SizedBox(
                            width: 41,
                            child: Text(
                              'DNGTE',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          //    SizedBox(height: 4),
                          Text(
                            'Dangote',
                            style: TextStyle(
                              color: Color(0xFF94959D),
                              fontSize: 10,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 85,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.6,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            'Change',
                            style: TextStyle(
                              color: themecolor.onPrimary,
                              fontSize: 12,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
              /////////////////////
              ///
              const SizedBox(
                height: 20,
              ),
              // Column(
              //   children: List.generate(8, (index) => const Newstile()),
              // ),

              Consumer<NewsProvider>(
                builder: (context, newsProvider, child) {
                  if (newsProvider.isLoading) {
                    return const Column(
                      children: [
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
                        NewstilePlaceholder(),
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
                      itemCount: newsProvider.allNews!.news?.length ?? 0,
                      itemBuilder: (context, index) {
                        final mynews = newsProvider.allNews!.news![index];
                        return Newstile(
                          heading: mynews.source ?? '',
                          image: mynews.image ?? '',
                          description: mynews.headline ?? '',
                          time: getRelativeTimetimestamp(mynews.datetime ?? 0),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
