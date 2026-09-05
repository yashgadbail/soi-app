import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soi/data/session.dart';
import 'package:soi/l10n/generated/app_localizations.dart';

/// Bottom tabs. All five branches always exist in the router; the Manage
/// destination is simply hidden until the user coordinates an organisation,
/// so the router is never rebuilt and navigation state survives.
class HomeShell extends ConsumerWidget {
  const HomeShell({required this.shell, super.key});
  final StatefulNavigationShell shell;

  static const _manageBranch = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final isCoordinator = ref.watch(sessionControllerProvider.select((s) => s.isCoordinator));

    final destinations = <NavigationDestination>[
      NavigationDestination(
        icon: const Icon(Icons.explore_outlined),
        selectedIcon: const Icon(Icons.explore),
        label: l.navDiscover,
      ),
      NavigationDestination(
        icon: const Icon(Icons.qr_code_scanner_outlined),
        selectedIcon: const Icon(Icons.qr_code_scanner),
        label: l.navCheckIn,
      ),
      NavigationDestination(
        icon: const Icon(Icons.workspace_premium_outlined),
        selectedIcon: const Icon(Icons.workspace_premium),
        label: l.navPassport,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person_outline),
        selectedIcon: const Icon(Icons.person),
        label: l.navProfile,
      ),
      if (isCoordinator)
        NavigationDestination(
          icon: const Icon(Icons.dashboard_customize_outlined),
          selectedIcon: const Icon(Icons.dashboard_customize),
          label: l.navManage,
        ),
    ];

    // Visible index == branch index for the first four; Manage is branch 4
    // only when shown. If the user lost coordinator rights while on Manage,
    // fall back to Discover.
    final visibleIndex = shell.currentIndex == _manageBranch && !isCoordinator ? 0 : shell.currentIndex;

    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: visibleIndex.clamp(0, destinations.length - 1),
        destinations: destinations,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) => shell.goBranch(
          index,
          // Re-tapping the current tab pops to its root.
          initialLocation: index == shell.currentIndex,
        ),
      ),
    );
  }
}
