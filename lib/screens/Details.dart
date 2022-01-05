import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:newsapp/Models/newsmodel.dart';
import 'package:newsapp/utils/appWidget.dart';
import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/constants.dart';
import 'package:share_plus/share_plus.dart';

class Details extends StatefulWidget {
  final Article list;
  // ignore: use_key_in_widget_constructors
  const Details({required this.list});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 15, 0),
        children: [
          _image(),
          text(widget.list.title ?? "",
              textColor: c_black,
              fontSize: textSizeLarge,
              fontWeight: FontWeight.w900,
              maxLine: 10),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _det(Icons.calendar_today,
                  dateParsed(dateTime: widget.list.publishedAt as DateTime)),
              _det(Icons.source, widget.list.source?.name ?? " "),
            ],
          ),
          Container(
            height: 2,
            width: double.infinity,
            color: mainColor,
          ),
          text(widget.list.description ?? "",
              maxLine: 20, fontSize: textSizeMedium),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: c_white,
      elevation: 1,
      leading: GestureDetector(
          onTap: () => finish(context),
          child: const Icon(
            Icons.chevron_left,
            color: c_black,
            size: 40,
          )),
      actions: [
        GestureDetector(
          onTap: () async {
            final box = context.findRenderObject() as RenderBox?;
            await Share.share(widget.list.url ?? "no link",
                sharePositionOrigin:
                    box!.localToGlobal(Offset.zero) & box.size);
          },
          child: const Icon(
            Icons.share_sharp,
            color: c_black,
            size: 30,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _image() {
    return CachedNetworkImage(
      height: 220,
      width: 140,
      imageUrl: widget.list.urlToImage ?? "",
      imageBuilder: (context, imageProvider) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
              colorFilter:
                  ColorFilter.mode(c_black.withOpacity(0.4), BlendMode.darken),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
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

  Widget _det(IconData iconData, String label) {
    return Row(
      children: [
        Icon(
          iconData,
          color: mainColor,
          size: 15,
        ),
        const SizedBox(width: 5),
        text(label, fontSize: textSizeMedium, fontWeight: FontWeight.w800),
      ],
    );
  }
}
