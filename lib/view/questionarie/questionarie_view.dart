import 'package:common/network/model/QuestionarieCategory.dart';
import 'package:common/network/model/Subcategory.dart';
import 'package:common/utils/FileUtils.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/margin_confiq.dart';

import '../../util/CPSessionManager.dart';
import '../../util/CPString.dart';
import '../../util/color.dart';

class QuestionariePage extends StatefulWidget {
  const QuestionariePage({Key? key}) : super(key: key);

  @override
  State<QuestionariePage> createState() => _QuestionarieState();
}

class _QuestionarieState extends State<QuestionariePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  TextStyle tabStyle = TextStyleUtils.primaryTextBold.copyWith(fontSize: textsize16sp);
  List<Questionarie> categories = [];

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: categories.length, initialIndex: 0, vsync: this);
    fetchCategories();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void fetchCategories() async {
    List<Questionarie>? categoryList = await FileUtils.readQuestionariesData();
    _onCategoriesUpdated(categoryList!);
  }

  void _onCategoriesUpdated(dynamic val) {
    setState(() {
      categories = val;
      tabController.dispose();
      tabController = TabController(
          length: categories.length, initialIndex: 0, vsync: this);
    });
  }

  tabCreate() => CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            child: Column(children: [
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.black12,
                    elevation: 0,
                    toolbarHeight: 0,
                    bottom: TabBar(
                    unselectedLabelColor: tabUnSelectedTextColor,
                    labelColor: tabSelectedTextColor,
                    indicatorColor: tabIndicatorColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tabIndicatorColor),
                    labelStyle:
                        TextStyleUtils.primaryTextBold.copyWith(fontSize: textsize12sp),
                    unselectedLabelStyle: TextStyleUtils.primaryTextRegular
                        .copyWith(fontSize: textsize12sp),
                    controller: tabController,
                    isScrollable: true,
                    tabs: List<Widget>.generate(categories.length, (int index) {
                      return Tab(child: Text(categories[index].category!));
                    }),
                  ),
                  ),
                  body: TabBarView(
                      controller: tabController,
                      children: getSubCategories(categories)),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                color: Colors.white,
                padding: const EdgeInsets.only(top: 10, right: 24, bottom: 34),
                child: ElevatedButton(
                  onPressed: () {
                    handleOnContinuteButtonPressed();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: buttonBgColor,
                      padding: EdgeInsets.all(margin10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(margin10))),
                  child: Text(CPString.CONTINUE,
                      style:
                          tabStyle.copyWith(fontSize: textsize16sp, color: Colors.white)),
                ),
              )
            ]),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    TextStyle primaryTextBold =
        TextStyleUtils.primaryTextBold.copyWith(color: toolbarTitleColor, fontSize: textsize22sp);
    return Scaffold(
        appBar: AppBar(
            title: Text(CPString.QUESTIONARIES, style: primaryTextBold),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))),
        body: tabCreate());
  }

  getSubCategories(List<Questionarie> categories) {
    List<Widget> widgets = [];
    for (var element in categories) {
      List<Subcategory>? subcategories = element.subcategory;
      var wrap = Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.0,
            runSpacing: 8.0,
            children: List<Widget>.generate(
                subcategories!.length,
                (subIndex) => QuestionariChipSet(
                      subcategories: subcategories[subIndex],
                    )),
          ));
      widgets.add(wrap);
    }
    return widgets;
  }

  void handleOnContinuteButtonPressed() {
     //TODO: CALL API to push the selected items
    if(CPSessionManager().categoryIds.isEmpty){
      const snackBar = SnackBar(
        content: Text(CPString.ALERT_SELECT_ATLEAST_ONE_CATEGORY),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class QuestionariChipSet extends StatefulWidget {
  final Subcategory subcategories;

  const QuestionariChipSet({Key? key, required this.subcategories})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      QuestionariChipSetState(subcategories: subcategories);
}

class QuestionariChipSetState extends State<QuestionariChipSet> {
  final Subcategory subcategories;

  QuestionariChipSetState({required this.subcategories});

  chipNameText(String name, int id) => Text(
        name,
        style: TextStyleUtils.primaryTextRegular.copyWith(
            fontSize: textsize14sp,
            color: CPSessionManager().isCategoryItemsSelected(id)
                ? tabSelectedTextColor
                : tabUnSelectedTextColor),
      );

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: chipNameText(subcategories.name!, subcategories.id!),
      selectedColor: chipSetBGSelectedColor,
      disabledColor: chipSetBGUnSelectedColor,
      showCheckmark: false,
      selected: CPSessionManager().isCategoryItemsSelected(subcategories.id!),
      onSelected: (bool value) {
        setState(() {
          CPSessionManager().saveSelectedCategoryIds(subcategories.id!, value);
        });
      },
    );
  }
}
