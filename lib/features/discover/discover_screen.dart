import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/discover/discover_controller.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/effects.dart';
import 'package:soi/ui/how_it_works.dart';
import 'package:soi/ui/motion.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// Discover.
///
/// Reading order: a compact frosted title bar the page scrolls under, then the
/// search field and filters as part of the page, then the drives. Once the
/// search field has scrolled away, a floating search button sits within
/// thumb reach above the tab bar and brings it back.
class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final _search = TextEditingController();
  final _searchFocus = FocusNode();
  final _scroll = ScrollController();
  bool _searchScrolledAway = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scroll.position.extentAfter < 600) {
      ref.read(discoverControllerProvider.notifier).loadMore();
    }
    final away = _scroll.offset > 180;
    if (away != _searchScrolledAway) setState(() => _searchScrolledAway = away);
  }

  @override
  void dispose() {
    _search.dispose();
    _searchFocus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _clear() {
    _search.clear();
    ref.read(discoverControllerProvider.notifier).clearFilters();
  }

  Future<void> _jumpToSearch() async {
    await _scroll.animateTo(0, duration: Motion.enter, curve: Motion.out);
    _searchFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final state = ref.watch(discoverControllerProvider);
    final ctl = ref.read(discoverControllerProvider.notifier);
    final facets = ref.watch(discoverFacetsProvider).value;
    final bottomInset = MediaQuery.paddingOf(context).bottom + Space.xl;

    final showSkeleton = state.loading && state.rows.isEmpty;
    final showError = state.error != null && state.rows.isEmpty;
    final showEmpty = !showSkeleton && !showError && state.rows.isEmpty;

    return Scaffold(
      floatingActionButton: AnimatedSlide(
        offset: _searchScrolledAway ? Offset.zero : const Offset(0, 2),
        duration: Motion.base,
        curve: Motion.standard,
        child: AnimatedOpacity(
          opacity: _searchScrolledAway ? 1 : 0,
          duration: Motion.base,
          child: FloatingActionButton.extended(
            heroTag: 'discover-search',
            onPressed: _jumpToSearch,
            icon: const Icon(Icons.search),
            label: Text(l.commonSearch),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(discoverFacetsProvider);
          await ctl.refresh();
        },
        edgeOffset: MediaQuery.paddingOf(context).top + 64,
        child: CustomScrollView(
          controller: _scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
              titleSpacing: Space.page,
              title: Text(l.navDiscover, style: context.text.headlineSmall),
              flexibleSpace: const GlassSurface(border: false, child: SizedBox.expand()),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: Space.sm)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(Space.page, 0, Space.page, 0),
              sliver: SliverList.list(
                children: [
                  TextField(
                    controller: _search,
                    focusNode: _searchFocus,
                    onChanged: ctl.setQuery,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: l.discoverSearchHint,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: state.query.isEmpty
                          ? null
                          : IconButton(
                              tooltip: l.commonClear,
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _search.clear();
                                ctl.setQuery('');
                              },
                            ),
                    ),
                  ),
                  const SizedBox(height: Space.md),
                  _FilterBar(state: state, facets: facets),
                  const SizedBox(height: Space.section),
                  if (state.error != null && state.rows.isNotEmpty) ...[
                    ErrorView(error: state.error!, onRetry: ctl.refresh, compact: true),
                    const SizedBox(height: Space.lg),
                  ],
                  if (!showEmpty)
                    SectionLabel(
                      showSkeleton ? l.discoverUpcoming : l.discoverResults(state.rows.length),
                      trailing: state.hasFilters ? TextButton(onPressed: _clear, child: Text(l.commonClear)) : null,
                    ),
                ],
              ),
            ),
            if (showSkeleton)
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Space.page),
                sliver: SliverToBoxAdapter(
                  child: Shimmer(child: Column(children: [SkeletonCard(), SkeletonCard(), SkeletonCard()])),
                ),
              )
            else if (showError)
              SliverFillRemaining(hasScrollBody: false, child: ErrorView(error: state.error!, onRetry: ctl.refresh))
            else if (showEmpty)
              SliverPadding(
                padding: EdgeInsets.fromLTRB(Space.page, 0, Space.page, bottomInset),
                sliver: SliverToBoxAdapter(
                  child: state.hasFilters
                      ? EmptyView(
                          icon: Icons.search_off_rounded,
                          title: l.discoverNoMatchTitle,
                          body: l.discoverNoMatchBody,
                          action: OutlinedButton(onPressed: _clear, child: Text(l.commonClear)),
                        )
                      : const _DiscoverEmpty(),
                ),
              )
            else ...[
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: Space.page),
                sliver: SliverList.builder(
                  itemCount: state.rows.length,
                  itemBuilder: (context, i) {
                    final d = state.rows[i];
                    final card = Padding(
                      padding: const EdgeInsets.only(bottom: Space.lg),
                      child: DriveCard(drive: d, onTap: () => DriveRoute(id: d.id).push<void>(context)),
                    );
                    // Stagger only the first screenful; later rows must not
                    // replay an entrance while scrolling on a cheap phone.
                    return i < 6 ? FadeInUp(index: i, child: card) : card;
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(Space.page, Space.sm, Space.page, bottomInset + 56),
                  child: state.loadingMore
                      ? const LoadingView()
                      : state.endReached
                          ? Center(child: Text(l.discoverEndOfList, style: context.text.bodySmall!.copyWith(color: c.muted)))
                          : OutlinedButton(onPressed: ctl.loadMore, child: Text(l.discoverLoadMore)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// What an empty Discover shows: the story, and the two things a visitor
/// can do right now (sign in, or register an organisation), plus the
/// pledge-code box so a poster still leads somewhere.
class _DiscoverEmpty extends ConsumerStatefulWidget {
  const _DiscoverEmpty();

  @override
  ConsumerState<_DiscoverEmpty> createState() => _DiscoverEmptyState();
}

class _DiscoverEmptyState extends ConsumerState<_DiscoverEmpty> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _openPledge() {
    final code = _code.text.trim().toUpperCase();
    if (Validators.shareCode(code) != null) {
      showSnack(context, fieldError(context, 'BAD_CODE')!);
      return;
    }
    PledgeRoute(code: code).push<void>(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final session = ref.watch(sessionControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FadeInUp(
          child: Container(
            padding: const EdgeInsets.all(Space.xl),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0E7C5A), SoiColors.deep],
              ),
              borderRadius: BorderRadius.circular(Radii.xl),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Radii.md)),
                  child: const Icon(Icons.event_outlined, color: Colors.white, size: 28),
                ),
                const SizedBox(width: Space.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.discoverEmptyTitle, style: context.text.titleLarge!.copyWith(color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(l.discoverEmptyLead, style: context.text.bodySmall!.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Space.section),
        const FadeInUp(index: 1, child: HowItWorks()),
        const SizedBox(height: Space.section),
        FadeInUp(
          index: 2,
          child: SoiCard(
            color: c.saffronSoft,
            borderColor: c.saffronSoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.welcomeHavePledgeCode, style: context.text.titleMedium!.copyWith(color: c.saffronInk)),
                const SizedBox(height: Space.md),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _code,
                        textCapitalization: TextCapitalization.characters,
                        maxLength: 6,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (_) => _openPledge(),
                        decoration: InputDecoration(hintText: l.welcomePledgeCodeHint, counterText: ''),
                      ),
                    ),
                    const SizedBox(width: Space.sm),
                    SizedBox(
                      height: 52,
                      child: FilledButton(
                        style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
                        onPressed: _openPledge,
                        child: Text(l.commonOpen),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Space.section),
        FadeInUp(
          index: 3,
          child: session.isSignedIn
              ? (session.isCoordinator
                  ? const SizedBox.shrink()
                  : SoiCard(
                      onTap: () => const OrgNewRoute().push<void>(context),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(color: c.greenSoft, borderRadius: BorderRadius.circular(Radii.md)),
                            child: Icon(Icons.add_business_outlined, color: c.greenDark),
                          ),
                          const SizedBox(width: Space.lg),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l.discoverEmptyOrgTitle, style: context.text.titleSmall),
                                const SizedBox(height: 2),
                                Text(l.discoverEmptyOrgBody, style: context.text.bodySmall),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded, color: c.muted),
                        ],
                      ),
                    ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(l.discoverEmptySignInBody, style: context.text.bodyMedium, textAlign: TextAlign.center),
                    const SizedBox(height: Space.md),
                    FilledButton(
                      onPressed: () => const SignInRoute(from: '/discover').push<void>(context),
                      child: Text(l.welcomeCtaSignIn),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _FilterBar extends ConsumerWidget {
  const _FilterBar({required this.state, required this.facets});
  final DiscoverState state;
  final Facets? facets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final ctl = ref.read(discoverControllerProvider.notifier);
    final causes = facets?.causes ?? const [];
    final cities = facets?.cities ?? const [];

    return SizedBox(
      height: Space.tap,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _MenuChip(
            label: state.cause ?? l.discoverFilterCause,
            selected: state.cause != null,
            items: [for (final f in causes) (f.value, '${f.value} (${f.count})')],
            allLabel: l.discoverFilterAll,
            onSelected: ctl.setCause,
          ),
          const SizedBox(width: Space.sm),
          _MenuChip(
            label: state.city ?? l.discoverFilterCity,
            selected: state.city != null,
            items: [for (final f in cities) (f.value, '${f.value} (${f.count})')],
            allLabel: l.discoverFilterAll,
            onSelected: ctl.setCity,
          ),
          const SizedBox(width: Space.sm),
          SoiFilterChip(label: l.discoverSortSoonest, selected: state.sort == 'soonest', onSelected: (_) => ctl.setSort('soonest')),
          const SizedBox(width: Space.sm),
          SoiFilterChip(label: l.discoverSortHours, selected: state.sort == 'hours', onSelected: (_) => ctl.setSort('hours')),
        ],
      ),
    );
  }
}

