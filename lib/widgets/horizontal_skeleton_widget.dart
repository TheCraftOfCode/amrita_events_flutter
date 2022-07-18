
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HorizontalSkeletonWidget extends StatelessWidget {
  const HorizontalSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          height: (MediaQuery.of(context).size.height * 0.7) / 2,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          spacing: 30,
                          lineStyle: SkeletonLineStyle(
                            randomLength: false,
                            height: 18,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              Expanded(
                child: PageView.builder(
                  padEnds: false,
                  controller: PageController(viewportFraction: 0.4),
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  width: double.infinity,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                        SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                              lines: 1,
                              spacing: 30,
                              lineStyle: SkeletonLineStyle(
                                randomLength: true,
                                height: 14,
                                borderRadius: BorderRadius.circular(8),
                                minLength:
                                MediaQuery.of(context).size.width / 2,
                              )),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SkeletonParagraph(
                                style: SkeletonParagraphStyle(
                                    lines: 1,
                                    spacing: 0,
                                    lineStyle: SkeletonLineStyle(
                                      randomLength: false,
                                      height: 10,
                                      borderRadius: BorderRadius.circular(8),
                                      minLength:
                                      MediaQuery.of(context).size.width / 2,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}