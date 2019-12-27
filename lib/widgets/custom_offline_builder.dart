import "package:flutter/material.dart";
import "package:flutter_offline/flutter_offline.dart";

class CustomOfflineBuilder extends StatelessWidget {
  final Widget child;

  const CustomOfflineBuilder({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      child: child,
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            AnimatedPositioned(
              height: 24.0,
              left: 0.0,
              right: 0.0,
              top: !connected ? MediaQuery.of(context).padding.top : -24,
              child: Container(
                color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                child: Center(
                  child: Text("${connected ? "ONLINE" : "OFFLINE"}"),
                ),
              ),
              duration: Duration(seconds: 1),
            ),
          ],
        );
      },
    );
  }
}
