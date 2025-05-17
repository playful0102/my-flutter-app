import 'package:flutter/material.dart';
import 'coupon_details.dart';

class HomePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search coupon...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 4, // Replace with your data length
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CouponDetailsPage(
                            couponIndex: index,
                            title: 'Picture $index',
                            description: 'Description $index',
                            extraInfo: 'This is an extra line under the subtitle.',
                          ),
                        ),
                      );
                    },
                    child: ClipPath(
                      clipper: CouponClipper(),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'pictures/picture$index.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                            // Dotted line separator
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 10,
                              height: 60,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Flex(
                                    direction: Axis.vertical,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      10,
                                      (index) => SizedBox(
                                        width: 1,
                                        height: 4,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Picture $index', style: Theme.of(context).textTheme.titleMedium),
                                  Text('Description $index', style: Theme.of(context).textTheme.bodySmall),
                                  SizedBox(height: 4),
                                  Text('This is an extra line under the subtitle.', style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Add this class to the same file:
class CouponClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double notchRadius = 10.0; // Radius for semi-circle notches
    double midY = size.height / 2; // Middle of the height for notch placement
    Path path = Path();

    // Start at the top-left corner
    path.moveTo(0, 0);

    // Top edge to top-right corner
    path.lineTo(size.width, 0);

    // Right edge to just above the right notch
    path.lineTo(size.width, midY - notchRadius);

    // Right semi-circle notch (inward, centered)
    path.arcToPoint(
      Offset(size.width, midY + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false, // Counter-clockwise for inward curve
    );

    // Right edge to bottom-right corner
    path.lineTo(size.width, size.height);

    // Bottom edge to bottom-left corner
    path.lineTo(0, size.height);

    // Left edge to just below the left notch
    path.lineTo(0, midY + notchRadius);

    // Left semi-circle notch (inward, centered)
    path.arcToPoint(
      Offset(0, midY - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false, // Counter-clockwise for inward curve
    );

    // Left edge back to top-left corner
    path.lineTo(0, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

