import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import 'data/mock_catches.dart';
import 'models/catch_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.displayName});

  final String displayName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final Map<String, ReactionType> _userReactions = {};

  void _onReaction(String postId, ReactionType reaction) {
    setState(() {
      if (_userReactions[postId] == reaction) {
        _userReactions.remove(postId);
      } else {
        _userReactions[postId] = reaction;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: _selectedIndex == 0
            ? FloatingActionButton.extended(
                key: const ValueKey('feed-fab'),
                onPressed: () {},
                icon: const Icon(Icons.add_a_photo_rounded),
                label: Text(l10n.t('home.fab')),
              )
            : const SizedBox.shrink(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: NavigationBar(
            height: 72,
            backgroundColor: AppColors.surface.withOpacityCompat(0.94),
            indicatorColor: AppColors.accent.withOpacityCompat(0.12),
            selectedIndex: _selectedIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.dynamic_feed_outlined),
                selectedIcon: const Icon(Icons.dynamic_feed_rounded),
                label: l10n.t('home.nav.feed'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.auto_awesome_mosaic_outlined),
                selectedIcon: const Icon(Icons.auto_awesome_mosaic_rounded),
                label: l10n.t('home.nav.collect'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person),
                label: l10n.t('home.nav.profile'),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 260),
          child: _selectedIndex == 0
              ? _FeedView(
                  displayName: widget.displayName,
                  userReactions: _userReactions,
                  onReaction: _onReaction,
                )
              : _selectedIndex == 1
                  ? const _CollectView()
                  : _ProfileView(displayName: widget.displayName),
        ),
      ),
    );
  }
}

class _FeedView extends StatelessWidget {
  const _FeedView({
    required this.displayName,
    required this.userReactions,
    required this.onReaction,
  });

  final String displayName;
  final Map<String, ReactionType> userReactions;
  final void Function(String, ReactionType) onReaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final friendlyName = displayName.isEmpty ? l10n.t('home.feed.defaultName') : displayName;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
      physics: const BouncingScrollPhysics(),
      children: [
        _GreetingCard(name: friendlyName),
        const SizedBox(height: 24),
        _LiveTripsCarousel(),
        const SizedBox(height: 24),
        Text(
          l10n.t('home.feed.section'),
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        ...mockCatches.map(
          (post) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _CatchCard(
              post: post,
              selectedReaction: userReactions[post.id],
              onReaction: (reaction) => onReaction(post.id, reaction),
            ),
          ),
        ),
      ],
    );
  }
}

