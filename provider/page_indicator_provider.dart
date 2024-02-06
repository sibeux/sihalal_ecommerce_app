import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageIndicatorProvider extends StateNotifier<int>{
  PageIndicatorProvider() : super(0);

  void setPage(int index){
    state = (index);
  }
}

final counterProvider = StateNotifierProvider<PageIndicatorProvider, int>((ref) {
  return PageIndicatorProvider();
});
