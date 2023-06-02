import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';

import '../../font&margin/margin_confiq.dart';


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
        SizedBox(height: margin60.h,),
        _buildBottomButtons(),

      ],
    );
  }

  bool get _isFinalPage => _currentPage == widget.pages.length - 1;

  Widget _buildBottomButtons() {
    return Container(
      padding:  EdgeInsets.all(margin8),
      margin: EdgeInsets.only(bottom: margin60,left: margin10,right: margin10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildNavIndicator(),
          SizedBox(height: margin64,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: _isFinalPage ? 0.0 : 1.0,
                child: _buildButton(CPString.skip, _gotoLastPage),
              ),
              _isFinalPage
                  ? _buildButton(CPString.done, widget.onIntroCompleted)
                  : _buildButton(CPString.next, _gotoNextPage),
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
        backgroundColor: title==CPString.skip?Colors.white:primaryColor,
        textStyle: TextStyleUtils.primaryTextRegular,
        side: title==CPString.skip?BorderSide(width: 1.0,color: borderColor):BorderSide(width:0,color: primaryColor),
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: margin12,right: margin12),
        child: Text(
          title,
         style: TextStyleUtils.primaryTextRegular.copyWith(color: title==CPString.skip?borderColor:Colors.white),
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
