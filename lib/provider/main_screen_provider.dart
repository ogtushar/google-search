import 'package:flutter/material.dart';
import 'package:google_clone/widgets/hover_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreenProvider extends ChangeNotifier {
  bool _isHoveringOnTextField = false;
  bool _isFocusedTextField = false;
  bool _isTextFilled = false;
  String _micIconUrl = "assets/icons/mic_icon.svg";
  TextEditingController searchFieldController = TextEditingController();

  String get micIconUrl => _micIconUrl;
  bool get isHoveringOnTextField => _isHoveringOnTextField;
  bool get isFocusedTextField => _isFocusedTextField;
  bool get isTextFilled => _isTextFilled;

  set isHoveringOnTextField(bool val) {
    _isHoveringOnTextField = val;
    notifyListeners();
  }

  set isFocusedTextField(bool val) {
    _isFocusedTextField = val;
    notifyListeners();
  }

  set isTextFilled(bool val) {
    _isTextFilled = val;
    notifyListeners();
  }

  Widget getHeader(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: HoverText(
              text: 'Gmail',
              onTap: () async {
                if (await canLaunch('https://mail.google.com')) {
                  await launch('https://mail.google.com');
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: HoverText(
              text: 'Images',
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Material(
                color: Colors.transparent,
                child: PopupMenuButton(
                  offset: Offset(30, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  onSelected: (value) {},
                  icon: Icon(
                    Icons.apps_rounded,
                    color: Color(0xFF5f6368),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        enabled: false,
                        child: Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 60,
                              width: 60,
                              child: InkWell(
                                onTap: () {},
                                hoverColor: Color(0xFFE8F0FE),
                                child: Icon(Icons.location_history),
                              ),
                            )
                          ],
                        ),
                      )
                    ];
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => null,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 32,
              width: 32,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/profile.png'),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
