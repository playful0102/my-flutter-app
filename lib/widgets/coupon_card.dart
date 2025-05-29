import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CouponCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String? extraInfo;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CouponCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.extraInfo,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ClipPath(
          clipper: CouponClipper(),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppTheme.backgroundColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                _buildDottedLine(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleMedium),
                      Text(description, style: Theme.of(context).textTheme.bodyMedium),
                      if (extraInfo != null) ...[
                        const SizedBox(height: 4),
                        Text(extraInfo!, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDottedLine() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 10,
      height: 60,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              10,
              (dotIndex) => SizedBox(
                width: 1,
                height: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppTheme.greyColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CouponClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double notchRadius = 10.0;
    final double midY = size.height / 2;
    final Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, midY - notchRadius);
    path.arcToPoint(
      Offset(size.width, midY + notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, midY + notchRadius);
    path.arcToPoint(
      Offset(0, midY - notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
} 