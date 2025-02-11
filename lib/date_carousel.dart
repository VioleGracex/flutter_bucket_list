import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

class DateCarousel extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final CarouselController carouselController;

  DateCarousel({
    required this.selectedDate,
    required this.onDateSelected,
    required this.carouselController,
  });

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = List.generate(30, (index) => DateTime.now().subtract(Duration(days: index)));

    return Container(
      height: 100,
      child: CarouselSlider.builder(
        
        options: CarouselOptions(
          height: 100,
          autoPlay: false,
          enableInfiniteScroll: false,
          viewportFraction: 0.2,
          initialPage: dates.indexWhere((date) => DateFormat('yyyy-MM-dd').format(date) == DateFormat('yyyy-MM-dd').format(selectedDate)),
          onPageChanged: (index, reason) {
            onDateSelected(dates[index]);
          },
        ),
        itemCount: dates.length,
        itemBuilder: (context, index, realIndex) {
          final date = dates[index];
          String dayName = DateFormat('E').format(date);
          String dayNumber = DateFormat('d').format(date);
          bool isSelected = DateFormat('yyyy-MM-dd').format(date) == DateFormat('yyyy-MM-dd').format(selectedDate);

          return GestureDetector(
            onTap: () {
              onDateSelected(date);
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 5.0), // Gap between date boxes
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue[700] : Colors.grey[700],
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: isSelected
                      ? [Colors.blue[400]!, Colors.blue[700]!]
                      : [Colors.grey[400]!, Colors.grey[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayName,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dayNumber,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}