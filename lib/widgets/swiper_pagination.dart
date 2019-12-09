import "package:flutter/material.dart";
import "package:flutter_swiper/flutter_swiper.dart";

class CustomPaginationBuilder extends SwiperPlugin {
  final Color activeColor;
  final Color color;
  final Size activeSize;
  final Size size;
  final double space;

  final Key key;

  const CustomPaginationBuilder(
      {this.activeColor,
      this.color,
      this.key,
      this.size: const Size(10.0, 2.0),
      this.activeSize: const Size(10.0, 2.0),
      this.space: 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    final ThemeData themeData = Theme.of(context);
    final Color activeColor = this.activeColor ?? themeData.primaryColor;
    final Color color = this.color ?? themeData.scaffoldBackgroundColor;

    final List<Widget> list = [];

    if (config.itemCount > 20) {
      print(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }

    final int itemCount = config.itemCount;
    final int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      final bool active = i == activeIndex;
      final Size size = active ? this.activeSize : this.size;
      list.add(SizedBox(
        width: size.width,
        height: size.height,
        child: Container(
          decoration: BoxDecoration(
              color: active ? activeColor : color,
              borderRadius: BorderRadius.circular(10.0)),
          key: Key("pagination_$i"),
          margin: EdgeInsets.all(space),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}
