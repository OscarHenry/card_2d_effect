import 'package:card_2d_effect/movie.dart';
import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  const CardItem({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem>
    with SingleTickerProviderStateMixin {
  late final Movie _movie;

  late AnimationController _controller;
  late bool isHover;

  @override
  void initState() {
    super.initState();
    _movie = widget.movie;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    isHover = false;
  }

  setIsHover(bool hover) {
    isHover = hover;
    if (isHover) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => MouseRegion(
        onEnter: (_) => setIsHover(true),
        onExit: (_) => setIsHover(false),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 450, maxWidth: 350),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: Stack(
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_movie.imageSrc),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
