import 'package:bmw_world/generated/l10n.dart';
import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:bmw_world/ui/widgets/main/news/news_details.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blueDark,
        title: Text(
          S.of(context).news,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: _NewsListWidget(
              newsData: NewsData.getFakeNews(),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsListWidget extends StatelessWidget {
  final List<NewsData> newsData;

  const _NewsListWidget({Key? key, required this.newsData}) : super(key: key);

  void onTapItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewsDetails()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      shrinkWrap: true,
      itemCount: newsData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onTapItem(context),
          child: _NewsWidget(
              imageUri: newsData[index].imageUri,
              titleText: newsData[index].titleText,
              descriptionText: newsData[index].descriptionText),
        );
      },
    );
  }
}

class _NewsWidget extends StatelessWidget {
  const _NewsWidget(
      {Key? key,
      required this.imageUri,
      required this.titleText,
      required this.descriptionText})
      : super(key: key);

  final String imageUri;
  final String titleText;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, top: 3, bottom: 3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUri),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  width: 150,
                  child: Text(
                    descriptionText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewsData {
  final String titleText;
  final String descriptionText;
  final String imageUri;

  NewsData(this.titleText, this.descriptionText, this.imageUri);

  static List<NewsData> getFakeNews() {
    return [
      NewsData(
        "Insider’s guide",
        "Discovering Nørrebro with Rune Glifberg and the BMW iX1",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/automotive-life/Norrebro/Norrebro-01-stage-m.jpg?imwidth=768",
      ),
      NewsData(
        "Norway road trip ",
        "To the polar circle with the BMW iX ",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/sustainability/linari-2/ln2-01-stage-hd.jpg?imwidth=1280",
      ),
      NewsData(
        "Going green ",
        "Driving tomorrow today",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/Innovation/greenjoy/sgj-01-stage-hd.jpg?imwidth=1280",
      ),
      NewsData(
        "Audio column ",
        "The future of circularity ",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/sustainability/Norwegen-roadtrip/ang-01-stage-portrait.jpg?imwidth=768",
      ),
      //
      NewsData(
        "Audio column ",
        "The future of circularity ",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/sustainability/Norwegen-roadtrip/ang-01-stage-hd.jpg?imwidth=1280",
      ),
      NewsData(
        "Audio column ",
        "The future of circularity ",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/sustainability/Norwegen-roadtrip/ang-01-stage-hd.jpg?imwidth=1280",
      ),
      NewsData(
        "Audio column ",
        "The future of circularity ",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/sustainability/Norwegen-roadtrip/ang-01-stage-hd.jpg?imwidth=1280",
      ),
      NewsData(
        "Audio column ",
        "The future of circularity ",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/sustainability/Norwegen-roadtrip/ang-01-stage-hd.jpg?imwidth=1280",
      ),
      NewsData(
        "Audio column ",
        "The future of circularity ",
        "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/sustainability/Norwegen-roadtrip/ang-01-stage-hd.jpg?imwidth=1280",
      ),
    ];
  }
}
