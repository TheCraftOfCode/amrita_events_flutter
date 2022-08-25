import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class NotificationSkeletonWidget extends StatelessWidget {
  const NotificationSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
        child: SizedBox(
      height: 450,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20),
            child: Row(
              children: [
                Expanded(
                  child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 20,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
          ),
          const Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          )),
        ],
      ),
    ));
  }
}
