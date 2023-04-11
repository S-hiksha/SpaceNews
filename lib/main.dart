// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class News {
  final int? id;
  final String? title;
  final String? url;
  final String? imageUrl;
  final String? newSite;
  final String? summary;
  final String? publishedAt;
  final String? updatedAt;
  final bool? featured;
  final List<dynamic>? launches;
  final List<dynamic>? events;

  News(
      {required this.id,
      required this.title,
      required this.url,
      required this.imageUrl,
      required this.newSite,
      required this.summary,
      required this.publishedAt,
      required this.updatedAt,
      required this.featured,
      required this.launches,
      required this.events});

  factory News.fromJson(Map<String, dynamic>? json) {
    return News(
        id: json!['id'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        imageUrl: json['imageUrl'] as String,
        newSite: json['newSite'] as String?,
        summary: json['summary'] as String,
        publishedAt: json['publishedAt'] as String,
        updatedAt: json['updatedAt'] as String,
        featured: json['featured'] as bool,
        launches: json['launches'] as List,
        events: json['events'] as List);
  }
}

void main() {
  runApp(MaterialApp(
    home: const SpaceNews(),
    theme: ThemeData(primarySwatch: Colors.blueGrey),
  ));
}

class SpaceNews extends StatefulWidget {
  const SpaceNews({super.key});

  @override
  State<SpaceNews> createState() => _SpaceNewsState();
}

class _SpaceNewsState extends State<SpaceNews> {
  final List<News> _news = <News>[];
  Future<List<News>> fetchNews() async {
    Uri url = Uri.parse('https://api.spaceflightnewsapi.net/v3/articles');
    var response = await http.get(url);
    var news = <News>[];

    if (response.statusCode == 200) {
      var newsJson = jsonDecode(response.body);
      for (var newJson in newsJson) {
        news.add(News.fromJson(newJson));
      }
    }
    return news;
  }

  @override
  void initState() {
    fetchNews().then((value) {
      setState(() {
        _news.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
  return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  'Space',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'News',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            )
            ),
        body: Container(
          padding: EdgeInsets.all(60.0),
          color: Colors.blueGrey,
          child: ListView.builder(
            itemCount: _news.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(12.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3.0,
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.0,
                      //width: double.infinity,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                '${_news[index].imageUrl.toString()}'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: InkWell(
                        // ignore: unnecessary_string_interpolations
                        onTap: () => launchUrl(
                            Uri.parse('${_news[index].url.toString()}')),
                        child: Text(
                          _news[index].title.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Text(
                        _news[index].summary.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
} else {
  return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  'Space',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'News',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            )
            ),
        body: SafeArea(
          child: Container(
            color: Colors.blueGrey,
            child: ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(12.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[300],
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3.0,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200.0,
                        //width: double.infinity,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${_news[index].imageUrl.toString()}'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: InkWell(
                          // ignore: unnecessary_string_interpolations
                          onTap: () => launchUrl(
                              Uri.parse('${_news[index].url.toString()}')),
                          child: Text(
                            _news[index].title.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Text(
                          _news[index].summary.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
}
  
  }
}
