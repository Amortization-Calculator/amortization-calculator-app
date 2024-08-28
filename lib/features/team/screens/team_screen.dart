import 'package:amortization_calculator/widgets/custom_appBar_widget.dart';
import 'package:amortization_calculator/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            children: [
              TitleWidget(
                firstText: 'Meet Our ',
                secondText: 'Team',
                fontSize: 20.sp,
              ),
              SizedBox(height: 20.h),
              CustomDividerWidget(),
              SizedBox(height: 20.h),
              TeamCardWidget(
                teamMember: TeamMember(
                  name: 'Mostafa Siam',
                  phone: '+201022216219',
                  image: 'lib/assets/mostafa.png',
                  title: 'Product Owner',
                  email: 'siam_mostafa@hotmail.com',
                  linkedinProfileUrl: 'https://www.linkedin.com/in/mostafa-siam-184b53109?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_view_base_contact_details%3BpFtbbhFLQ6muy%2FncFg9FRw%3D%3D',
                ),
              ),
              SizedBox(height: 20.h),
              TeamCardWidget(
                teamMember: TeamMember(
                  name: 'Omar Kenawi',
                  phone: '+201283667973',
                  image: 'lib/assets/omarKenawi.png',
                  title: 'Mobile Developer',
                  email: 'omar.sseeddeekk@gmail.com',
                  githubProfileUrl: 'https://github.com/omarKenawi',
                  linkedinProfileUrl: 'https://www.linkedin.com/in/omar-kenawi/',
                ),
              ),
              SizedBox(height: 20.h),
              TeamCardWidget(
                teamMember: TeamMember(
                  name: 'Abdallah Mohamed',
                  phone: '+201100764196',
                  image: 'lib/assets/beso.png',
                  title: 'Backend Developer',
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
