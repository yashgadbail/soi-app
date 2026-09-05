import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/data/models.dart';
import 'package:soi/features/discover/discover_controller.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/motion.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// Discover: search, cause and city chips, sort, and paginated results.
class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final _search = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.extentAfter < 600) {
        ref.read(discoverControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _search.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final state = ref.watch(discoverControllerProvider);
    final ctl = ref.read(discoverControllerProvider.notifier);
    final facets = ref.watch(discoverFacetsProvider).value;

    final showSkeleton = state.loading && state.rows.isEmpty;
    final showError = state.error != null && state.rows.isEmpty;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(discoverFacetsProvider);
          await ctl.refresh();
        },
        edgeOffset: MediaQuery.paddingOf(context).top + 8,
        child: CustomScrollView(
          controller: _scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              toolbarHeight: 64,
              titleSpacing: Space.page,
              title: TextField(
                controller: _search,
                onChanged: ctl.setQuery,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: l.discoverSearchHint,
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: _FilterBar(state: state, facets: facets),
              ),
            ),
            SliverPadding(
              padding: pagePadding,
              sliver: SliverList.list(
                children: [
                  if (!state.hasFilters) ...[
                    Text(l.discoverTitle, style: context.text.headlineMedium),
                    const SizedBox(height: 4),
                    Text(l.discoverLead, style: context.text.bodyMedium),
                    const SizedBox(height: Space.xl),
                  ],
                  if (state.error != null && state.rows.isNotEmpty) ...[
                    ErrorView(
                      error: state.error!,
                      onRetry: ctl.refresh,
                      compact: true,
                    ),
                    const SizedBox(height: Space.md),
                  ],
                  if (showSkeleton || state.rows.isNotEmpty || state.hasFilters)
                    SectionLabel(
                      showSkeleton
                          ? l.discoverUpcoming
                          : l.discoverResults(state.rows.length),
                      trailing: state.hasFilters
                          ? TextButton(
                              onPressed: () {
                                _search.clear();
                                ctl.clearFilters();
                              },
                              child: Text(l.commonClear),
                            )
                          : null,
                    ),
                ],
              ),
            ),
            if (showSkeleton)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: Space.page),
                sliver: SliverList.builder(
                  itemCount: 4,
                  itemBuilder: (_, _) => const _CardSkeleton(),
                ),
              )
            else if (showError)
              SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorView(error: state.error!, onRetry: ctl.refresh),
              )
            else if (state.rows.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyView(
                  icon: state.hasFilters
                      ? Icons.search_off_rounded
                      : Icons.event_outlined,
                  title: state.hasFilters
                      ? l.discoverNoMatchTitle
                      : l.discoverEmptyTitle,
                  body: state.hasFilters
                      ? l.discoverNoMatchBody
                      : l.discoverEmptyBody,
                  action: state.hasFilters
                      ? OutlinedButton(
                          onPressed: () {
                            _search.clear();
                            ctl.clearFilters();
                          },
                          child: Text(l.commonClear),
                        )
                      : null,
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
                      padding: const EdgeInsets.only(bottom: Space.md),
                      child: DriveCard(
                        drive: d,
                        onTap: () => DriveRoute(id: d.id).push<void>(context),
                      ),
                    );
                    // Stagger only the first screenful; later rows must not
                    // replay an entrance while scrolling on a cheap phone.
                    return i < 6 ? FadeInUp(index: i, child: card) : card;
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Space.page,
                    Space.sm,
                    Space.page,
                    40,
                  ),
                  child: state.loadingMore
                      ? const LoadingView()
                      : state.endReached
                      ? Center(
                          child: Text(
                            l.discoverEndOfList,
                            style: context.text.bodySmall!.copyWith(
                              color: c.muted,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: ctl.loadMore,
                          child: Text(l.discoverLoadMore),
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
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
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: Space.page,
          vertical: 4,
        ),
        children: [
          _MenuChip(
            label: state.cause ?? l.discoverFilterCause,
            selected: state.cause != null,
            icon: Icons.category_outlined,
            items: [
              for (final f in causes) (f.value, '${f.value} (${f.count})'),
            ],
            allLabel: l.discoverFilterAll,
            onSelected: ctl.setCause,
          ),
          const SizedBox(width: Space.sm),
          _MenuChip(
            label: state.city ?? l.discoverFilterCity,
            selected: state.city != null,
            icon: Icons.location_city_outlined,
            items: [
              for (final f in cities) (f.value, '${f.value} (${f.count})'),
            ],
            allLabel: l.discoverFilterAll,
            onSelected: ctl.setCity,
          ),
          const SizedBox(width: Space.sm),
          SoiFilterChip(
            label: l.discoverSortSoonest,
            selected: state.sort == 'soonest',
            onSelected: (_) => ctl.setSort('soonest'),
          ),
          const SizedBox(width: Space.sm),
          SoiFilterChip(
            label: l.discoverSortHours,
            selected: state.sort == 'hours',
            onSelected: (_) => ctl.setSort('hours'),
          ),
        ],
      ),
    );
  }
}

