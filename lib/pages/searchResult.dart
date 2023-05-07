import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mybookfinderapp/apis/GetBookByName.dart';
import 'package:mybookfinderapp/components/SaveBooks.dart';
import 'package:mybookfinderapp/components/bookCard.dart';
import 'package:mybookfinderapp/components/searchHistory.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultScreen extends StatefulWidget {
  Map<String, dynamic> searchData;

  SearchResultScreen({super.key, required this.searchData});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  TextEditingController _controller = TextEditingController();

  bool showSearchHistory_ = false;
  String searchQuery = '';
  String SearchFor = "";

  List curertntSearchHistory = [];

  Future<void> getSearchHistory(String search) async {
    List<String> historyList = await SearchHistory.getSearchHistory();
    if (search == '') {
      setState(() {
        curertntSearchHistory = historyList;
      });
    } else {
      List<String> filteredList = [];
      historyList.forEach((element) {
        if (element.toLowerCase().contains(search.toLowerCase())) {
          filteredList.add(element);
        }
      });
      setState(() {
        curertntSearchHistory = filteredList;
      });
    }
  }

  List responseData = [""];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ScreenDimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: ScreenDimensions.height * (40 / 844)),
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onTap: () {
                          setState(() {
                            showSearchHistory_ = true;
                          });
                          getSearchHistory(searchQuery);
                        },
                        // onTapOutside: (event) {
                        //   setState(() {
                        //     showSearchHistory_ = false;
                        //   });
                        // },
                        onChanged: (value) async {
                          setState(() {
                            searchQuery = value;
                            showSearchHistory_ = true;
                          });
                          await getSearchHistory(searchQuery);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 28,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 52,
                            minHeight: 52,
                          ),
                          contentPadding: EdgeInsets.only(left: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.8),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00A1FC),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "Try “Let Us C”",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color(0xffBDBDBD),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenDimensions.width * (16 / 844)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showSearchHistory_ = false;
                        });
                        if (searchQuery.trim() == '') {
                          log('Search query is empty');
                          return;
                        }
                        _controller.clear();
                        SearchHistory.setSearchHistory(searchQuery.trim());
                      },
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xff00A1FC),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search history
              Stack(
                children: [
                  FutureBuilder(
                    future: getSearchHistory(searchQuery),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Visibility(
                        visible: showSearchHistory_,
                        child: Column(
                          children: [
                            SizedBox(
                                height: ScreenDimensions.height * (18 / 844)),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: curertntSearchHistory.length < 10
                                  ? curertntSearchHistory.length
                                  : 10,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 8,
                                  ),
                                  child: Container(
                                    width: ScreenDimensions.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Color(0xffF0F0F3),
                                    ),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: ScreenDimensions.height *
                                                (8 / 844),
                                          ),
                                          child: Text(
                                            curertntSearchHistory[index],
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () async {
                                            await SearchHistory
                                                .removeSearchHistory(
                                                    curertntSearchHistory[
                                                        index]);
                                            await getSearchHistory(searchQuery);
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: !showSearchHistory_,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.searchData['data'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 20,
                              ),
                              child: BookCard(
                                onOpen: () async {
                                  String url =
                                      widget.searchData['data'][index]['url'];
                                  final Uri _url = Uri.parse(url);

                                  await launchUrl(_url,
                                      mode: LaunchMode.externalApplication);
                                },
                                onSave: () {
                                  SaveBooks.saveBook(jsonEncode(
                                      widget.searchData['data'][index]));
                                },
                                title: widget.searchData['data'][index]['name'],
                                author: widget.searchData['data'][index]
                                    ['authors'][0],
                                rating: (widget.searchData['data'][index]
                                            ['rating'] ??
                                        0)
                                    .toString(),
                                imageUrl: widget.searchData['data'][index]
                                    ['cover'],
                                openLink: widget.searchData['data'][index]
                                    ['url'],
                                showClose: false,
                                onClose: () {},
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
