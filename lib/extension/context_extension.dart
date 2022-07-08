import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;
  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;

  double appBarWidth(double value) => MediaQuery.of(this).size.width * 0.12;

  double contextWidth() => MediaQuery.of(this).size.width;
  double contextHeight() => MediaQuery.of(this).size.height;

  double contextQuizProgress() => (MediaQuery.of(this).size.width) / 10;


  double contextProgressBarWidth(double value) {
    return contextQuizProgress() * value;
  }

  double contextProgressBarWidthGrey(double value) {
    return contextQuizProgress() * (10-value);
  }


}
