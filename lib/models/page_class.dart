class PageClass {
  final String svgasset;
  final String title;
  final String description;
  PageClass(
      {required this.description, required this.svgasset, required this.title});
}

PageClass page1 = PageClass(
    description:
        'Zero risk, no scams! Master the NSE with ₦1M virtual cash and practice buying real Nigerian stocks.',
    svgasset: 'lib/assets/WALLET_light.svg',
    title: 'Welcome to StockUp');

PageClass page2 = PageClass(
    description:
        'Be one of millions of people who use mobile banking for daily transactions.',
    svgasset: 'lib/assets/second.svg',
    title: 'Trade Like It’s Real (But It’s Not)');
PageClass page3 = PageClass(
    description:
        'Earn badges, crush challenges, and dodge scams with AI-powered tips—all while trading virtual cash risk-free!',
    svgasset: 'lib/assets/third.svg',
    title: 'Unlock Your Inner Stock Guru ');
List<PageClass> mypages = [
  page1,
  page2,
  page3,
];
