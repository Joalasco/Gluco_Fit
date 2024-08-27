import 'package:flutter/material.dart';

class RatingView extends StatefulWidget {
  final Function(int rating, String feedback) onSubmit;

  RatingView({required this.onSubmit});

  @override
  _RatingViewState createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  int _selectedRating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate our App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('How would you rate our app?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    _selectedRating > index ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                );
              }),
            ),
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Leave your feedback (optional)',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSubmit(_selectedRating, _feedbackController.text);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
