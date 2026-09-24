import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/views/widget/noticationtile.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/reportdetails.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_state.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  late bool isWorker;
  late Color primaryColor;

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
    isWorker = PrefrenceManager().getstring("role")?.toLowerCase() == "worker";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    primaryColor = isWorker
        ? context.palette.workerprimary
        : context.palette.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: primaryColor,
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      backgroundColor: context.palette.surface,
      elevation: 0,
      centerTitle: false,
      title: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          int unreadCount = 0;
          if (state is NotificationLoaded) {
            unreadCount = state.notifications.where((e) => !e.isRead).length;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).notifications,
                style: GoogleFonts.cairo(
                  color: primaryColor,
                  fontSize: ScreenUtilsManager.s20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (unreadCount > 0)
                Text(
                  "$unreadCount ${S.of(context).unread}",
                  style: GoogleFonts.cairo(
                    color: context.palette.onSurfaceVariant,
                    fontSize: ScreenUtilsManager.s12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          );
        },
      ),
      actions: [
        BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoaded && state.notifications.isNotEmpty) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.checklist_rtl_rounded),
                    color: primaryColor,
                    onPressed: () => context
                        .read<NotificationCubit>()
                        .markAllNotificationsAsRead(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_sweep_rounded),
                    color: context.palette.red,
                    onPressed: () => context
                        .read<NotificationCubit>()
                        .clearAllNotifications(),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return Center(child: CupertinoActivityIndicator(color: primaryColor));
        } else if (state is NotificationError) {
          return _buildErrorState(state.message);
        } else if (state is NotificationLoaded) {
          if (state.notifications.isEmpty) return _buildEmptyState();
          return _buildNotificationList(state.notifications);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildNotificationList(List notifications) {
    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () => context.read<NotificationCubit>().refreshNotifications(),
      child: ListView.separated(
        padding: EdgeInsets.all(ScreenUtilsManager.w12),
        itemCount: notifications.length,
        separatorBuilder: (_, _) => SizedBox(height: ScreenUtilsManager.h10),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
              decoration: BoxDecoration(
                color: context.palette.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.white,
              ),
            ),
            onDismissed: (_) =>
                context.read<NotificationCubit>().deleteNotification(item.id),
            child: NotificationTile(
              item: item,
              onTap: () =>
                  context.read<NotificationCubit>().markAsRead(item.id),
              onDelete: () =>
                  context.read<NotificationCubit>().deleteNotification(item.id),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: ScreenUtilsManager.s80,
            color: primaryColor.withValues(alpha: 0.2),
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          Text(
            S.of(context).noNotifications,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s18,
              fontWeight: FontWeight.bold,
              color: context.palette.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.w20),
              decoration: BoxDecoration(
                color: context.palette.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: ScreenUtilsManager.s50,
                color: context.palette.red,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                color: context.palette.onSurface,
                fontSize: ScreenUtilsManager.s16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w32,
                  vertical: ScreenUtilsManager.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                ),
              ),
              onPressed: () =>
                  context.read<NotificationCubit>().getNotifications(),
              child: Text(
                S.of(context).tryAgain,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
