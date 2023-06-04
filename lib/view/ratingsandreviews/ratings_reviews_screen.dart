import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/color.dart';
import '../../util/Localization.dart';
import '../../widgets/widget_text.dart';

class RatingsAndReviews extends StatelessWidget {
  const RatingsAndReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    headerText(DemoLocalizations.of(context)
                            ?.getText("ratings_and_reviews") ??
                        "")
                  ],
                ),
                addVerticalSpace(20),
                CircleAvatar(
                  radius: size.width / 3,
                  backgroundColor: lightGreyColor,
                  backgroundImage: NetworkImage(
                      CPSessionManager().getProfileImageWithBase()),
                ),
                addVerticalSpace(5),
                ratingsAndReviewsCenterText("User Name", primaryColor, 26.sp,
                    FontWeight.normal, Alignment.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ratingsAndReviewsCenterText("Designation", greyColor,
                        14.sp, FontWeight.normal, Alignment.center),
                    addHorizontalSpace(20),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    ratingsAndReviewsCenterText("4.5", greyColor, 15.sp,
                        FontWeight.normal, Alignment.center),
                  ],
                ),
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ratingsAndReviewsCenterText("Recent Reviews",
                      greyColor, 18.sp, FontWeight.w600, Alignment.topLeft),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  height: size.height / 3,
                  width: double.maxFinite,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 1,
                                      ),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: lightGreyColor,
                                        backgroundImage: NetworkImage(
                                            CPSessionManager()
                                                .getProfileImageWithBase()),
                                      ),
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      size: 22,
                                      color: primaryColor,
                                    )
                                  ],
                                ),
                              ),
                              ratingsAndReviewsCenterText(
                                  "Co-rider name",
                                  greyColor,
                                  18.sp,
                                  FontWeight.normal,
                                  Alignment.centerLeft)
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                itemSize: 20,
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              ratingsAndReviewsCenterText(
                                  "09/08/22",
                                  greyColor,
                                  14.sp,
                                  FontWeight.normal,
                                  Alignment.topLeft)
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                          child: ratingsAndReviewsCenterText(
                              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis",
                              greyColor,
                              10.sp,
                              FontWeight.normal,
                              Alignment.topLeft),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget ratingsAndReviewsCenterText(String? title, Color color, double size,
        FontWeight fontWeight, Alignment alignment) =>
    Container(
      child: Align(
        alignment: alignment,
        child: Text(title!,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: size,
                decoration: TextDecoration.none,
                color: color,
                fontWeight: fontWeight,
                fontFamily: 'Poppins')),
      ),
    );

Widget rruserNameText(String title) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    child: Align(
      child: Text(title,
          style: TextStyle(
              fontSize: 26.sp,
              decoration: TextDecoration.none,
              color: primaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins')),
    ));

Widget workText(String title) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    child: Align(
      child: Text(title,
          style: TextStyle(
              fontSize: 20.sp,
              decoration: TextDecoration.none,
              color: const Color(0Xff242134),
              fontWeight: FontWeight.w200,
              fontFamily: 'Poppins')),
    ));

Widget progressTextBlack(String title, double fontSize, Color color) =>
    Container(
        child: Align(
      child: Text(title,
          softWrap: false,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: fontSize,
              decoration: TextDecoration.none,
              color: color,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins')),
    ));
Widget profileText(String title, double fontSize, Color color) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    child: Align(
      child: Text(title,
          softWrap: false,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: fontSize,
              decoration: TextDecoration.none,
              color: color,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins')),
    ));
