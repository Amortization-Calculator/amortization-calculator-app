import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          borderRadius: BorderRadius.circular(15.r),
        ),
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60.r,
                backgroundImage: AssetImage(teamMember.image),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 10.h),
              Text(
                teamMember.name,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                teamMember.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color(0xFF970032),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.phone,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      controller.makePhoneCall(teamMember.phone);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.email_outlined,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      controller.copyEmailToClipboard(teamMember.email);
                    },
                  ),
                  if (teamMember.linkedinProfileUrl != null &&
                      teamMember.linkedinProfileUrl!.isNotEmpty)
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: 24.sp,
                      ),
                      onPressed: () {
                        controller.launchUrlInApp(teamMember.linkedinProfileUrl!);
                      },
                    ),
                  if (teamMember.githubProfileUrl != null &&
                      teamMember.githubProfileUrl!.isNotEmpty)
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        size: 24.sp,
                      ),
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
