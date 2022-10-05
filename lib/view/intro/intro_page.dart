import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/util/color.dart';

import '../../util/margin_confiq.dart';


class IntroPage extends StatefulWidget {
  final List<Widget> pages;
  final VoidCallback onIntroCompleted;

  const IntroPage({
    Key? key,
    required this.pages,
    required this.onIntroCompleted,
  })  : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController? _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _currentPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NotificationListener<ScrollEndNotification>(
          onNotification: (x) {
            setState(() {
              _currentPage = _pageController!.page!.round();
            });
            return false;
          },
          child: Container(
            color: Colors.white,
            child: PageView(
              children: widget.pages,
              controller: _pageController,
            ),
          ),
        ),
        SizedBox(height: 60.h,),
        _buildBottomButtons(),

      ],
    );
  }

  bool get _isFinalPage => _currentPage == widget.pages.length - 1;

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 60,left: 10,right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildNavIndicator(),
          SizedBox(height: 63,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: _isFinalPage ? 0.0 : 1.0,
                child: _buildButton("Skip", _gotoLastPage),
              ),
              _isFinalPage
                  ? _buildButton("Done", widget.onIntroCompleted)
                  : _buildButton("Next", _gotoNextPage),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String title, VoidCallback callback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(margin10)
          ),
        ), // <-- Radius
        primary: title=='Skip'?Colors.white:primaryLightColor,
        textStyle: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'assets/fonts/poppins_medium.ttf'),
        side: title=='Skip'?BorderSide(width: 1.0,color: borderColor):BorderSide(width:0,color: primaryLightColor),
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 12,right: 12),
        child: Text(
          title,
          style: TextStyle(color: title=='Skip'?borderColor:Colors.white,decoration: TextDecoration.none,fontFamily: 'assets/fonts/poppins_medium.ttf'),
        ),
      ),
      onPressed: callback,
    );
  }


  void _gotoLastPage() {
    _pageController!.animateToPage(
      widget.pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  void _gotoNextPage() {
    _pageController!.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildNavIndicator() {
    final indicatorList = <Widget>[];
    for (int i = 0; i < widget.pages.length; i++)
      indicatorList.add(_buildIndicator(i == _currentPage));
    return Row(mainAxisAlignment: MainAxisAlignment.center,
        children: indicatorList);
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: isActive?primaryColor:Colors.transparent,
          border: Border.all(
              width: 1.0,color:isActive?Colors.transparent:borderColor
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(5.0)
          ),
        ),
        child: Align(
          alignment: Alignment.center,
            child: SizedBox(width: 22.w,height: 10.h,)),
    );
  }
}
