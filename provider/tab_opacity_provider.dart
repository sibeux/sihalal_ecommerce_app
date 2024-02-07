import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabOpacitiyNotifier extends StateNotifier<double> {
  TabOpacitiyNotifier()
      : super(
          1, // initial state
        );

  void setOpacity() {
    state = 0.7;
  }
}

final tabOpacitiyProvider =
    StateNotifierProvider<TabOpacitiyNotifier, double>((ref) {
  return TabOpacitiyNotifier();
});
