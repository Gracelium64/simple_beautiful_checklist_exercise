import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  @override
  Future<void> addItem(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList('_items') ?? [];
    if (item.isNotEmpty && !currentList.contains(item)) {
    currentList.add(item);
      prefs.setStringList('_items', currentList);
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList('_items') ?? [];
    currentList.removeAt(index);
    prefs.remove('_items');
    prefs.setStringList('_items', currentList);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList('_items') ?? [];
    if (newItem.isNotEmpty && !currentList.contains(newItem)) {
      currentList[index] = newItem;
      prefs.remove('_items');
      prefs.setStringList('_items', currentList);
    }
  }

  @override
  Future<int> getItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('_items') != null) {
      return prefs.getStringList('_items')!.length;
    } else {
      return 0;
    }
  }

  @override
  Future<List<String>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList('_items');
    if (currentList != null) {
      return currentList;
    } else {
      return [];
    }
  }
}
