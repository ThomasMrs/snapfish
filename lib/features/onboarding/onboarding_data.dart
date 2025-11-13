class OnboardingData {
  final String titleKey;
  final String descriptionKey;
  final String imagePath;

  OnboardingData({
    required this.titleKey,
    required this.descriptionKey,
    required this.imagePath,
  });
}

final onboardingItems = [
  OnboardingData(
    titleKey: 'onboarding.title1',
    descriptionKey: 'onboarding.desc1',
    imagePath: 'lib/assets/images/fish.png',
  ),
  OnboardingData(
    titleKey: 'onboarding.title2',
    descriptionKey: 'onboarding.desc2',
    imagePath: 'lib/assets/images/fish2.jpg',
  ),
  OnboardingData(
    titleKey: 'onboarding.title3',
    descriptionKey: 'onboarding.desc3',
    imagePath: 'lib/assets/images/fish3.png',
  ),
];
