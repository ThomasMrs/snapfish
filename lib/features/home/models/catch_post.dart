import 'package:flutter/material.dart';

enum ReactionType { fire, clap, wave, trophy }

extension ReactionTypeX on ReactionType {
  String get emoji {
    switch (this) {
      case ReactionType.fire:
        return '\u{1F525}';
      case ReactionType.clap:
        return '\u{1F44F}';
      case ReactionType.wave:
        return '\u{1F30A}';
      case ReactionType.trophy:
        return '\u{1F3C6}';
    }
  }

  String get label {
    switch (this) {
      case ReactionType.fire:
        return 'Brulant';
      case ReactionType.clap:
        return 'Bravo';
      case ReactionType.wave:
        return 'Vague';
      case ReactionType.trophy:
        return 'Trophee';
    }
  }
}

class CatchPost {
  CatchPost({
    required this.id,
    required this.anglerName,
    required this.location,
    required this.avatarInitials,
    required this.avatarColor,
    required this.catchTitle,
    required this.catchDescription,
    required this.imagePath,
    required this.caughtAt,
    required this.reactions,
    required this.tags,
    required this.species,
    this.weightKg,
    this.lengthCm,
    this.isAssetImage = true,
    this.isLive = false,
  });

  final String id;
  final String anglerName;
  final String location;
  final String avatarInitials;
  final Color avatarColor;
  final String catchTitle;
  final String catchDescription;
  final String imagePath;
  final DateTime caughtAt;
  final Map<ReactionType, int> reactions;
  final List<String> tags;
  final String species;
  final double? weightKg;
  final double? lengthCm;
  final bool isAssetImage;
  final bool isLive;

  CatchPost copyWith({
    Map<ReactionType, int>? reactions,
  }) {
    return CatchPost(
      id: id,
      anglerName: anglerName,
      location: location,
      avatarInitials: avatarInitials,
      avatarColor: avatarColor,
      catchTitle: catchTitle,
      catchDescription: catchDescription,
      imagePath: imagePath,
      caughtAt: caughtAt,
      reactions: reactions ?? this.reactions,
      tags: tags,
      species: species,
      weightKg: weightKg,
      lengthCm: lengthCm,
      isAssetImage: isAssetImage,
      isLive: isLive,
    );
  }
}
