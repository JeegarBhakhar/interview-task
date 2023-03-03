import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Avatar{
  Widget avatarIconWidget(Icon icons){
    return CircleAvatar(child: icons,);
  }
  Widget avatarWidget(String url){
    return CircleAvatar(backgroundImage: NetworkImage(url));
  }
}