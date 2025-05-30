// figma_coupon.dart
// This file represents the coupon list UI inspired by the Figma design.
import 'package:flutter/material.dart';

class FigmaCouponPage extends StatelessWidget {
  const FigmaCouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D3954),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D3954),
        elevation: 0,
        title: const Text('My Coupons'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.menu), onPressed: () {})
        ],
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _FigmaCouponCard(
                  logo: 'pictures/picture0.png',
                  title: ' 24 10',
                  brand: 'McDonalds',
                  valid: 'Valid until 01 February 2022',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CouponDetailPage(
                          logo: 'pictures/picture0.png',
                          title: ' 24 10',
                          brand: 'McDonalds',
                          valid: 'Valid until 01 February 2022',
                        ),
                      ),
                    );
                  },
                ),
                _FigmaCouponCard(
                  logo: 'pictures/picture1.png',
                  title: '25% OFF',
                  brand: 'KFC',
                  valid: 'Valid until 03 March 2022',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CouponDetailPage(
                          logo: 'pictures/picture1.png',
                          title: '25% OFF',
                          brand: 'KFC',
                          valid: 'Valid until 03 March 2022',
                        ),
                      ),
                    );
                  },
                ),
                _FigmaCouponCard(
                  logo: 'pictures/picture2.png',
                  title: '1 Free Coffee',
                  brand: 'Starbucks',
                  valid: 'Valid until 11 September 2022',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CouponDetailPage(
                          logo: 'pictures/picture2.png',
                          title: '1 Free Coffee',
                          brand: 'Starbucks',
                          valid: 'Valid until 11 September 2022',
                        ),
                      ),
                    );
                  },
                ),
                _FigmaCouponCard(
                  logo: 'pictures/picture3.png',
                  title: 'Pay 1 take 2',
                  brand: 'Vapiano',
                  valid: 'Valid until 03 October 2022',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CouponDetailPage(
                          logo: 'pictures/picture3.png',
                          title: 'Pay 1 take 2',
                          brand: 'Vapiano',
                          valid: 'Valid until 03 October 2022',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0D3954),
                shape: StadiumBorder(),
                minimumSize: Size(200, 48),
              ),
              onPressed: () {},
              child: const Text('Add new coupon'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FigmaCouponCard extends StatelessWidget {
  final String logo;
  final String title;
  final String brand;
  final String valid;
  final VoidCallback? onTap;

  const _FigmaCouponCard({
    required this.logo,
    required this.title,
    required this.brand,
    required this.valid,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: ClipPath(
          clipper: _FigmaCouponClipper(),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  child: Image.asset(logo, width: 48, height: 48, fit: BoxFit.contain),
                ),
                Container(
                  width: 1,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF0D3954))),
                        Text(brand, style: TextStyle(fontSize: 16, color: Color(0xFF0D3954))),
                        SizedBox(height: 8),
                        Text(valid, style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

class CouponDetailPage extends StatelessWidget {
  final String logo;
  final String title;
  final String brand;
  final String valid;

  const CouponDetailPage({
    required this.logo,
    required this.title,
    required this.brand,
    required this.valid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupon Details'),
        backgroundColor: const Color(0xFF0D3954),
      ),
      backgroundColor: const Color(0xFF0D3954),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(logo, width: 80, height: 80, fit: BoxFit.contain),
                const SizedBox(height: 16),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xFF0D3954))),
                Text(brand, style: const TextStyle(fontSize: 20, color: Color(0xFF0D3954))),
                const SizedBox(height: 16),
                Text(valid, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
