import 'package:flutter/material.dart';
import './types/calendar_event_item.dart';
import './types/calendar_event.dart';
import 'types/navigation_view.dart';
import './widgets/styles/colors.dart' as colors;
import './widgets/styles/icons.dart' as icons;
import './widgets/layouts/navigation_icon.dart';

// Bottom Nav Items
const String LABEL_HOME = 'Home';
const String LABEL_REVIEW = 'Review';
const String LABEL_RECORD = 'Record';
const String LABEL_GUIDE = 'Guide';
const String LABEL_PROFILE = 'Profile';

const int loadingDelayMs = 2000;
const Duration loadingDelayDuration = Duration(milliseconds: loadingDelayMs);

final List<NavigationView> views = <NavigationView>[
  NavigationView(
      icon: icons.home,
      label: LABEL_HOME,
      // page: Pages.Home,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(
            icon: icons.home,
          ),
          label: LABEL_HOME)),
  NavigationView(
      icon: icons.feed,
      label: LABEL_REVIEW,
      // page: Pages.Feed,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(icon: icons.feed), label: LABEL_REVIEW)),
  NavigationView(
      icon: icons.record,
      label: LABEL_RECORD,
      // page: Pages.Record,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(icon: icons.record), label: LABEL_RECORD)),
  NavigationView(
      icon: icons.guides,
      label: LABEL_GUIDE,
      // page: Pages.Guides,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(icon: icons.guides, count: 0),
          label: LABEL_GUIDE)),
  NavigationView(
      icon: icons.menu,
      label: LABEL_PROFILE,
      // page: Pages.Menu,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(icon: icons.menu), label: LABEL_PROFILE)),
];

final List<CalendarEvent> dummyEvents = [
  CalendarEvent(date: '2021-05-05', events: [
    CalendarEventItem(
      id: 1,
      isDone: true,
      order: 1,
      title: 'check law',
      startAt: 'Wed, 17 Mar 2021 11:05:44 GMT',
      date: '2021-05-17',
      color: colors.black,
    ),
    CalendarEventItem(
      id: 2,
      isDone: true,
      order: 2,
      title: '🏋🏽‍♀️ pt',
      startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
      date: '2021-05-17',
      color: colors.primary,
    ),
    CalendarEventItem(
      id: 3,
      order: 3,
      title: 'study meetup',
      startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
      date: '2021-05-17',
      color: colors.black,
    ),
  ]),
  CalendarEvent(date: '2021-05-06', events: [
    CalendarEventItem(
      id: 1,
      isDone: true,
      order: 1,
      title: 'meeting',
      startAt: 'Wed, 17 Mar 2021 11:05:44 GMT',
      date: '2021-05-17',
      color: colors.black,
    ),
    CalendarEventItem(
      id: 2,
      isDone: true,
      order: 2,
      title: 'flight to LAX',
      startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
      date: '2021-05-17',
      color: colors.primary,
    ),
    CalendarEventItem(
      id: 3,
      order: 3,
      title: 'see Ruby',
      startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
      date: '2021-05-17',
      color: colors.black,
    ),
  ]),
  CalendarEvent(date: '2021-05-07', events: [
    CalendarEventItem(
      id: 1,
      isDone: true,
      order: 1,
      title: 'workshop',
      startAt: 'Wed, 17 Mar 2021 11:05:44 GMT',
      date: '2021-05-17',
      color: colors.black,
    ),
    CalendarEventItem(
      id: 2,
      isDone: true,
      order: 2,
      title: 'portfolio',
      startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
      date: '2021-05-17',
      color: colors.primary,
    ),
    CalendarEventItem(
      id: 3,
      order: 3,
      title: 'shopping',
      startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
      date: '2021-05-17',
      color: colors.black,
    ),
  ]),
];
