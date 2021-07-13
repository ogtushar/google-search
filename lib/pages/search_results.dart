import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_clone/provider/global_provider.dart';
import 'package:google_clone/provider/main_screen_provider.dart';
import 'package:google_clone/provider/search_result_provider.dart';
import 'package:google_clone/widgets/hover_text.dart';
import 'package:google_clone/widgets/search_result_component.dart';
import 'package:provider/provider.dart';

class GoogleSearchResultPage extends StatefulWidget {
  final String q;
  final String startIndex;
  const GoogleSearchResultPage(
      {Key? key, required this.q, required this.startIndex})
      : super(key: key);

  @override
  _GoogleSearchResultPageState createState() => _GoogleSearchResultPageState();
}

class _GoogleSearchResultPageState extends State<GoogleSearchResultPage> {
  @override
  Widget build(BuildContext context) {
    final searchResultProvider = Provider.of<SearchResultProvider>(context);
    final mainScreenProvider = Provider.of<MainScreenProvider>(context);
    Provider.of<GlobalProvider>(context).appName =
        "${widget.q} - Google Search";
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        mainScreenProvider.isFocusedTextField = false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 15, top: 4),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Image.asset(
                            'assets/images/googlelogo.png',
                            height: 30,
                            width: 92,
                          ),
                        ),
                      ),
                      SizedBox(width: 27),
                      Consumer<MainScreenProvider>(
                        builder: (context, provider, child) {
                          return Material(
                            borderRadius: BorderRadius.circular(22),
                            elevation: 5,
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
                                width: 684,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                height: 44,
                                child: TextField(
                                  onSubmitted: (text) {
                                    if (text.trim() != "")
                                      Navigator.pushNamed(
                                          context, '/search?q=${text.trim()}');
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
                                    prefixIcon: provider.isFocusedTextField
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14),
                                            child: Icon(
                                              Icons.search,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : SizedBox(width: 28),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 150),
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
                                                  SizedBox(width: 20),
                                                  Icon(Icons.search,
                                                      color: Colors.blue),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Tooltip(
                                                    preferBelow: true,
                                                    padding: EdgeInsets.all(5),
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  SizedBox(width: 20),
                                                  Icon(Icons.search,
                                                      color: Colors.blue),
                                                ],
                                              ),
                                      ),
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: IconButton(
                          icon: Icon(Icons.settings_outlined),
                          onPressed: () {},
                          splashRadius: 16,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
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
                          height: 30,
                          width: 30,
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
                      SizedBox(width: 30),
                    ],
                  ),
                ),
              ),
              Container(
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(left: 150.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 18,
                                  color: Color(0xFF1A73E8),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  'All',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF1A73E8),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            Container(
                              height: 3,
                              width: 40,
                              color: Color(0xFF1A73E8),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {},
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo_outlined,
                                    size: 18,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    'Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              Container(
                                height: 3,
                                width: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0,
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: searchResultProvider.apiService.fetchData(
                    context: context, q: widget.q, start: widget.startIndex),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 150, top: 12),
                          child: Text(
                            "About ${snapshot.data?['searchInformation']['formattedTotalResults']} results (${snapshot.data?['searchInformation']['formattedSearchTime']})",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF70757a),
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?['items'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 150, top: 30),
                              child: SearchResultComponent(
                                linkToGo: snapshot.data?['items'][index]
                                    ['link'],
                                link: snapshot.data?['items'][index]
                                    ['formattedUrl'],
                                text: snapshot.data?['items'][index]['title'],
                                desc: snapshot.data?['items'][index]['snippet'],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HoverText(
                                text: "< Prev",
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: widget.startIndex != "1"
                                        ? Color(0xFF1a0dab)
                                        : null),
                                onTap: widget.startIndex != "1"
                                    ? () {
                                        Navigator.pushNamed(context,
                                            '/search?q=${widget.q}&start=${int.parse(widget.startIndex) - 10}');
                                      }
                                    : null,
                              ),
                              SizedBox(width: 30),
                              HoverText(
                                text: "Next >",
                                textStyle: TextStyle(
                                    fontSize: 15, color: Color(0xFF1a0dab)),
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      '/search?q=${widget.q}&start=${int.parse(widget.startIndex) + 10}');
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          color: Color(0xFFF2F2F2),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          child: Row(
                            children: [
                              Text(
                                'India',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 20,
                                width: 0.5,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.circle,
                                color: Color(0xFF70757A),
                                size: 12,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Navi Khadki, Yerwada, Pune, Maharashtra",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF3c4043),
                                ),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          child: Row(
                            children: [
                              Text(
                                'Help',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Send feedback',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Privacy',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Terms',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
