import 'package:flutter/material.dart';

class MenuItem1 extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem1(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.cyan,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