class _GreetingCard extends StatelessWidget {
  const _GreetingCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceAlt, AppColors.surface],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accent.withOpacityCompat(0.4), width: 2),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: AppColors.accent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t('home.feed.greeting', params: {'name': name}),
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.t('home.feed.subtitle'),
                  style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _LiveTripsCarousel extends StatelessWidget {
  const _LiveTripsCarousel();

  static const List<Map<String, String>> _tripKeys = [
    {'title': 'home.live.title1', 'location': 'home.live.location1'},
    {'title': 'home.live.title2', 'location': 'home.live.location2'},
    {'title': 'home.live.title3', 'location': 'home.live.location3'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 132,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _tripKeys.length,
        separatorBuilder: (context, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final trip = _tripKeys[index];
          return Container(
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.accent.withOpacityCompat(0.22),
                  AppColors.surface.withOpacityCompat(0.92),
                ],
              ),
              border: Border.all(color: AppColors.accent.withOpacityCompat(0.12)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.podcasts_rounded, color: AppColors.accent, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      l10n.t('home.live.chip'),
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  l10n.t(trip['title'] ?? ''),
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.t(trip['location'] ?? ''),
                  style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CatchCard extends StatelessWidget {
  const _CatchCard({
    required this.post,
    required this.selectedReaction,
    required this.onReaction,
  });

  final CatchPost post;
  final ReactionType? selectedReaction;
  final ValueChanged<ReactionType> onReaction;

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'À l’instant';
    } else if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays} j';
    } else {
      return '${date.day}/${date.month}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: post.avatarColor.withOpacityCompat(0.22),
                  child: Text(
                    post.avatarInitials,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.anglerName,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${post.location} • ${_timeAgo(post.caughtAt)}',
                        style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                if (post.isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacityCompat(0.18),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.waves_rounded, size: 14, color: AppColors.accent),
                        const SizedBox(width: 4),
                        Text(
                          l10n.t('home.live.chip'),
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Hero(
                tag: 'catch-${post.id}',
                child: Stack(
                  children: [
                    Image.asset(
                      post.imagePath,
                      height: 190,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          post.catchTitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.catchDescription,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: post.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceAlt,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        '#$tag',
                        style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 18),
            _ReactionBar(
              post: post,
              selectedReaction: selectedReaction,
              onReaction: onReaction,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReactionBar extends StatelessWidget {
  const _ReactionBar({
    required this.post,
    required this.selectedReaction,
    required this.onReaction,
  });

  final CatchPost post;
  final ReactionType? selectedReaction;
  final ValueChanged<ReactionType> onReaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: ReactionType.values.map((reaction) {
        final isSelected = selectedReaction == reaction;
        final baseCount = post.reactions[reaction] ?? 0;
        final count = isSelected ? baseCount + 1 : baseCount;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => onReaction(reaction),
              borderRadius: BorderRadius.circular(28),
              child: Ink(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: isSelected ? AppColors.accent.withOpacityCompat(0.2) : AppColors.surfaceAlt,
                  border: Border.all(
                    color: isSelected ? AppColors.accent : Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(reaction.emoji, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 6),
                    Text(
                      '$count',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _CollectView extends StatelessWidget {
  const _CollectView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withOpacityCompat(0.25),
                  AppColors.surface.withOpacityCompat(0.9),
                ],
              ),
            ),
            child: const Icon(Icons.auto_awesome_motion_rounded, size: 64, color: AppColors.accent),
          ),
          const SizedBox(height: 32),
          Text(
            l10n.t('home.collect.title'),
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.t('home.collect.description'),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 28),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.accent.withOpacityCompat(0.4)),
            ),
            child: Text(l10n.t('home.collect.button')),
          )
        ],
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.displayName});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final friendlyName = displayName.isEmpty ? 'Fish Friend' : displayName;

    final stats = [
      _ProfileStat(label: l10n.t('home.stats.catches'), value: '24'),
      _ProfileStat(label: l10n.t('home.stats.sessions'), value: '12'),
      _ProfileStat(label: l10n.t('home.stats.reactions'), value: '156'),
    ];

    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.accent.withOpacityCompat(0.22),
                child: Text(
                  friendlyName.characters.take(2).toString().toUpperCase(),
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                friendlyName,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.t('home.profile.subtitle'),
                style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _ProfileStatRow(
          stats: stats,
        ),
        const SizedBox(height: 32),
        Text(
          l10n.t('home.badge.section'),
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _BadgeChip(icon: Icons.emoji_events_outlined, label: l10n.t('home.badge.trophy')),
            _BadgeChip(icon: Icons.group_outlined, label: l10n.t('home.badge.crew')),
            _BadgeChip(icon: Icons.nightlight_round, label: l10n.t('home.badge.night')),
          ],
        ),
      ],
    );
  }
}

class _ProfileStatRow extends StatelessWidget {
  const _ProfileStatRow({required this.stats});

  final List<_ProfileStat> stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: stats
          .map(
            (stat) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.overlay),
                ),
                child: Column(
                  children: [
                    Text(
                      stat.value,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      stat.label,
                      style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ProfileStat {
  const _ProfileStat({required this.label, required this.value});

  final String label;
  final String value;
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.surfaceAlt,
        border: Border.all(color: AppColors.overlay),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.accent),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
