import 'package:flutter_test1/pages/guidePage/TPIImage.dart';
import 'package:flutter_test1/pages/guidePage/TPIString.dart';
import 'package:flutter_test1/pages/guidePage/TPIWalkThroughData.dart';

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