class _MenuChip extends StatelessWidget {
  const _MenuChip({
    required this.label,
    required this.selected,
    required this.icon,
    required this.items,
    required this.allLabel,
    required this.onSelected,
  });
  final String label;
  final bool selected;
  final IconData icon;
  final List<(String, String)> items;
  final String allLabel;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, _) => SoiFilterChip(
        label: label,
        icon: icon,
        selected: selected,
        onSelected: (_) =>
            controller.isOpen ? controller.close() : controller.open(),
      ),
      menuChildren: [
        MenuItemButton(
          onPressed: () => onSelected(null),
          child: Text(allLabel),
        ),
        for (final (value, text) in items)
          MenuItemButton(onPressed: () => onSelected(value), child: Text(text)),
      ],
    );
  }
}

/// The one drive card, shared by Discover and the organisation page.
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
    return SoiCard(
      onTap: onTap,
      semanticsLabel:
          '${d.title}, ${d.orgName}, $when, ${l.commonHours(d.defaultHours)}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SoiTag(when, tone: TagTone.green),
              const SizedBox(width: Space.sm),
              if (d.registered)
                SoiTag(
                  l.discoverRegistered,
                  tone: TagTone.saffron,
                  icon: Icons.check,
                ),
              const Spacer(),
              Text(
                l.commonHoursShort(Fmt.hours(d.defaultHours)),
                style: context.text.labelLarge!.copyWith(
                  color: c.green,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.md),
          Text(
            d.title,
            style: context.text.titleLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Flexible(
                child: Text(
                  d.orgName,
                  style: context.text.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (d.orgVerified) ...[
                const SizedBox(width: 6),
                Icon(
                  Icons.verified,
                  size: 14,
                  color: c.greenMid,
                  semanticLabel: l.discoverVerified,
                ),
              ],
            ],
          ),
          const SizedBox(height: Space.md),
          Wrap(
            spacing: Space.md,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (d.cause != null) SoiTag(d.cause!, tone: TagTone.saffron),
              _Meta(Icons.schedule, Fmt.time(d.startsAt)),
              if (d.venue != null || d.city != null)
                _Meta(
                  Icons.place_outlined,
                  [d.venue, d.city].whereType<String>().join(', '),
                ),
              _Meta(
                d.isFull ? Icons.block : Icons.people_outline,
                l.discoverSpotsLeft(d.spotsLeft),
                color: d.isFull ? c.danger : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta(this.icon, this.text, {this.color});
  final IconData icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color ?? c.muted),
        const SizedBox(width: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 220),
          child: Text(
            text,
            style: context.text.bodySmall!.copyWith(color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton();
  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    return Padding(
      padding: const EdgeInsets.only(bottom: Space.md),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: c.bg,
          borderRadius: BorderRadius.circular(Radii.xl),
          border: Border.all(color: c.line),
        ),
      ),
    );
  }
}
