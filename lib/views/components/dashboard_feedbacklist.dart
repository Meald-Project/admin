import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> feedbackList = [
      {
        'image': 'https://via.placeholder.com/100',
        'name': 'Alice Dupont',
        'email': 'tassououertani123@gmail.com',
        'date': '1er Octobre 2023',
        'feedback': 'Excellent service, I am very satisfied!'
      },
      {
        'image': 'https://via.placeholder.com/100',
        'name': 'Jean Dupont',
        'email': 'jean@example.com',
        'date': '2 Octobre 2023',
        'feedback': 'Great experience, I will recommend it!'
      },
      // Add more feedback items if necessary...
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Text(
          "Retour des Clients",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: feedbackList.map((feedback) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0), // Space between each card
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9, // Set width to 90% of screen width
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Picture on one side
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(feedback['image']),
                            ),
                            const SizedBox(width: 10),
                            // Other elements on the other side
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        feedback['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.reply, color: Color.fromARGB(255, 48, 57, 64)),
                                        onPressed: () {
                                          _sendEmail(feedback['email'], context);
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    feedback['email'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    feedback['date'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8), // Space between row and feedback
                        Text(
                          feedback['feedback'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _sendEmail(String email, BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Feedback Reply',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Show a snackbar if no email client is available
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No email client installed."),
          ),
        );
      }
    } catch (e) {
      print("Error launching email: $e");
    }
  }
}
