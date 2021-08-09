import 'package:flutter/material.dart';
import 'icon_content.dart';
import 'reusable_card.dart';

class WidgetList {
  List<Widget> widgetList = [
    listRow(
      icon1: Icons.lock,
      icon2: Icons.line_style,
      label1: 'Login and Register',
      label2: 'ListView',
      image1: NetworkImage(
          'https://th.bing.com/th/id/OIP.Sx6HOCnbBdNMAszbbD3VcAHaMS?pid=ImgDet&rs=1'),
      image2: NetworkImage(
          ' https://th.bing.com/th/id/OIP.Sx6HOCnbBdNMAszbbD3VcAHaMS?pid=ImgDet&rs=1'),
    ),
    listRow(
        icon1: Icons.grid_view,
        icon2: Icons.line_weight_sharp,
        label1: 'GridView',
        label2: 'SliverAppbar'),
    listRow(
        icon1: Icons.menu,
        icon2: Icons.menu_open,
        label1: 'Side Menu',
        label2: 'Bottom Menu'),
    listRow(
      icon1: Icons.crop_square,
      icon2: Icons.window,
      label1: '',
      label2: '',
    ),
    listRow(
        icon1: Icons.lock,
        icon2: Icons.lock,
        label1: 'Login and Register',
        label2: 'ListView',
        image1: NetworkImage(
            'https://th.bing.com/th/id/OIP.Sx6HOCnbBdNMAszbbD3VcAHaMS?pid=ImgDet&rs=1')),
  ];
}

//LISTROW
Expanded listRow(
    {IconData icon1,
    IconData icon2,
    String label1,
    String label2,
    ImageProvider image1,
    ImageProvider image2}) {
  return Expanded(
    child: Row(
      children: [
        Expanded(
          child: ReusableCard(
            onPress: () {},
            cardChild: IconContent(icon: icon1, label: label1),
            picture: image1,
          ),
        ),
        Expanded(
          child: ReusableCard(
            onPress: () {},
            cardChild: IconContent(icon: icon2, label: label2),
            picture: image2,
          ),
        ),
      ],
    ),
  );
}
