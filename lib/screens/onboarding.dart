import "package:flutter/material.dart";
import "package:flutter_swiper/flutter_swiper.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "../widgets/swiper_pagination.dart";
import "package:fix_map/blocs/blocs.dart";

class IntroThreePage extends StatefulWidget {
  static const String routeName = "onboarding";

  final SettingsBloc settingsBloc;
  const IntroThreePage({Key key, this.settingsBloc}) : super(key: key);

  @override
  _IntroThreePageState createState() => _IntroThreePageState();
}

class _IntroThreePageState extends State<IntroThreePage> {
  final SwiperController _swiperController = SwiperController();
  final int _pageCount = 3;
  int _currentIndex = 0;

  final List<String> titles = [
    "Welcome !\nApplication help for \n motorbike repair points.",
    "Direct !\nFind the shortest path to the correction point.",
    "Evaluate !\n Leave a review of the correction point.",
  ];
  final List<Color> pageBgs = [
    Colors.blue.shade300,
    Colors.grey.shade600,
    Colors.cyan.shade300
  ];
  final List<String> images = [
    "assets/onboarding/1.png",
    "assets/onboarding/1.png",
    "assets/onboarding/1.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: 300,
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Swiper(
                index: _currentIndex,
                controller: _swiperController,
                itemCount: _pageCount,
                onIndexChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                loop: false,
                itemBuilder: (context, index) {
                  return _buildPage(
                      title: titles[index],
                      icon: images[index],
                      pageBg: pageBgs[index]);
                },
                pagination: SwiperPagination(
                    builder: CustomPaginationBuilder(
                        activeSize: Size(10.0, 20.0),
                        size: Size(10.0, 15.0),
                        color: Colors.grey.shade600)),
              )),
              SizedBox(height: 10.0),
              _buildButtons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Text("Skip"),
            onPressed: () {
              updateSetting();
              Navigator.pushReplacementNamed(this.context, "home");
            },
          ),
          IconButton(
            icon: Icon(_currentIndex < _pageCount - 1
                ? Icons.arrow_forward_ios
                : FontAwesomeIcons.check),
            onPressed: () async {
              if (_currentIndex < _pageCount - 1)
                await _swiperController.next();
              else {
                updateSetting();
                await Navigator.pushReplacementNamed(this.context, "home");
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildPage({String title, String icon, Color pageBg}) {
    final TextStyle titleStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.white);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 40.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: pageBg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          SizedBox(height: 30.0),
          Expanded(
            child: ClipOval(
                child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(icon), fit: BoxFit.cover)),
            )),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }

  void updateSetting() {
    final updateSetting = widget.settingsBloc.settings;
    updateSetting.isLoadFirstScreen = true;
    widget.settingsBloc.add(SettingsUpdateSettingsEvent(updateSetting));
  }
}
