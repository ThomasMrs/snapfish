import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../models/catch_post.dart';

final List<CatchPost> mockCatches = [
  CatchPost(
    id: 'catch-001',
    anglerName: 'Lea',
    location: "Lac d'Annecy",
    avatarInitials: 'LE',
    avatarColor: AppColors.accent,
    catchTitle: 'Brochet de 85 cm',
    catchDescription: 'Premier brochet de la saison, relache apres la photo.',
    imagePath: 'lib/assets/images/fish.png',
    caughtAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 18)),
    reactions: {
      ReactionType.fire: 8,
      ReactionType.wave: 5,
      ReactionType.clap: 12,
    },
    tags: const ['Catch & Release', 'Leurre souple', 'Matin brumeux'],
    isLive: true,
  ),
  CatchPost(
    id: 'catch-002',
    anglerName: 'Noe',
    location: 'Golfe de Gascogne',
    avatarInitials: 'NO',
    avatarColor: Colors.deepOrangeAccent,
    catchTitle: 'Bar de ligne',
    catchDescription: "Sortie sunset parfaite, fish remis a l'eau.",
    imagePath: 'lib/assets/images/fish2.jpg',
    caughtAt: DateTime.now().subtract(const Duration(hours: 5, minutes: 43)),
    reactions: {
      ReactionType.fire: 5,
      ReactionType.wave: 4,
      ReactionType.clap: 7,
    },
    tags: const ['Sunset', 'Bar', 'Ocean'],
  ),
  CatchPost(
    id: 'catch-003',
    anglerName: 'Yuna',
    location: 'Etang du Moulin',
    avatarInitials: 'YU',
    avatarColor: Colors.purpleAccent,
    catchTitle: 'Carpe miroir 12 kg',
    catchDescription: 'Combattue pendant 20 min, merci les potes pour les photos !',
    imagePath: 'lib/assets/images/fish3.png',
    caughtAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    reactions: {
      ReactionType.fire: 12,
      ReactionType.trophy: 9,
      ReactionType.clap: 14,
    },
    tags: const ['Session nuit', 'Team SnapFish'],
  ),
  CatchPost(
    id: 'catch-004',
    anglerName: 'Rayan',
    location: 'Port de Marseille',
    avatarInitials: 'RA',
    avatarColor: Colors.lightGreenAccent,
    catchTitle: 'Merou surprise',
    catchDescription: 'Retour de plongee, le merou a pose comme une star.',
    imagePath: 'lib/assets/images/fish2.jpg',
    caughtAt: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
    reactions: {
      ReactionType.wave: 6,
      ReactionType.clap: 11,
    },
    tags: const ['Plongee', 'Mediterranee'],
  ),
];
