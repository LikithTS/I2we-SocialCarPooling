
import 'dart:collection';

class CPSessionManager{
  static final CPSessionManager _instance = CPSessionManager._internal();

  factory CPSessionManager() {
    return _instance;
  }

  CPSessionManager._internal() {

  }

  Set<int> categoryIds = HashSet();

  void saveSelectedCategoryIds(int id, bool selected) {
    selected ? categoryIds.add(id) : categoryIds.remove(id);
  }

  bool isCategoryItemsSelected(int id) {
    return categoryIds.contains(id);
  }

  void clearAllSelectedCategoryData(){
    categoryIds.clear();
  }

}