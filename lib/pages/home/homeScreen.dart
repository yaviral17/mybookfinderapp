import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mybookfinderapp/apis/GetBookByName.dart';
import 'package:mybookfinderapp/components/SaveBooks.dart';
import 'package:mybookfinderapp/components/bookCard.dart';
import 'package:mybookfinderapp/components/searchHistory.dart';
import 'package:mybookfinderapp/pages/searchResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();

  bool showSearchHistory_ = false;
  String searchQuery = '';

  List curertntSearchHistory = [];

  List SavedBooksList = [];

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

  Future<void> getSavedBooks() async {
    List<Map<String, dynamic>> savedBooks = await SaveBooks.getSavedBooks();
    setState(() {
      SavedBooksList = savedBooks;
    });
  }

  Future<void> getResponseFromAPI(String Search) async {
    if (Search.trim().isEmpty) {
      return;
    }
    Map<String, dynamic> resposen =
        await GetBookByNameAPI(Search.trim().replaceAll(" ", "+"));
    log("hi");
    if (resposen["isSuccess"]) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultScreen(
            searchData: resposen,
          ),
        ),
      );
    }
    log(resposen['data'].toString());
  }

  @override
  Widget build(BuildContext context) {
    var ScreenDimensions = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenDimensions.height * (66 / 844)),
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
                    onTap: () async {
                      setState(() {
                        showSearchHistory_ = false;
                      });
                      if (_controller.text.trim().isEmpty) {
                        log('Search query is empty');
                        return;
                      }
                      SearchHistory.setSearchHistory(searchQuery.trim());
                      await getResponseFromAPI(_controller.text.trim());
                      _controller.clear();
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
            Stack(
              alignment: Alignment.topLeft,
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
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: curertntSearchHistory.length < 10
                                ? curertntSearchHistory.length
                                : 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 8,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _controller.text =
                                        curertntSearchHistory[index];
                                  },
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenDimensions.height * (18 / 844)),
                        Text(
                          'Saved Books',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        // SizedBox(height: ScreenDimensions.height * (18 / 844)),
                        FutureBuilder(
                          future: getSavedBooks(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: SavedBooksList.length < 10
                                    ? SavedBooksList.length
                                    : 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: BookCard(
                                      showSave: false,
                                      title: SavedBooksList[index]['name'],
                                      author: SavedBooksList[index]['authors']
                                          [0],
                                      rating:
                                          (SavedBooksList[index]['rating'] ?? 0)
                                              .toString(),
                                      imageUrl: SavedBooksList[index]['cover'],
                                      openLink: SavedBooksList[index]['url'],
                                      showClose: true,
                                      onClose: () {
                                        print("close");
                                        SaveBooks.removeSavedBook(
                                            jsonEncode(SavedBooksList[index]));
                                        setState(() {
                                          SavedBooksList.remove(
                                              SavedBooksList[index]);
                                        });
                                      },
                                      onOpen: () async {
                                        //Launch URL
                                        String url =
                                            SavedBooksList[index]['url'];
                                        final Uri _url = Uri.parse(url);

                                        await launchUrl(_url,
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                      onSave: () {},
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
