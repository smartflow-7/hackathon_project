import 'package:flutter/material.dart';
import 'package:hackathon_project/components/newstile.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              width: 354,
              height: 200,
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
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://media.istockphoto.com/id/499785795/photo/analyzing-electronic-document.jpg?s=612x612&w=0&k=20&c=PYrD8albkJQHy_sgjIFCEScjfe-4DTylouvEL-oHfOU="),
                  fit: BoxFit.cover,
                ),
              ),
            ),

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
            Column(
              children: List.generate(8, (index) => const Newstile()),
            ),
          ],
        ),
      ),
    );
  }
}
