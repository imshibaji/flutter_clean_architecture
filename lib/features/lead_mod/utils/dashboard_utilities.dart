import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

SizedBox balanceCard({
  String assetsImageName = 'balance.svg',
  Color color = Colors.amber,
  String title = 'Balance',
  String amount = '1,000.00',
}) {
  return SizedBox(
    height: 100,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          color: color,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/' + assetsImageName,
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 34,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 34,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Expanded ieCard({
  String assetsImageName = 'expense.svg',
  Color color = Colors.amber,
  String title = 'Income',
  String amount = '1,000.00',
}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          color: color,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/' + assetsImageName,
              width: 60,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black87,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 34,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

InkWell shortcutButton({
  IconData? prefixIcon,
  Color color = const Color.fromARGB(255, 233, 11, 107),
  String title = 'New Leads',
  int pins = 0,
  void Function()? onPress,
}) {
  return InkWell(
    onTap: () => onPress!(),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              prefixIcon ?? Icons.groups_outlined,
              size: 34,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(radius: 25, backgroundColor: Colors.white),
                Text(
                  pins.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
