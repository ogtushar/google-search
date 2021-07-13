import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_clone/provider/main_screen_provider.dart';
import 'package:google_clone/widgets/hover_button.dart';
import 'package:google_clone/widgets/hover_text.dart';
import 'package:provider/provider.dart';

class GoogleSearchPage extends StatefulWidget {
  const GoogleSearchPage({Key? key}) : super(key: key);

  @override
  _GoogleSearchPageState createState() => _GoogleSearchPageState();
}

class _GoogleSearchPageState extends State<GoogleSearchPage> {
  @override
  Widget build(BuildContext context) {
    final mainScreenProvider = Provider.of<MainScreenProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        mainScreenProvider.isFocusedTextField = false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            mainScreenProvider.getHeader(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Logo
                    Image.asset(
                      'assets/images/googlelogo.png',
                      height: 92,
                      width: 272,
                    ),
                    SizedBox(height: 20),
                    /* Search Bar */
                    Consumer<MainScreenProvider>(
                      builder: (context, provider, child) {
                        return Material(
                          borderRadius: BorderRadius.circular(22),
                          elevation: (provider.isHoveringOnTextField ||
                                  provider.isFocusedTextField)
                              ? 5
                              : 0,
                          color: Colors.white,
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(22),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => null,
                            onHover: (value) {
                              provider.isHoveringOnTextField = value;
                            },
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 584),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              height: 44,
                              child: TextField(
                                onSubmitted: (text) {
                                  if (text.trim() != "")
                                    Navigator.pushNamed(
                                        context, '/search?q=${text.trim()}&start=1');
                                },
                                controller: provider.searchFieldController,
                                onTap: () {
                                  provider.isFocusedTextField = true;
                                },
                                style: TextStyle(fontSize: 16),
                                cursorColor: Colors.black,
                                cursorWidth: 1,
                                cursorHeight: 20,
                                onChanged: (text) {
                                  if (text == "")
                                    provider.isTextFilled = false;
                                  else
                                    provider.isTextFilled = true;
                                },
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 100),
                                      child: provider.isTextFilled
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    provider
                                                        .searchFieldController
                                                        .text = "";
                                                    provider.isTextFilled =
                                                        false;
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Color(0xFF70757a),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10.0,
                                                    bottom: 10.0,
                                                    right: 10,
                                                  ),
                                                  child: Container(
                                                    width: 1,
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                  provider.micIconUrl,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ],
                                            )
                                          : Tooltip(
                                              preferBelow: true,
                                              padding: EdgeInsets.all(5),
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                              ),
                                              message: 'Search by voice',
                                              child: SvgPicture.asset(
                                                provider.micIconUrl,
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                    ),
                                  ),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder:
                                      (provider.isHoveringOnTextField ||
                                              provider.isFocusedTextField)
                                          ? InputBorder.none
                                          : OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              borderSide: BorderSide(
                                                width: 0.0,
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 584,
                          maxHeight: 58,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: HoverButton(
                                buttonText: 'Google Search',
                                buttonColor: Color(0xFFf8f9fa),
                                borderColor: Colors.grey.shade400,
                                onTap: () {
                                  if (mainScreenProvider
                                          .searchFieldController.text
                                          .trim() !=
                                      "")
                                    Navigator.pushNamed(context,
                                        '/search?q=${mainScreenProvider.searchFieldController.text.trim()}&start=1');
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: HoverButton(
                                buttonText: "I'm Feeling Lucky",
                                buttonColor: Color(0xFFf8f9fa),
                                borderColor: Colors.grey.shade400,
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      color: Color(0xFFF2F2F2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            'India',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0,
                      height: 0,
                      color: Colors.black26,
                    ),
                    Container(
                      color: Color(0xFFF2F2F2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      child: Row(
                        children: [
                          HoverText(
                            text: 'About',
                            textStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(width: 25),
                          HoverText(
                            text: 'Advertising',
                            textStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(width: 25),
                          HoverText(
                            text: 'Business',
                            textStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(width: 25),
                          HoverText(
                            text: 'How Search works',
                            textStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                            onTap: () {},
                          ),
                          Spacer(),
                          HoverText(
                            text: 'Privacy',
                            textStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(width: 25),
                          HoverText(
                            text: 'Terms',
                            textStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(width: 25),
                          HoverText(
                            text: 'Settings',
                            textStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
