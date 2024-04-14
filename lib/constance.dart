import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Constans {
  final BuildContext context;

  Constans(this.context);

  double get height => MediaQuery.of(context).size.height;

  double get width => MediaQuery.of(context).size.width;

  double get smallWidth => MediaQuery.of(context).size.width * 0.02;

  double get mediumWidth => MediaQuery.of(context).size.width * 0.02;

  double get largeWidth => MediaQuery.of(context).size.width * 0.04;

  double get smallHeight => MediaQuery.of(context).size.height * 0.018;

  double get mediumHeight => MediaQuery.of(context).size.height * 0.05;

  double get largeHeight => MediaQuery.of(context).size.height * 0.1;

  String? get fontFamily => GoogleFonts.inter().fontFamily;

  Color get brown => const Color(0xFF704F38);

  Color get lightBrown => const Color(0xFFeee5db);

  Color get black => const Color(0xFF1F2029);

  Color get grey => const Color(0xFF797979);

  Color get lightBlue => const Color(0xFF1f2029);

  Color get white => const Color(0xFFEDEDED);

  SizedBox get smallSizedsBoxHeight {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.009);
  }

  SizedBox get samllmediumSizedBoxHeight {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
  }

  SizedBox get mediumSizedBoxHeight {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.05);
  }

  SizedBox get largeSizedBoxHeight {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.1);
  }

  SizedBox get smallSizedBoxWidth {
    return SizedBox(width: MediaQuery.of(context).size.width * 0.02);
  }

  SizedBox get mediumSizedBoxWidth {
    return SizedBox(width: MediaQuery.of(context).size.width * 0.05);
  }

  SizedBox get largeSizedBoxWidth {
    return SizedBox(width: MediaQuery.of(context).size.width * 0.1);
  }
}

class SizeBoxSpaces {
  final BuildContext context;

  SizeBoxSpaces(this.context);
}
