import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingArticleWidget extends StatelessWidget {
  const LoadingArticleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Color widgetShimmerColor = Colors.grey.shade700;
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return LoadingItem(
            width: width, widgetShimmerColor: widgetShimmerColor);
      },
    );
  }
}

class LoadingItem extends StatelessWidget {
  const LoadingItem({
    super.key,
    required this.width,
    required this.widgetShimmerColor,
  });

  final double width;
  final Color widgetShimmerColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade400,
      child: SizedBox(
        height: 145,
        width: width,
        child: Container(
          padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 12),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: widgetShimmerColor),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: widgetShimmerColor,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: width,
                          decoration: BoxDecoration(
                              color: widgetShimmerColor,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 12,
                              width: 40,
                              color: widgetShimmerColor,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              height: 12,
                              width: 40,
                              color: widgetShimmerColor,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 12,
                                width: 40,
                                color: widgetShimmerColor,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