class _MenuChip extends StatelessWidget {
  const _MenuChip({
    required this.label,
    required this.selected,
    required this.items,
    required this.allLabel,
    required this.onSelected,
  });
  final String label;
  final bool selected;
  final List<(String, String)> items;
  final String allLabel;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, _) => SoiFilterChip(
        label: label,
        icon: Icons.expand_more,
        selected: selected,
        onSelected: (_) => controller.isOpen ? controller.close() : controller.open(),
      ),
      menuChildren: [
        MenuItemButton(onPressed: () => onSelected(null), child: Text(allLabel)),
        for (final (value, text) in items) MenuItemButton(onPressed: () => onSelected(value), child: Text(text)),
      ],
    );
  }
}

/// The one drive card, shared by Discover and the organisation page.
/// Two lines of metadata, no more: what and when, then where and space.
class DriveCard extends StatelessWidget {
  const DriveCard({required this.drive, required this.onTap, super.key});
  final DriveSummary drive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final d = drive;
    final when = Fmt.dayOrRelative(d.startsAt);
    final where = [d.venue, d.city].whereType<String>().join(', ');
    return PressScale(
      child: SoiCard(
        onTap: onTap,
        semanticsLabel: '${d.title}, ${d.orgName}, $when, ${l.commonHours(d.defaultHours)}',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SoiTag(when, tone: TagTone.green),
                if (d.registered) ...[
                  const SizedBox(width: Space.sm),
                  SoiTag(l.discoverRegistered, tone: TagTone.saffron, icon: Icons.check),
                ],
                const Spacer(),
                Text(l.commonHoursShort(Fmt.hours(d.defaultHours)), style: context.text.titleMedium!.copyWith(color: c.green)),
              ],
            ),
            const SizedBox(height: Space.md),
            Text(d.title, style: context.text.titleLarge, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Row(
              children: [
                Flexible(child: Text(d.orgName, style: context.text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                if (d.orgVerified) ...[
                  const SizedBox(width: 6),
                  Icon(Icons.verified, size: 14, color: c.greenMid, semanticLabel: l.discoverVerified),
                ],
              ],
            ),
            const SizedBox(height: Space.lg),
            _MetaLine(icon: Icons.schedule, text: [if (d.cause != null) d.cause!, Fmt.time(d.startsAt)].join(' · ')),
            const SizedBox(height: 6),
            _MetaLine(
              icon: Icons.place_outlined,
              text: [if (where.isNotEmpty) where, l.discoverSpotsLeft(d.spotsLeft)].join(' · '),
              color: d.isFull ? c.danger : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.icon, required this.text, this.color});
  final IconData icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    return Row(
      children: [
        Icon(icon, size: 15, color: color ?? c.muted),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text, style: context.text.bodySmall!.copyWith(color: color), maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
