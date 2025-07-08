import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/Widgets/edutile.dart';
import 'package:hackathon_project/Widgets/newstile.dart';
import 'package:hackathon_project/models/Providers/api_service.dart';
import 'package:hackathon_project/models/Providers/news_service.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

import '../logic/Date_time_format.dart';

class Educationalcontent extends StatelessWidget {
  const Educationalcontent({super.key});

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
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
                      const Text(
                        'Stockpreneur',
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
                      child: Icon(Iconsax.bubble_copy,
                          size: 20, color: themecolor.onPrimary),
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
              const SizedBox(
                height: 32,
              ),
              const SizedBox(width: 16),
              Container(
                height: 172,
                decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Want a 2-minute lesson on \nshort-selling before you jump in?',
                        style: TextStyle(
                            // color: theme,
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w900),
                      ),
                      const Spacer(),
                      Container(
                        width: 113,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.black,
                        ),
                        child: const Center(
                            child: Text(
                          'Take Action',
                          style: TextStyle(
                            color: Colors.yellowAccent,
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
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'What we all want to know',
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 264,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Edutile(
                        title: courses[index].title ?? '',
                        Description: courses[index].description ?? '',
                        inageurl: courses[index].imageurl,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Other (unrelated) Stuff',
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
              const SizedBox(
                height: 20,
              ),
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
                      ],
                    );
                  } else if (newsProvider.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${newsProvider.errorMessage}'),
                          ElevatedButton(
                            onPressed: () => newsProvider.refreshNews(
                                token: 'your_token_here'),
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
                      itemCount: 5,
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
            ],
          ),
        ),
      ),
    );
  }
}
