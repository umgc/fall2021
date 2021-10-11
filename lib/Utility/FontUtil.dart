import 'package:untitled3/Model/Setting.dart';

double fontSizeToPixelMap(FontSize fontSize) {
  switch (fontSize) {
    case FontSize.SMALL:
      {
        return 18.0;
      }
    case FontSize.MEDIUM:
      {
        return 22.0;
      }
    case FontSize.LARGE:
      {
        return 28.0;
      }
    default:
      {
        return fontSizeToPixelMap(FontSize.MEDIUM);
      }
  }
}
