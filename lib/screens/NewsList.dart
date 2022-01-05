import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Models/newsmodel.dart';
import 'package:newsapp/utils/appWidget.dart';
import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/constants.dart';

import 'Details.dart';

class NewsList extends StatefulWidget {
  final List<Article> newsList;
  const NewsList({Key? key, required this.newsList}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).padding.top + 10, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text("  Breaking News",
                textColor: c_black,
                fontWeight: FontWeight.bold,
                fontSize: textSizeLarge),
            breakingContainer(),
          ],
        ),
      ),
    );
  }

  Widget breakingContainer() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.newsList.length,
          primary: false,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Details(
                            list: widget.newsList[i],
                          ))),
              child: Container(
                height: 220,
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                padding: const EdgeInsets.only(
                  bottom: 0,
                  top: 0,
                  right: 5,
                ),
                width: 0.6 * MediaQuery.of(context).size.width,
                decoration: boxDecoration(
                    radius: 10,
                    fillColor: c_white,
                    showShadow: true,
                    shColor: mainColor.withOpacity(0.8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _image(
                        url: widget.newsList[i].urlToImage,
                        sourceName: widget.newsList[i].source!.name as String),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 0.6 * MediaQuery.of(context).size.width,
                            child: text(widget.newsList[i].title ?? "",
                                textColor: mainColor,
                                fontWeight: FontWeight.w900,
                                fontSize: textSizeLargeMedium,
                                maxLine: 3),
                          ),
                          SizedBox(
                            width: 0.6 * MediaQuery.of(context).size.width,
                            child: text(widget.newsList[i].content ?? "",
                                textColor: c_black,
                                fontWeight: FontWeight.w700,
                                fontSize: textSizeMedium,
                                maxLine: 2),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 0.6 * MediaQuery.of(context).size.width,
                            decoration:
                                boxDecoration(fillColor: mainColor, radius: 5),
                            padding: const EdgeInsets.all(4),
                            child: text(
                              " Author: ${widget.newsList[i].author ?? "..."}",
                              textColor: c_white,
                              fontWeight: FontWeight.w500,
                              fontSize: textSizeSMedium,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: mainColor,
                                size: 15,
                              ),
                              text(
                                  dateParsed(
                                      dateTime: widget.newsList[i].publishedAt
                                          as DateTime),
                                  fontSize: textSizeSmall,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _image({String? url, String? sourceName}) {
    return CachedNetworkImage(
      height: 220,
      width: 140,
      imageUrl: url ?? "",
      imageBuilder: (context, imageProvider) => Container(
        height: 220,
        width: 140,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: mainColor.withOpacity(0.15),
                  offset: const Offset(2, 3))
            ],
            image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.darken)),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: text(sourceName ?? " ",
                maxLine: 4,
                isCentered: true,
                textColor: c_white,
                fontSize: textSizeNormal),
          ),
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Column(
        children: [
          const Icon(Icons.error),
          text("No image", fontSize: textSizeSmall)
        ],
      ),
    );
  }
}
