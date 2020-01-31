
import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/MODEL/ONBOARDING/pageViewModel.dart';

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
      this.pages,
      this.activeIndex,
      this.slideDirection,
      this.slidePercent,
      );
}