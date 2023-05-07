import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BookCard extends StatelessWidget {
  String title;
  String author;
  String rating;
  String imageUrl;
  String openLink;
  bool showClose;
  bool? showSave;
  void Function()? onClose;
  void Function()? onOpen;
  void Function()? onSave;

  BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.rating,
    required this.imageUrl,
    required this.openLink,
    required this.showClose,
    required this.onClose,
    required this.onOpen,
    required this.onSave,
    this.showSave,
  });

  @override
  Widget build(BuildContext context) {
    var ScreenDimensions = MediaQuery.of(context).size;

    return Container(
      height: ScreenDimensions.height * (158 / 844),
      width: ScreenDimensions.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffC5EAFF),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: ScreenDimensions.height * (140 / 844),
              width: ScreenDimensions.width * (120 / 390),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),
                color: Color(0xff00A3FF),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
              // child: Placeholder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.length > MediaQuery.of(context).size.width * (16 / 390)
                      ? title.substring(
                              0,
                              (MediaQuery.of(context).size.width * (16 / 390))
                                  .round()) +
                          "..."
                      : title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    // overflow: TextOverflow.fade,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Rating ${rating == "null" ? 0 : rating}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: onOpen,
                        child: Container(
                          width: ScreenDimensions.width * (80 / 390),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color(0xff00A3FF),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Text(
                                "Open",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenDimensions.width * (8 / 390)),
                      Visibility(
                        visible: showSave ?? true,
                        child: InkWell(
                          onTap: onSave,
                          child: Container(
                            width: ScreenDimensions.width * (80 / 390),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xfff26C6C),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Visibility(
            visible: showClose,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: InkWell(
                onTap: onClose,
                child: Icon(
                  Icons.close,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}
