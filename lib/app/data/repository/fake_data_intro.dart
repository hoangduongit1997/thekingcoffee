import 'package:thekingcoffee/app/data/model/intro_slider.dart';
import 'package:thekingcoffee/app/data/repository/images.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

final List<IntroSlider> introSlide = [
  IntroSlider(
      title: allTranslations.text("title_tutorial_1").toString(),
      subtitle: allTranslations.text("subtitle_tutorial_1").toString(),
      icon: Images.introicon),
  IntroSlider(
      title: allTranslations.text("title_tutorial_2").toString(),
      subtitle: allTranslations.text("subtitle_tutorial_2").toString(),
      icon: null),
  IntroSlider(
      title: allTranslations.text("title_tutorial_3").toString(),
      subtitle: allTranslations.text("subtitle_tutorial_3").toString(),
      icon: null),
];
