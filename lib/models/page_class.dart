class PageClass {
  final String svgasset;
  final String title;
  final String description;
  PageClass(
      {required this.description, required this.svgasset, required this.title});
}

List<PageClass> mypages = [
  PageClass(
      description:
          'Be one of millions of people who use mobile banking for daily transactions.',
      svgasset: 'lib/Assets/WALLET_light.svg',
      title: 'Mobile banking \nthat works'),
  PageClass(
      description:
          'Be one of millions of people who use mobile banking for daily transactions.',
      svgasset: 'lib/Assets/WALLET_light.svg',
      title: 'Sapa \nis real'),
  PageClass(
      description:
          'Be one of millions of people who use mobile banking for daily transactions.',
      svgasset: 'lib/Assets/WALLET_light.svg',
      title: 'Go woke \nor Go Broke '),
];
