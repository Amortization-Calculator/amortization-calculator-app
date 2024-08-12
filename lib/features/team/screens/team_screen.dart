import 'package:amortization_calculator/widgets/custom_appBar_widget.dart';
import 'package:amortization_calculator/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/title_widget.dart';
import '../models/team_member_model.dart';
import '../widgets/team_card_widget.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TitleWidget(
                firstText: 'Meet out ',
                secondText: 'Team',
                fontSize: 24,
              ),
              const CustomDividerWidget(),
              TeamCardWidget(
                teamMember: TeamMember(
                  name: 'Mostafa Siam',
                  image: 'lib/assets/non.png',
                  title: 'Product Manager',
                  email: 'siam_mostafa@hotmail.com',
                ),
              ),
              TeamCardWidget(
                teamMember: TeamMember(
                  name: 'Omar Kenawi',
                  image: 'lib/assets/omarKenawi.png',
                  title: 'Mobile Developer',
                  email: 'omar.sseeddeekk@gmail.com',
                  githubProfileUrl: 'https://github.com/omarKenawi',
                  linkedinProfileUrl: 'https://www.linkedin.com/in/omar-kenawi/',
                ),
              ),
              TeamCardWidget(
                teamMember: TeamMember(
                  name: 'Abdallah Mohamed',
                  image: 'lib/assets/beso.png',
                  title: 'Back End Developer',
                  email: 'abdallah.moh.153@gmail.com',
                  githubProfileUrl: 'https://github.com/Abdallah85',
                  linkedinProfileUrl: 'https://www.linkedin.com/in/abdallah-mmohamed/',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
