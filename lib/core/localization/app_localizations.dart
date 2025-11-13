import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = <String, Map<String, String>>{
    'en': <String, String>{
      'splash.tagline': 'Share your catches. Inspire your crew.',
      'onboarding.skip': 'Skip',
      'onboarding.start': 'Start',
      'onboarding.continue': 'Continue',
      'onboarding.letsGo': 'Let\'s go',
      'onboarding.title1': 'Capture your best catch',
      'onboarding.desc1': 'Snap a vibrant photo as soon as you dock to keep the moment alive.',
      'onboarding.title2': 'Share with your crew',
      'onboarding.desc2': 'Post instantly so your fishing buddies can react in real time.',
      'onboarding.title3': 'Discover and react',
      'onboarding.desc3': 'Scroll the SnapFish feed, send reactions, and plan the next session.',
      'login.subtitle': 'Share your best catches,\nreact to your crew\'s photos.',
      'login.prompt': 'What is your name?',
      'login.hint': 'Your name or nickname',
      'login.chip.private': 'Private crew',
      'login.chip.reactions': 'Instant reactions',
      'login.chip.stats': 'Catch statistics',
      'login.button': 'Enter SnapFish',
      'home.fab': 'New catch',
      'home.nav.feed': 'Feed',
      'home.nav.collect': 'Collection',
      'home.nav.profile': 'Profile',
      'home.feed.greeting': 'Hey {name}!',
      'home.feed.defaultName': 'Fish Friend',
      'home.feed.subtitle': 'Share your catches and cheer your crew.',
      'home.feed.section': 'Crew feed',
      'home.live.chip': 'Live now',
      'home.live.title1': 'Sunrise session',
      'home.live.location1': 'Arcachon Basin',
      'home.live.title2': 'Street fishing',
      'home.live.location2': 'Downtown Lille',
      'home.live.title3': 'Night carp quest',
      'home.live.location3': 'Blue Pond',
      'home.collect.title': 'Smart collection',
      'home.collect.description': 'Coming soon: sync your trips, save your spots, and analyse catches.',
      'home.collect.button': 'Notify me',
      'home.profile.subtitle': 'SnapFish crew',
      'home.badge.section': 'Crew & badges',
      'home.stats.catches': 'Catches',
      'home.stats.sessions': 'Sessions',
      'home.stats.reactions': 'Reactions',
      'home.badge.trophy': 'Trophy 2024',
      'home.badge.crew': 'Atlantic crew',
      'home.badge.night': 'Night session',
    },
    'fr': <String, String>{
      'splash.tagline': 'Partage tes prises. Inspire ton equipage.',
      'onboarding.skip': 'Passer',
      'onboarding.start': 'Commencer',
      'onboarding.continue': 'Continuer',
      'onboarding.letsGo': 'On y va',
      'onboarding.title1': 'Capture ta meilleure prise',
      'onboarding.desc1': 'Immortalise ta sortie avec une photo haute en couleur des que tu rentres au port.',
      'onboarding.title2': 'Partage avec ton crew',
      'onboarding.desc2': 'Publie instantanement pour que tes potes reagissent en direct.',
      'onboarding.title3': 'Decouvre et reagis',
      'onboarding.desc3': 'Surfe sur le fil SnapFish, laisse des reactions et prepare votre prochaine session.',
      'login.subtitle': 'Partage tes meilleures prises,\nreagis aux photos de ton equipage.',
      'login.prompt': 'Comment t\'appelles-tu ?',
      'login.hint': 'Ton prenom ou pseudo',
      'login.chip.private': 'Crew prive',
      'login.chip.reactions': 'Reactions instantanees',
      'login.chip.stats': 'Statistiques de prises',
      'login.button': 'Entrer dans SnapFish',
      'home.fab': 'Nouvelle prise',
      'home.nav.feed': 'Fil',
      'home.nav.collect': 'Collecte',
      'home.nav.profile': 'Profil',
      'home.feed.greeting': 'Salut {name} !',
      'home.feed.defaultName': 'Fish Friend',
      'home.feed.subtitle': 'Partage tes prises et felicite ton crew.',
      'home.feed.section': 'Fil de tes equipiers',
      'home.live.chip': 'En direct',
      'home.live.title1': 'Session lever de soleil',
      'home.live.location1': 'Bassin d\'Arcachon',
      'home.live.title2': 'Street fishing',
      'home.live.location2': 'Lille Centre',
      'home.live.title3': 'Carpe de nuit',
      'home.live.location3': 'Etang Bleu',
      'home.collect.title': 'Collecte intelligente',
      'home.collect.description': 'Bientot : synchronise tes sessions, enregistre tes spots et analyse tes prises.',
      'home.collect.button': 'Previens-moi',
      'home.profile.subtitle': 'Crew SnapFish',
      'home.badge.section': 'Crew et badges',
      'home.stats.catches': 'Prises',
      'home.stats.sessions': 'Sessions',
      'home.stats.reactions': 'Reactions',
      'home.badge.trophy': 'Trophee 2024',
      'home.badge.crew': 'Crew Atlantique',
      'home.badge.night': 'Session nocturne',
    },
  };

  String t(String key, {Map<String, String>? params}) {
    final languageCode = _localizedValues.containsKey(locale.languageCode) ? locale.languageCode : 'en';
    String? value = _localizedValues[languageCode]?[key] ?? _localizedValues['en']?[key];
    value ??= key;
    if (params != null) {
      params.forEach((String placeholder, String replacement) {
        value = value!.replaceAll('{$placeholder}', replacement);
      });
    }
    return value!;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (Locale supported) => supported.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
