import 'package:ai_text_extracter/model/bussiness_card.dart';
import 'package:ai_text_extracter/services/card_services.dart';
import 'package:flutter/material.dart';

class SavedCardView extends StatelessWidget {
  const SavedCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BusinessCard>>(
      future: CardServices.getAllSavedCards(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return const Center(child: Text('No business cards found.'));
        } else {
          List<BusinessCard> businessCards = snapshot.data;
          return ListView.builder(
            itemCount: businessCards.length,
            itemBuilder: (context, index) {
              BusinessCard card = businessCards[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Column(
                    children: [
                      Image.memory(
                        height: MediaQuery.of(context).size.height * .25,
                        width: MediaQuery.of(context).size.width * 1,
                        card.image,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        card.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      viewCardData(dataTitle: 'Name', cardData: card.name),
                      viewCardData(dataTitle: 'Email', cardData: card.eMail),
                      viewCardData(
                          dataTitle: 'Phone', cardData: card.phoneNumber),
                      viewCardData(
                          dataTitle: 'Website', cardData: card.website),
                      viewCardData(
                          dataTitle: 'Address', cardData: card.address),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget viewCardData({required String dataTitle, required String cardData}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Text(
        '$dataTitle: $cardData',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
