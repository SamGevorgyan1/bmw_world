import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace:
                const FlexibleSpaceBar(background: _NewsImageTitleWidget()),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 30),
                    _NewsContentWidget(),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsContentWidget extends StatelessWidget {
  const _NewsContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<NewsItemData> newsItems = NewsItemData.fakeNewsItemData();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Expanded(
        child: Column(
          children: [
            const _MainNewsWidget(),
            const SizedBox(height: 30),
            for (var item in newsItems)
              _NewsItemWidget(
                imageUri: item.imageUri,
                title: item.title,
                contnet: item.content,
              ),
          ],
        ),
      ),
    );
  }
}

class _NewsItemWidget extends StatelessWidget {
  final String imageUri;
  final String title;
  final String contnet;
  const _NewsItemWidget(
      {Key? key,
      required this.imageUri,
      required this.title,
      required this.contnet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(
            imageUri,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          contnet,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _MainNewsWidget extends StatelessWidget {
  const _MainNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "One of the world’s most sustainable cities. One of skateboarding’s most enduring icons. The new BMW iX1. Join us for a tour of what to do in Copenhagen’s hottest neighborhood, as local hero Rune Glifberg, Olympian, professional skateboarder and architect, takes us on a tour of his own local heroes and the neighbourhood they help bring to life. ",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "26 January 2023",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}

class _NewsImageTitleWidget extends StatefulWidget {
  const _NewsImageTitleWidget({Key? key}) : super(key: key);

  @override
  State<_NewsImageTitleWidget> createState() => _NewsImageTitleWidgetState();
}

class _NewsImageTitleWidgetState extends State<_NewsImageTitleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );

    _controller.repeat(reverse: true, period: const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/automotive-life/Norrebro/Norrebro-01-stage-m.jpg?imwidth=768",
          ),
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 300,
            left: 20,
            child: SizedBox(
              width: 300,
              child: Text(
                "Discovering Nørrebro with Rune Glifberg and the BMW iX1",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -20 * _animation.value),
                      child: const Icon(
                        Icons.arrow_upward,
                        size: 30,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                const SizedBox(
                    width: 5), // Adjust the spacing between the icon and text
                const Text(
                  "10 min reading time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class NewsItemData {
  final String title;
  final String content;
  final String imageUri;

  NewsItemData(this.title, this.content, this.imageUri);

  static List<NewsItemData> fakeNewsItemData() {
    return [
      NewsItemData(
        "A true BMW lover ",
        "Broad-grinned, skunk-haired, Olympian skateboarder and Copenhagen insider Rune Glifberg is in a good mood, and some of that is down to BMW. He’s got the keys of the new BMW iX1 in his hand and is ready to explore the hippest spots in his favourite city.",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/automotive-life/Norrebro/Norrebro-02-media-hd.jpg?imwidth=768",
      ),
      NewsItemData(
        "Psyche Organic & Psyche Organic Café ",
        "A few streets from Curbside Stories, Jægersborggade is the epicentre of hip Nørrebro, named the ‘World’s Coolest Neighborhood’ in 2021 by Time Out. Lined with independent shops and eateries, handmade knits hang outside shops, geraniums fall from a zinc trough next to a tree trunk decorated in bright striped yarn, and there’s creative flair in the air.",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/automotive-life/Norrebro/Norrebro-05-media-hd-m.jpg?imwidth=768",
      ),
    ];
  }
}
