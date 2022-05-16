import 'dart:convert';

import 'package:flutter/foundation.dart';

class NewsResponseModel {
  String? status;
  int? totalHits;
  int? page;
  int? totalPages;
  int? pageSize;
  List<Article>? articles;
  NewsResponseModel({
    this.status,
    this.totalHits,
    this.page,
    this.totalPages,
    this.pageSize,
    this.articles,
  });

  NewsResponseModel copyWith({
    String? status,
    int? totalHits,
    int? page,
    int? totalPages,
    int? pageSize,
    List<Article>? articles,
  }) {
    return NewsResponseModel(
      status: status ?? this.status,
      totalHits: totalHits ?? this.totalHits,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      pageSize: pageSize ?? this.pageSize,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'total_hits': totalHits,
      'page': page,
      'total_pages': totalPages,
      'page_size': pageSize,
      'articles': articles?.map((Article? x) => x!.toMap()).toList(),
    };
  }

  factory NewsResponseModel.fromMap(Map<String, dynamic> map) {
    return NewsResponseModel(
      status: map['status'],
      totalHits: map['total_hits']?.toInt(),
      page: map['page']?.toInt(),
      totalPages: map['total_pages']?.toInt(),
      pageSize: map['page_size']?.toInt(),
      articles: map['articles'] != null
          ? List<Article>.from(map['articles']?.map((x) => Article.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsResponseModel.fromJson(String source) =>
      NewsResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsResponseModel(status: $status, total_hits: $totalHits, page: $page, total_pages: $totalPages, page_size: $pageSize, articles: $articles)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsResponseModel &&
        other.status == status &&
        other.totalHits == totalHits &&
        other.page == page &&
        other.totalPages == totalPages &&
        other.pageSize == pageSize &&
        listEquals(other.articles, articles);
  }

  @override
  int get hashCode {
    return status.hashCode ^
        totalHits.hashCode ^
        page.hashCode ^
        totalPages.hashCode ^
        pageSize.hashCode ^
        articles.hashCode;
  }
}

class Article {
  String? title;
  String? summary;
  String? publishedDate;
  String? link;
  String? media;
  String? rights;
  int? rank;
  String? topic;
  String? country;
  String? language;
  Article({
    this.title,
    this.summary,
    this.publishedDate,
    this.link,
    this.media,
    this.rights,
    this.rank,
    this.topic,
    this.country,
    this.language,
  });

  Article copyWith({
    String? title,
    String? summary,
    String? publishedDate,
    String? link,
    String? media,
    String? rights,
    int? rank,
    String? topic,
    String? country,
    String? language,
  }) {
    return Article(
      title: title ?? this.title,
      summary: summary ?? this.summary,
      publishedDate: publishedDate ?? this.publishedDate,
      link: link ?? this.link,
      media: media ?? this.media,
      rights: rights ?? this.rights,
      rank: rank ?? this.rank,
      topic: topic ?? this.topic,
      country: country ?? this.country,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'summary': summary,
      'published_date': publishedDate,
      'link': link,
      'media': media,
      'rights': rights,
      'rank': rank,
      'topic': topic,
      'country': country,
      'language': language,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'],
      summary: map['summary'],
      publishedDate: map['published_date'],
      link: map['link'],
      media: map['media'],
      rights: map['rights'],
      rank: map['rank']?.toInt(),
      topic: map['topic'],
      country: map['country'],
      language: map['language'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Article(title: $title, summary: $summary, published_date: $publishedDate, link: $link, media: $media, rights: $rights, rank: $rank, topic: $topic, country: $country, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article &&
        other.title == title &&
        other.summary == summary &&
        other.publishedDate == publishedDate &&
        other.link == link &&
        other.media == media &&
        other.rights == rights &&
        other.rank == rank &&
        other.topic == topic &&
        other.country == country &&
        other.language == language;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        summary.hashCode ^
        publishedDate.hashCode ^
        link.hashCode ^
        media.hashCode ^
        rights.hashCode ^
        rank.hashCode ^
        topic.hashCode ^
        country.hashCode ^
        language.hashCode;
  }
}
