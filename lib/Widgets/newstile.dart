import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

class Newstile extends StatelessWidget {
  const Newstile({
    super.key,
    required this.description,
    required this.heading,
    required this.image,
    required this.time,
    this.isLoading = false, // Add loading state parameter
  });

  final String image;
  final String description;
  final String heading;
  final String time;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        child: Ink(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  image: isLoading
                      ? null
                      : DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                  color: isLoading ? Colors.grey[300] : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ).redacted(
                context: context,
                redact: isLoading,
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLoading ? 'Loading category...' : heading,
                      style: const TextStyle(
                        color: Color(0xFF94959D),
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                      ),
                    ).redacted(
                      context: context,
                      redact: isLoading,
                    ),
                    const SizedBox(height: 0.4),
                    Text(
                      isLoading
                          ? 'Loading news description that would normally be quite long and span multiple lines...'
                          : description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: themecolor.onPrimary,
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                      ),
                    ).redacted(
                      context: context,
                      redact: isLoading,
                    ),
                    const Spacer(),
                    Text(
                      isLoading ? '2 hours ago' : time,
                      style: const TextStyle(
                        color: Color(0xFF94959D),
                        fontSize: 10,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                      ),
                    ).redacted(
                      context: context,
                      redact: isLoading,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Alternative: Create a separate placeholder widget
class NewstilePlaceholder extends StatelessWidget {
  const NewstilePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Ink(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: ShapeDecoration(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ).redacted(context: context, redact: true),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Loading category...',
                    style: TextStyle(
                      color: Color(0xFF94959D),
                      fontSize: 12,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ).redacted(context: context, redact: true),
                  const SizedBox(height: 0.4),
                  Text(
                    'Loading news description ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                    ),
                  ).redacted(context: context, redact: true),
                  const Spacer(),
                  const Text(
                    '2 hours ago',
                    style: TextStyle(
                      color: Color(0xFF94959D),
                      fontSize: 10,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ).redacted(context: context, redact: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage example:
class NewsListExample extends StatelessWidget {
  const NewsListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        // Show placeholders while loading
        NewstilePlaceholder(),
        NewstilePlaceholder(),
        NewstilePlaceholder(),

        // Or use the modified Newstile with isLoading parameter
        Newstile(
          image: '',
          heading: '',
          description: '',
          time: '',
          isLoading: true,
        ),
      ],
    );
  }
}
