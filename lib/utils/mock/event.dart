library mock_event;

import 'package:my_event_flutter/utils/models/model_event.dart';

List<EventModel> events = [
    EventModel(
        id: "1",
        name: 'งานมหกรรมหนังสือ',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: true,
        booking: true,
        startedAt: '2019-07-08T10:37:28Z',
        locationName: 'สวนลุมพินี',
        category: "Book"),
    EventModel(
        id: "2",
        name: 'งานดนตรี ครั้งที่ 999',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false,
        startedAt: '2019-07-08T10:37:28Z',
        locationName: 'สวนลุมพินี',
        category: "Music"),
    EventModel(
        id: "3",
        name: 'Motor Show',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: true,
        booking: false,
        startedAt: '2019-07-08T10:37:28Z',
        locationName: 'สวนลุมพินี',
        category: "Car"),
    EventModel(
        id: "4",
        name: 'Thailand Game Show',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: true,
        booking: false,
        startedAt: '2019-07-08T10:37:28Z',
        locationName: 'สวนลุมพินี',
        category: "Game"),
    EventModel(
        id: "5",
        name: 'Apple WWDC24',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false,
        startedAt: '2019-07-08T10:37:28Z',
        locationName: 'สวนลุมพินี',
        category: "Tech"),
    EventModel(
        id: "6",
        name: 'FinTech X 88Sandbox',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: true,
        booking: false,
        startedAt: '2019-07-08T10:37:28Z',
        locationName: 'สวนลุมพินี',
        category: "Tech"),
    EventModel(
        id: "7",
        name: 'Food Festival',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false,
        startedAt: '2019-07-08T10:37:28Z',
        locationName: 'สวนลุมพินี',
        category: "Food"),
  ];
