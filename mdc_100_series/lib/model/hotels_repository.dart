// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'hotel.dart';

class HotelsRepository {
  static List<Hotel> loadHotels(Category category) {
    const allHotels = <Hotel> [
      Hotel(
        category: Category.small,
        filename: 'hotelOne',
        star: 3,
        name: 'California Hotel',
        location: 'address of this hotel',
        number: '+23-43242-2432',
        description: 'this is a long description about this hotel to be written for the users to read for a bit of information about this hotel. Hope I can get a good score for this Test!',
        isHeart: false,
      ),
      Hotel(
        category: Category.small,
        filename: 'hotelTwo',
        star: 2,
        name: 'Jae Ju Hotel',
        location: 'address of this hotel',
        number: '+23-23432-23424',
        description: 'To determine the app’s current Orientation, use the OrientationBuilder widget. The OrientationBuilder calculates the current Orientation by comparing the width and height available to the parent widget, and rebuilds when the size of the parent changes.',
        isHeart: false,
      ),
      Hotel(
        category: Category.medium,
        filename: 'hotelThree',
        star: 4,
        name: 'Seoul Hotel',
        location: 'address of this hotel',
        number: '+23-432-2342',
        description: 'Use text buttons on toolbars, in dialogs, or inline with other content but offset from that content with padding so that the button',
        isHeart: false,
      ),
      Hotel(
        category: Category.medium,
        filename: 'hotelFour',
        star: 3,
        name: 'Po Hang Hotel',
        location: 'address of this hotel',
        number: '+23-42-65563',
        description: 'Warning: Beta! This area covers desktop support, which is available as a beta release. Beta support still has notable feature gaps, including accessibility support. You can try a beta snapshot of desktop support on the stable channel, or you can keep up with the latest changes to desktop on the beta channel. For more information, see the Desktop section in What’s new in Flutter 2, a free article on Medium.',
        isHeart: false,
      ),
      Hotel(
        category: Category.large,
        filename: 'hotelFive',
        star: 5,
        name: 'Florida Hotel',
        location: 'address of this hotel',
        number: '+23-432-765',
        description: 'Flutter has support for building web applications in the stable channel. Any app created in Flutter 2 automatically builds for the web. To add web support to an existing app, follow the instructions on Building a web application with Flutter when you’ve completed the setup above.',
        isHeart: false,
      ),
      Hotel(
        category: Category.large,
        filename: 'hotelSix',
        star: 4,
        name: 'Philippines Hotel',
        location: 'address of this hotel',
        number: '+23-123-212',
        description: 'For example, when installed from GitHub (as opposed to from a prepackaged archive), the Flutter tool will download the Dart SDK from Google servers immediately when first run, as it is used to execute the flutter tool itself. This will also occur when Flutter is upgraded (e.g. by running the flutter upgrade command).',
        isHeart: false,
      ),
    ];
    if (category == Category.all) {
      return allHotels;
    } else {
      return allHotels.where((Hotel h) {
        return h.category == category;
      }).toList();
    }
  }
}
