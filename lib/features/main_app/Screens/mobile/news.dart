import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../models/model.dart';
import '../../providers/news_provider.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final TextEditingController _controller =
      TextEditingController(text: 'Software Development');

  @override
  void initState() {
    NewsProvider np = Provider.of<NewsProvider>(context, listen: false);
    np.search(_controller.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Area'),
        actions: actionsMenu(context),
      ),
      body: Center(
        child: Column(
          children: [searchBar(), newsDisplay()],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Container searchBar() {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 1.0),
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          helperText: 'Search News By Topics / Cities etc.',
          alignLabelWithHint: true,
        ),
        controller: _controller,
        onSubmitted: (val) {
          NewsProvider np = Provider.of<NewsProvider>(context, listen: false);
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
                          Expanded(
                            child: Text('Published At: ${articles[index].publishedDate!}'),
                          ),
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
