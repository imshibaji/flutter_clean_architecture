import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/model.dart';
import '../../providers/news_provider.dart';
import '../../widgets/day_night_switch.dart';
import '../../widgets/menu_buttons.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final TextEditingController _controller =
      TextEditingController(text: 'Kolkata');
  NewsProvider? np;

  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NewsProvider>(context, listen: false);
    np.search(_controller.text);
    return Scaffold(
      appBar: AppBar(
        title: searchBar(np),
        leading: const Center(
          child: Text(
            'News Area',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [DayNightSwitch(), MenuButtons()],
      ),
      body: Center(
        child: Column(
          children: [newsDisplay()],
        ),
      ),
      // bottomNavigationBar: const BottomBar(),
    );
  }

  SizedBox searchBar(NewsProvider np) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Use Search Topics',
        ),
        controller: _controller,
        onChanged: (val) {
          np.search(val);
        },
      ),
    );
  }

  Expanded newsDisplay() {
    return Expanded(
      child: Consumer<NewsProvider>(
        builder: (_, np, __) {
          if (np.isLoading == false) {
            return const Center(
              child: Text('News data loading....'),
            );
          } else if (np.newsResponse.status == 'ok') {
            List<Article>? articles = np.newsResponse.articles!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) => ListTile(
                style: ListTileStyle.drawer,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: (articles[index].media != null)
                            ? Image.network(articles[index].media!)
                            : Container(),
                      ),
                      Text('News ${index + 1}: ${articles[index].title!}'),
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    children: [
                      Text(articles[index].summary!),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Published At: ${articles[index].publishedDate!}'),
                          ElevatedButton(
                            onPressed: () {
                              log(articles[index].link!);
                            },
                            child: const Text('View Full News'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                dense: true,
                shape: Border.all(width: 0.5),
              ),
            );
          } else {
            return const Center(
              child: Text('No news data fetched'),
            );
          }
        },
      ),
    );
  }
}
