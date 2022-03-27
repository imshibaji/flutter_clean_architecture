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
          children: [newsDisplay(context)],
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

  Expanded newsDisplay(BuildContext context) {
    return Expanded(
      child: Consumer<NewsProvider>(
        builder: (_, np, __) {
          if (np.isLoading == false) {
            return const Center(
              child: Text('News data loading....'),
            );
          } else if (np.newsResponse.status == 'ok') {
            List<Article>? articles = np.newsResponse.articles!;
            return GridView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: articles.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (articles[index].media != null)
                          ? Flexible(
                              child: Image.network(articles[index].media!))
                          : Container(),
                      Text(
                        'News ${index + 1}: ' + articles[index].title!,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(articles[index].summary!),
                      )),
                    ],
                  ),
                ),
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
