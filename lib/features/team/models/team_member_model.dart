class TeamMember {
  final String image;
  final String name;
  final String title;
  final String email;
  final String phone;
  final String? githubProfileUrl;
  final String? linkedinProfileUrl;

  TeamMember({
    required this.phone,
    required this.image,
    required this.name,
    required this.title,
    required this.email,
    this.githubProfileUrl,
    this.linkedinProfileUrl,
  });
}
