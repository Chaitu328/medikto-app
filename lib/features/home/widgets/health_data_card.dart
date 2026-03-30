import 'package:flutter/material.dart';

class HealthDataCard extends StatefulWidget {
  final String? title;
  final String? image;
  final GestureTapCallback? onTap;
  const HealthDataCard({super.key, this.image, this.onTap, this.title});

  @override
  State<HealthDataCard> createState() => _HealthDataCardState();
}

class _HealthDataCardState extends State<HealthDataCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap?.call(),
      child: Container(
        padding: EdgeInsets.all(12),
        height: 86,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFCCCCCC).withAlpha(50),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.image ?? "", height: 24, width: 24),
            SizedBox(width: MediaQuery.sizeOf(context).height * 0.01),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263238),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  Row(
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: Color(0xFF213598),
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF213598),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
