// figma_coupon_details.dart
// This file represents the coupon details UI inspired by the Figma design.
import 'package:flutter/material.dart';

class FigmaCouponDetailsPage extends StatelessWidget {
  final String logo;
  final String title;
  final String brand;
  final String description;
  final String valid;
  final String qrAsset;

  const FigmaCouponDetailsPage({
    super.key,
    required this.logo,
    required this.title,
    required this.brand,
    required this.description,
    required this.valid,
    required this.qrAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D3954),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D3954),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24.0),
          child: ClipPath(
            clipper: _FigmaCouponClipper(),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(logo, width: 48, height: 48, fit: BoxFit.contain),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF0D3954))),
                            Text(brand, style: TextStyle(fontSize: 16, color: Color(0xFF0D3954))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 16),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  SizedBox(height: 16),
                  Center(
                    child: Image.asset(qrAsset, width: 120, height: 120),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.open_in_new, color: Color(0xFF0D3954)),
                      Text(valid, style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Icon(Icons.info_outline, color: Color(0xFF0D3954)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF0D3954),
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _FigmaCouponClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double notchRadius = 14.0;
    double midY = size.height / 2;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, midY - notchRadius);
    path.arcToPoint(
      Offset(size.width, midY + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, midY + notchRadius);
    path.arcToPoint(
      Offset(0, midY - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(0, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
