import 'package:flutter/material.dart';
import './utils.dart';

const goldenRatio = 1.61803399;
const defaultCardMargin = 16.0;

class AnimatedCardsCarousel extends StatefulWidget {
  const AnimatedCardsCarousel(
      {super.key,
      this.cardAspectRatio,
      this.cardMargin,
      required this.cardsList});

  final double? cardAspectRatio;
  final double? cardMargin;
  final List<Widget> cardsList;

  @override
  State<AnimatedCardsCarousel> createState() => _AnimatedCardsCarouselState();
}

class _AnimatedCardsCarouselState extends State<AnimatedCardsCarousel>
    with TickerProviderStateMixin {
  late ScrollController scrollController;
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        setState(() {
          scrollOffset = scrollController.offset;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (_, constraints) {
        return ListView.builder(
          controller: scrollController,
          itemBuilder: (_, index) {
            return _AnimatedCard(
              index: index,
              scrollOffset: scrollController.offset,
              viewportHeight: constraints.maxHeight,
              cardWidth: constraints.maxWidth,
              cardAspectRatio: widget.cardAspectRatio ?? goldenRatio,
              cardMargin: widget.cardMargin ?? defaultCardMargin,
              card: widget.cardsList[index],
            );
          },
          itemCount: widget.cardsList.length,
        );
      }),
    );
  }
}

class _AnimatedCard extends StatelessWidget {
  final int index;
  final double scrollOffset;
  final double viewportHeight;
  final double cardAspectRatio;
  final double cardWidth;
  final double cardMargin;
  final Widget card;

  const _AnimatedCard(
      {required this.index,
      required this.scrollOffset,
      required this.viewportHeight,
      required this.card,
      required this.cardAspectRatio,
      required this.cardWidth,
      required this.cardMargin});

  @override
  Widget build(BuildContext context) {
    double cardHeight = (cardWidth / cardAspectRatio) + cardMargin * 2;
    double position = (index) * cardHeight - scrollOffset;

    // Define the different positional states for the animation
    double isDisappearing = -cardHeight;
    double isTop = 0;
    double isBottom = viewportHeight - cardHeight;
    double isAppearing = viewportHeight;

    // Calculate the transformation values
    double translateY = getInterpolateY(
        scrollOffset, index, cardHeight, position, isBottom, isAppearing);
    double scale = getAnimatedScale(
        position, isDisappearing, isTop, isBottom, isAppearing);
    double opacity = getAnimatedOpacity(
        position, isDisappearing, isTop, isBottom, isAppearing);

    return Container(
      margin: EdgeInsets.symmetric(vertical: cardMargin),
      child: Transform.translate(
        offset: Offset(
          0,
          translateY,
        ),
        child: Center(
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: SizedBox(
                height: cardWidth / cardAspectRatio,
                width: cardWidth,
                child: card,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
