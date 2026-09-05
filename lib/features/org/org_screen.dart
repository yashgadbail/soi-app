import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

part 'org_screen.g.dart';

@riverpod
Future<OrgPublic> orgPublic(Ref ref, String id) => ref.watch(orgsRepoProvider).publicProfile(id);

/// Public organisation profile: who they are, what they've run, what's next.
class OrgScreen extends ConsumerWidget {
  const OrgScreen({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final org = ref.watch(orgPublicProvider(id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: Text(l.orgTitle)),
      body: org.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(orgPublicProvider(id))),
        data: (o) => PageListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InitialsAvatar(o.name, size: 56),
                const SizedBox(width: Space.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(o.name, style: context.text.headlineSmall),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: Space.sm,
                        runSpacing: 4,
                        children: [
                          SoiTag(_typeLabel(l, o.type)),
                          if (o.city != null) SoiTag(o.city!, icon: Icons.place_outlined),
                          if (o.isVerified) SoiTag(l.orgVerifiedBadge, tone: TagTone.green, icon: Icons.verified),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (o.about != null && o.about!.trim().isNotEmpty) ...[
              const SizedBox(height: Space.lg),
              Text(o.about!, style: context.text.bodyLarge),
            ],
            const SizedBox(height: Space.xl),
            SoiCard(
              child: Row(
                children: [
                  Expanded(child: StatTile(value: '${o.drivesRun}', label: l.orgDrivesRun)),
                  Expanded(child: StatTile(value: Fmt.hours(o.certifiedHours), label: l.orgHoursCertified)),
                ],
              ),
            ),
            const SizedBox(height: Space.xl),
            SectionLabel(l.orgUpcoming),
            if (o.upcoming.isEmpty)
              Text(l.orgNoUpcoming, style: context.text.bodyMedium)
            else
              for (final d in o.upcoming)
                Padding(
                  padding: const EdgeInsets.only(bottom: Space.md),
                  child: SoiCard(
                    onTap: () => DriveRoute(id: d.id).push<void>(context),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Fmt.dayOrRelative(d.startsAt), style: context.text.labelSmall!.copyWith(color: c.green)),
                              const SizedBox(height: 2),
                              Text(d.title, style: context.text.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 2),
                              Text(
                                [Fmt.time(d.startsAt), if (d.venue != null) d.venue!].join(' · '),
                                style: context.text.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: Space.sm),
                        Text(l.commonHoursShort(Fmt.hours(d.defaultHours)),
                            style: context.text.labelLarge!.copyWith(color: c.green)),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(AppLocalizations l, String type) => switch (type) {
        'school' => l.orgTypeSchool,
        'corporate' => l.orgTypeCorporate,
        _ => l.orgTypeNgo,
      };
}
