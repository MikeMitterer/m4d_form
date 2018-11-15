library m4d_form_sample.dialog;

import 'dart:async';
import 'dart:html' as dom;

import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import 'package:m4d_core/m4d_ioc.dart' as ioc;
import 'package:m4d_core/services.dart' as coreService;
import "package:m4d_components/m4d_components.dart";

import 'package:m4d_dialog/m4d_dialog.dart';
import 'package:m4d_form/m4d_form.dart';

import "package:m4d_directive/directive/components/interfaces/stores.dart";
import "package:m4d_directive/services.dart" as modelService;

part 'dialog/TimeFrameDialog.dart';