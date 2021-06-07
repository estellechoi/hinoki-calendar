import 'package:flutter/material.dart';
import './types/calendar_event_item.dart';
import './types/calendar_event.dart';
import 'types/navigation_view.dart';
import './widgets/styles/colors.dart' as colors;
import './widgets/styles/icons.dart' as icons;
import './widgets/layouts/navigation_icon.dart';

// Bottom Nav Items
final String home = 'Home';
final String feed = 'Review';
final String record = 'Record';
final String guides = 'Guide';
final String menu = 'Profile';

final List<NavigationView> views = <NavigationView>[
  NavigationView(
      icon: icons.home,
      label: home,
      // page: Pages.Home,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(
            icon: icons.home,
          ),
          label: home)),
  NavigationView(
      icon: icons.feed,
      label: feed,
      // page: Pages.Feed,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(icon: icons.feed), label: feed)),
  NavigationView(
      icon: icons.record,
      label: record,
      // page: Pages.Record,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(icon: icons.record), label: record)),
  NavigationView(
      icon: icons.guides,
      label: guides,
      // page: Pages.Guides,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(icon: icons.guides, count: 0), label: guides)),
  NavigationView(
      icon: icons.menu,
      label: menu,
      // page: Pages.Menu,
      navItemWidget: BottomNavigationBarItem(
          icon: NavigationIcon(icon: icons.menu), label: menu)),
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
      color: colors.active,
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
      color: colors.active,
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
      color: colors.active,
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
