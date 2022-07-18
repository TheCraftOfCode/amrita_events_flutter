
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class StarCardSkeletonWidget extends StatelessWidget {
  const StarCardSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
        child: SizedBox(
          height: 350,
          child: Column(
            children: [
              const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          width: double.infinity,
                          height: double.infinity,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  )),
              Row(
                children: [
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 14,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                  ),
                  Expanded(child: Container())
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 2,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 10,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: SizedBox(
                      height: 40,
                      child: SkeletonItem(
                        child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 80),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}