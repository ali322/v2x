import "package:flutter/material.dart";
import "package:cached_network_image/cached_network_image.dart";

class TopicTile extends StatelessWidget{
  final String avatar;
  final Widget title;
  final Widget subTitle;
  final Widget trailing;

  TopicTile({Key key,@required this.avatar, @required this.title, @required this.subTitle,this.trailing}):super(key: key);

  @override
    Widget build(BuildContext context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: 24.0,
            height: 24.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                placeholder: (BuildContext context, String url) => Image.asset('asset/default_avatar.png'),
                imageUrl: avatar,
                errorWidget: (BuildContext context, String url, Object error) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title,
                subTitle
              ],
            ),
            flex: 1
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),child: trailing)
        ],
      );
    }
}