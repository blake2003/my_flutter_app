import 'package:flutter_test1/Pages/GuidePage/tpi_string.dart';

import 'tpi_image.dart';
import 'tpi_walkthrough_data.dart';

List<TPIWalkThroughData> tpiWalkThroughDataList() {
  List<TPIWalkThroughData> list = [];
  list.add(TPIWalkThroughData(
      imagePath: tpiSlideOneIc,
      title: tpiSlideOneTitle,
      subtitle: tpiSlideOneSubtitle));
  list.add(TPIWalkThroughData(
      imagePath: tpiSlideTwoIc,
      title: tpiSlideTwoTitle,
      subtitle: tpiSlideTwoSubtitle));
  list.add(TPIWalkThroughData(
      imagePath: tpiSlideThreeIc,
      title: tpiSlideThreeTitle,
      subtitle: tpiSlideThreeSubtitle));
  return list;
}
