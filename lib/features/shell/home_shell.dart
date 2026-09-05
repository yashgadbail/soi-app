import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/data/session.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/effects.dart';

/// Tabs. All five branches always exist in the router; the Manage
/// destination is hidden until the user coordinates an organisation, so the
/// router is never rebuilt and navigation state survives.
///
/// Adaptive: a frosted bottom bar on phones; a navigation rail on wide
/// windows (tablets, foldables open, desktop). The decision is made from
/// the available width, never from the device type.
class HomeShell extends ConsumerWidget {
  const HomeShell({required this.shell, super.key});
  final StatefulNavigationShell shell;

  static const _manageBranch = 4;
  static const _railBreakpoint = 720.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final isCoordinator = ref.watch(sessionControllerProvider.select((s) => s.isCoordinator));

    final items = <({IconData icon, IconData selected, String label})>[
      (icon: Icons.explore_outlined, selected: Icons.explore_rounded, label: l.navDiscover),
      (icon: Icons.qr_code_scanner_rounded, selected: Icons.qr_code_scanner_rounded, label: l.navCheckIn),
      (icon: Icons.workspace_premium_outlined, selected: Icons.workspace_premium_rounded, label: l.navPassport),
      (icon: Icons.person_outline_rounded, selected: Icons.person_rounded, label: l.navProfile),
      if (isCoordinator)
        (icon: Icons.dashboard_customize_outlined, selected: Icons.dashboard_customize_rounded, label: l.navManage),
    ];

    // Visible index == branch index for the first four; Manage is branch 4
    // only when shown. If the user lost coordinator rights while on Manage,
    // fall back to Discover.
    final index = (shell.currentIndex == _manageBranch && !isCoordinator ? 0 : shell.currentIndex)
        .clamp(0, items.length - 1);

    void go(int i) => shell.goBranch(i, initialLocation: i == shell.currentIndex);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= _railBreakpoint) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: index,
                  onDestinationSelected: go,
                  labelType: NavigationRailLabelType.all,
                  groupAlignment: -0.6,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Space.lg),
                    child: Text(
                      l.brandShort,
                      style: context.text.titleMedium!.copyWith(color: context.soi.green, letterSpacing: 3),
                    ),
                  ),
                  destinations: [
                    for (final d in items)
                      NavigationRailDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selected), label: Text(d.label)),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: shell),
              ],
            ),
          );
        }
        return Scaffold(
          extendBody: true,
          body: shell,
          bottomNavigationBar: GlassSurface(
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              selectedIndex: index,
              destinations: [
                for (final d in items)
                  NavigationDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selected), label: d.label),
              ],
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              onDestinationSelected: go,
            ),
          ),
        );
      },
    );
  }
}
