import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

const Map<String, dynamic> APIResponse = {
  "data": [
    {
      "book_id": 2522691,
      "name": "Let Us C Solutions",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1494048555i/2522691._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/2522691.Let_Us_C_Solutions?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=1",
      "authors": ["Yashavant P. Kanetkar"],
      "rating": 4.08,
      "created_editions": 4,
      "year": 2007
    },
    {
      "book_id": 2522736,
      "name": "Let Us C++",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1494048716i/2522736._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/2522736.Let_Us_C_?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=2",
      "authors": ["Yashavant P. Kanetkar"],
      "rating": 4.02,
      "created_editions": 3
    },
    {
      "book_id": 2522685,
      "name": "Let Us C",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1494048488i/2522685._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/2522685.Let_Us_C?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=3",
      "authors": ["Yashavant P. Kanetkar"],
      "rating": 4.13,
      "created_editions": 17,
      "year": 2002
    },
    {
      "book_id": 20951475,
      "name": "Let Us C#",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1433005579i/20951475._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/20951475-let-us-c?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=4",
      "authors": ["Yashavant P. Kanetkar"],
      "rating": 4.03,
      "created_editions": 1,
      "year": 2010
    },
    {
      "book_id": 55414099,
      "name": "Let Us C Solutions: Authenticate Solutions of Let US C Exercise",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1600752092i/55414099._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/55414099-let-us-c-solutions?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=5",
      "authors": ["Yashavant Kanetkar"],
      "rating": 3.77,
      "created_editions": 4
    },
    {
      "book_id": 26042939,
      "name": "Let Us C++ Soultions [Dec 01, 2010] Kanetkar, Yashwant",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1438752352i/26042939._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/26042939-let-us-c-soultions-dec-01-2010-kanetkar-yashwant?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=6",
      "authors": ["Yashwant Kanetkar"],
      "rating": 4,
      "created_editions": 1,
      "year": 2010
    },
    {
      "book_id": 10153814,
      "name": "Let Us C--Student Study Guide/Solutions Manual",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/nophoto/book/111x148._SX50_.png",
      "url":
          "https://www.goodreads.com/book/show/10153814-let-us-c--student-study-guide-solutions-manual?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=7",
      "authors": ["Yashavant P. Kanetkar"],
      "rating": 4.22,
      "created_editions": 1,
      "year": 2012
    },
    {
      "book_id": 9446212,
      "name": "Let Us C",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1553518427i/9446212._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/9446212-let-us-c?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=8",
      "authors": ["Yashavant Kanetkar"],
      "rating": 4.44,
      "created_editions": 2
    },
    {
      "book_id": 29497616,
      "name": "Let Us C Solutions [Dec 01, 2010] Kanetkar, Yashavant P.",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1457886322i/29497616._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/29497616-let-us-c-solutions-dec-01-2010-kanetkar-yashavant-p?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=9",
      "authors": ["Yashwant Kanetkar"],
      "rating": 3.55,
      "created_editions": 1
    },
    {
      "book_id": 11887020,
      "name":
          "American Sniper: The Autobiography of the Most Lethal Sniper in U.S. Military History",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1348628279i/11887020._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/11887020-american-sniper?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=10",
      "authors": ["Chris Kyle", "Scott McEwen", "Jim DeFelice"],
      "rating": 4.02,
      "created_editions": 61,
      "year": 2012
    },
    {
      "book_id": 48508122,
      "name": "Let us 'c': Basic c programming for beginners",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1571511644i/48508122._SY75_.jpg",
      "url":
          "https://www.goodreads.com/book/show/48508122-let-us-c?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=11",
      "authors": ["Yashwant Kanetkar"],
      "rating": 4,
      "created_editions": 1
    },
    {
      "book_id": 55281145,
      "name": "Let Us C: Authentic Guide to C Programming Language",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1599648837i/55281145._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/55281145-let-us-c?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=12",
      "authors": ["Yashavant Kanetkar"],
      "rating": 4.14,
      "created_editions": 2
    },
    {
      "book_id": 36319711,
      "name": "Let Us C Work Book",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1506623150i/36319711._SX50_.jpg",
      "url":
          "https://www.goodreads.com/book/show/36319711-let-us-c-work-book?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=13",
      "authors": ["Yashavant Kanetkar"],
      "rating": 4.17,
      "created_editions": 1
    },
    {
      "book_id": 243360,
      "name":
          "James Agee and Walker Evans Let Us Now Praise Famous Men (Penguin Modern Classics) /anglais",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1507135568i/243360._SY75_.jpg",
      "url":
          "https://www.goodreads.com/book/show/243360.James_Agee_and_Walker_Evans_Let_Us_Now_Praise_Famous_Men_Penguin_Modern_Classics_anglais?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=14",
      "authors": ["AGEE JAMES/ WALKER E"],
      "rating": 4,
      "created_editions": 82,
      "year": 1941
    },
    {
      "book_id": 52973755,
      "name":
          "Let Us C++: Dive into the nitty-gritties of C++ language and learn why programmers prefer OOPs and C++",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1571273198l/52973755._SX50_SY75_.jpg",
      "url":
          "https://www.goodreads.com/book/show/52973755-let-us-c?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=15",
      "authors": ["Yashavant Kanetkar"],
      "rating": 0,
      "created_editions": 1
    },
    {
      "book_id": 44539333,
      "name": "Let Us Prey",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1553019864i/44539333._SY75_.jpg",
      "url":
          "https://www.goodreads.com/book/show/44539333-let-us-prey?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=16",
      "authors": ["Blake Banner"],
      "rating": 4.36,
      "created_editions": 4,
      "year": 2017
    },
    {
      "book_id": 51073866,
      "name":
          "Let Us C++: Dive into the nitty-gritties of C++ language and learn why programmers prefer OOPs and C++",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1581168609i/51073866._SY75_.jpg",
      "url":
          "https://www.goodreads.com/book/show/51073866-let-us-c?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=17",
      "authors": ["Yashavant Kanetkar"],
      "rating": 4,
      "created_editions": 1
    },
    {
      "book_id": 62801252,
      "name":
          "Let Us C 18th Edition: Authentic guide to C programming language",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1664229982i/62801252._SY75_.jpg",
      "url":
          "https://www.goodreads.com/book/show/62801252-let-us-c-18th-edition?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=18",
      "authors": ["Yashavant Kanetkar"],
      "rating": 0,
      "created_editions": 1
    },
    {
      "book_id": 33583903,
      "name": "Come, Let Us Adore Him: A Daily Advent Devotional",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1488464144i/33583903._SY75_.jpg",
      "url":
          "https://www.goodreads.com/book/show/33583903-come-let-us-adore-him?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=19",
      "authors": ["Paul David Tripp"],
      "rating": 4.34,
      "created_editions": 11,
      "year": 2017
    },
    {
      "book_id": 58470825,
      "name":
          "Let Us Believe in the Beginning of the Cold Season: Selected Poems",
      "cover":
          "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1628279949i/58470825._SY75_.jpg",
      "url":
          "https://www.goodreads.com/book/show/58470825-let-us-believe-in-the-beginning-of-the-cold-season?from_search=true&from_srp=true&qid=znjU5pRB3Z&rank=20",
      "authors": ["Forugh Farrokhzad", "Elizabeth T. Gray Jr"],
      "rating": 4.29,
      "created_editions": 2,
      "year": 2022
    }
  ],
  "status": "success"
};

