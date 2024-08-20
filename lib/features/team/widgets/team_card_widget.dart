import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/team_member_controller.dart';
import '../models/team_member_model.dart';



class TeamCardWidget extends StatelessWidget {
  final TeamMember teamMember;
  final TeamMemberController controller = Get.put(TeamMemberController());

  TeamCardWidget({
    super.key,
    required this.teamMember,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(teamMember.image),
                backgroundColor: Colors.transparent, // Optional: Add a background color
              ),
              const SizedBox(height: 10),
              Text(
                teamMember.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                teamMember.title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF970032),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () {
                      controller.makePhoneCall(teamMember.phone);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.email_outlined),
                    onPressed: () {
                      controller.copyEmailToClipboard(teamMember.email);
                    },
                  ),
                  if (teamMember.linkedinProfileUrl != null &&
                      teamMember.linkedinProfileUrl!.isNotEmpty)
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () {
                        controller.launchUrlInApp(teamMember.linkedinProfileUrl!);
                      },
                    ),
                  if (teamMember.githubProfileUrl != null &&
                      teamMember.githubProfileUrl!.isNotEmpty)
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.github),
                      onPressed: () {
                        controller.launchUrlInApp(teamMember.githubProfileUrl!);
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
