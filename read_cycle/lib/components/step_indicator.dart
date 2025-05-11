import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {

  final int currentPage;
  final int totalPages;

  const StepIndicator({
    super.key,
    required this.currentPage,
    this.totalPages = 6
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        bool isActive = (index == currentPage);
        return AnimatedContainer(
          duration: Duration(microseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: isActive ? 10.0 : 8.0,
          height: isActive ? 10.0 : 8.0,
          decoration: BoxDecoration(
            color: isActive ? const Color.fromARGB(255, 204, 159, 26) : Colors.grey,
            shape: BoxShape.circle
          ),
        );
      }),
    );
  }
}
