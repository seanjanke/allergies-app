import 'package:flutter/material.dart';

import 'theme.dart';

const iconButtonThemeDark = IconButtonThemeData(
  style: ButtonStyle(
    iconSize: MaterialStatePropertyAll(24),
    iconColor: MaterialStatePropertyAll(white),
  ),
);

const iconButtonThemeLight = IconButtonThemeData(
  style: ButtonStyle(
    iconSize: MaterialStatePropertyAll(24),
    iconColor: MaterialStatePropertyAll(black),
  ),
);

const iconThemeDark = IconThemeData(
  size: 24,
  color: white,
);

const iconThemeLight = IconThemeData(
  size: 24,
  color: black,
);
