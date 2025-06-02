import 'package:flutter/material.dart';
import 'package:hackathon_project/components/Apptheme.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  // final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 24,
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Hello There'), Text('name')],
                )
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 24,
                ),
                SizedBox(
                  width: 16,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 24,
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
      ],
    );
  }
}