Future<Map<String, dynamic>> GetBookByNameAPI(String Bookname) async {
  // var headers = {
  //   'X-RapidAPI-Key': 'd75f2b8ce9msh13c0e9e6b1c9a81p16aac4jsnf02fbbe4c58a',
  //   'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com',
  //   'Content-Type': 'application/json'
  // };  EXPIRED
  var headers = {
    'X-RapidAPI-Key': '7b11b0c392msh73d27e8bce56948p18f0b2jsnaac7a4cb5bd9',
    'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com',
    'Content-Type': 'application/json'
  };
  // UNUSED Rishi's ID
  // var headers = {
  //   'X-RapidAPI-Key': 'edf1de4780msh1d402bbc4192ab0p13f9f0jsnec1635bec193',
  //   'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com',
  //   'Content-Type': 'application/json'
  // };
  // UNUSED yaviral17@gmail.com
  // var headers = {
  //   'X-RapidAPI-Key': '9f3be0f54emshf7159176465f079p1bfbe4jsnd260af9bc6c3',
  //   'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com',
  //   'Content-Type': 'application/json'
  // };
  //UNUSED edtvoldemortyt@gmail.com

  var request = http.Request(
      'GET', Uri.parse('https://hapi-books.p.rapidapi.com/search/$Bookname'));
  request.body = json.encode({
    "username": "test_username",
    "email": "test@example.com",
    "emailVisibility": false,
    "password": "12345678",
    "passwordConfirm": "12345678",
    "name": "test"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = {};
    responseData["data"] = jsonDecode(await response.stream.bytesToString());
    responseData["isSuccess"] = true;
    log("got response");
    return responseData;
  } else {
    Map<String, dynamic> responseData = {};
    responseData["data"] = jsonDecode(await response.stream.bytesToString());
    responseData["isSuccess"] = false;
    log("response code : ${response.statusCode}");
    return responseData;
  }
}
