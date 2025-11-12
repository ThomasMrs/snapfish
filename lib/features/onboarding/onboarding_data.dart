class OnboardingData {
  final String title;
  final String description;
  final String imagePath;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

final onboardingItems = [
  OnboardingData(
    title: 'Capture your best catch',
    description:
        'Snap a photo of your fishing haul right after your trip and share it instantly.',
    imagePath: 'assets/images/fish1.png',
  ),
  OnboardingData(
    title: 'Share with friends',
    description:
        'Let your fishing buddies see your latest catch and celebrate with you.',
    imagePath: 'assets/images/fish2.png',
  ),
  OnboardingData(
    title: 'Discover and react',
    description:
        'Browse your friends’ catches and leave reactions on their posts.',
    imagePath: 'assets/images/fish3.png',
  ),
];
