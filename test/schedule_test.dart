library test.schedule_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/schedule.dart';

var schedules;

void setup() {
  schedules = {
    'lowBalance': new Schedule('Lowest Balance First')
  };
}

main() {
  test('simple values', () {
    setup();
    expect(schedules['lowBalance'].label, 'Lowest Balance First');
  });
}