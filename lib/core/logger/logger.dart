import 'dart:convert';
import 'dart:developer';

import 'package:donnymaestro/core/constant/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AppLogger {
  const AppLogger._();

  // ─── ANSI ─────────────────────────────────────────────────────────────────
  static const _r = '\x1B[0m'; // reset
  static const _b = '\x1B[1m'; // bold
  static const _d = '\x1B[2m'; // dim
  static const _i = '\x1B[3m'; // italic

  static String _ansiColor(Color color) {
    return '\x1B[38;2;${(color.r * 255).round()};${(color.g * 255).round()};${(color.b * 255).round()}m';
  }

  static String get _cSuccess => _ansiColor(AppColor.success500);
  static String get _cError => _ansiColor(AppColor.error500);
  static String get _cWarning => _ansiColor(AppColor.warning500);
  static String get _cRequest => _ansiColor(AppColor.info400);
  static String get _cResponse => _ansiColor(AppColor.info600);
  static String get _cInfo => _ansiColor(AppColor.info500);
  static String get _cDebug => _ansiColor(AppColor.gray500);

  // Custom Socket Colors
  static String get _cSocketIn => '\x1B[38;2;180;100;255m'; // Purple
  static String get _cSocketOut => '\x1B[38;2;255;165;0m'; // Orange

  static String get _bl => _ansiColor(AppColor.primary500);
  static String get _ma => _ansiColor(AppColor.warning500);
  static String get _or => _ansiColor(AppColor.success500);

  static final _top = '╭${'─' * 70}╮';
  static final _mid = '├${'─' * 70}┤';
  static final _bot = '╰${'─' * 70}╯';

  // ─── Generic Console Logger ───────────────────────────────────────────────
  static void _logToConsole({
    required String color,
    required String title,
    String? subtitle,
    dynamic data,
    String icon = '◆',
  }) {
    if (!kDebugMode) return;

    final time = DateTime.now().toString().split(' ').last.split('.').first;
    String body;

    if (data == null) {
      body = '';
    } else {
      try {
        final raw = const JsonEncoder.withIndent('  ').convert(data);
        body = _colorizeJson(raw);
      } catch (_) {
        body = '$color${data.toString()}$_r';
      }
    }

    final buffer = StringBuffer();
    buffer.writeln('$color$_top$_r');
    buffer.writeln('$color│$_r $icon $color$_b$title$_r $_d[$time]$_r');

    if (subtitle != null && subtitle.isNotEmpty) {
      buffer.writeln('$color│$_r $_i$_d$subtitle$_r');
    }

    if (body.isNotEmpty) {
      buffer.writeln('$color$_mid$_r');
      buffer.writeln(_indent(body, color));
    }

    buffer.writeln('$color$_bot$_r');

    log('\n${buffer.toString().trimRight()}', name: '48 Date');
  }

  // ─── Public Console Logging Methods ───────────────────────────────────────
  static void consoleSuccess({
    required String title,
    String? subtitle,
    dynamic data,
  }) => _logToConsole(
    color: _cSuccess,
    title: title,
    subtitle: subtitle,
    data: data,
    icon: '✅',
  );

  static void consoleError({
    required String title,
    String? subtitle,
    dynamic data,
  }) => _logToConsole(
    color: _cError,
    title: title,
    subtitle: subtitle,
    data: data,
    icon: '🚨',
  );

  static void consoleWarning({
    required String title,
    String? subtitle,
    dynamic data,
  }) => _logToConsole(
    color: _cWarning,
    title: title,
    subtitle: subtitle,
    data: data,
    icon: '⚠️',
  );

  static void consoleRequest({
    required String title,
    String? subtitle,
    dynamic data,
  }) => _logToConsole(
    color: _cRequest,
    title: title,
    subtitle: subtitle,
    data: data,
    icon: '📤',
  );

  static void consoleResponse({
    required String title,
    String? subtitle,
    dynamic data,
  }) => _logToConsole(
    color: _cResponse,
    title: title,
    subtitle: subtitle,
    data: data,
    icon: '📥',
  );

  static void consoleInfo({
    required String title,
    String? subtitle,
    dynamic data,
  }) => _logToConsole(
    color: _cInfo,
    title: title,
    subtitle: subtitle,
    data: data,
    icon: '💡',
  );

  static void debug(dynamic message, {String tag = 'DEBUG'}) =>
      _logToConsole(color: _cDebug, title: tag, data: message, icon: '🛠️');

  // ─── Socket Logging ───────────────────────────────────────────────────────
  static void socketOn({required String event, dynamic data}) => _logToConsole(
    color: _cSocketIn,
    title: 'SOCKET ON: $event',
    data: data,
    icon: '⚡',
  );

  static void socketEmit({required String event, dynamic data}) =>
      _logToConsole(
        color: _cSocketOut,
        title: 'SOCKET EMIT: $event',
        data: data,
        icon: '🚀',
      );

  // ─── Premium EasyLoading Configuration ────────────────────────────────────
  static void _setupEasyLoading({
    required Color bgColor,
    required Color fgColor,
  }) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2500)
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = bgColor
      ..textColor = fgColor
      ..indicatorColor = fgColor
      ..progressColor = fgColor
      ..radius = 16.0
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      )
      ..boxShadow = <BoxShadow>[
        BoxShadow(
          color: bgColor.withValues(alpha: 0.2),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ]
      ..textStyle = TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: fgColor,
        letterSpacing: 0.3,
      )
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.black.withValues(alpha: 0.15)
      ..animationStyle = EasyLoadingAnimationStyle.scale
      ..toastPosition = EasyLoadingToastPosition.bottom;
  }

  static void success(String message) {
    _setupEasyLoading(bgColor: AppColor.success500, fgColor: Colors.white);
    EasyLoading.showSuccess(message);
  }

  static void error(String message) {
    _setupEasyLoading(bgColor: AppColor.error500, fgColor: Colors.white);
    EasyLoading.showError(message);
  }

  static void info(String message) {
    _setupEasyLoading(bgColor: AppColor.info500, fgColor: Colors.white);
    EasyLoading.showInfo(message);
  }

  static void warning(String message) {
    _setupEasyLoading(bgColor: AppColor.warning500, fgColor: Colors.white);
    EasyLoading.showToast(message);
  }

  static void loading({String status = 'Loading...'}) {
    _setupEasyLoading(bgColor: AppColor.gray900, fgColor: Colors.white);
    EasyLoading.show(status: status, dismissOnTap: false);
  }

  static void dismiss() => EasyLoading.dismiss();

  // ─── Helpers ──────────────────────────────────────────────────────────────
  static String readableMessage(dynamic value) {
    if (value is String && value.trim().isNotEmpty) return value;
    if (value is Map) {
      for (final key in <String>['message', 'error', 'detail']) {
        final dynamic candidate = value[key];
        if (candidate is String && candidate.trim().isNotEmpty) {
          return candidate;
        }
      }
      for (final key in <String>['result', 'data']) {
        final dynamic nested = value[key];
        final String message = readableMessage(nested);
        if (message != 'request_failed'.tr) return message;
      }
    }
    if (value is List) {
      for (final dynamic item in value) {
        final String message = readableMessage(item);
        if (message != 'request_failed'.tr) return message;
      }
    }
    return 'request_failed'.tr;
  }

  // ─── JSON Colorizer ───────────────────────────────────────────────────────
  static String _colorizeJson(String json) {
    final buffer = StringBuffer();
    int i = 0;
    while (i < json.length) {
      final ch = json[i];
      if (ch == '"') {
        final start = i;
        i++;
        while (i < json.length) {
          if (json[i] == '\\') {
            i += 2;
            continue;
          }
          if (json[i] == '"') {
            i++;
            break;
          }
          i++;
        }
        final raw = json.substring(start, i);
        int peek = i;
        while (peek < json.length && json[peek] == ' ') {
          peek++;
        }
        final isKey = peek < json.length && json[peek] == ':';
        buffer.write(isKey ? '$_bl$_b$raw$_r' : '$_cSuccess$raw$_r');
        continue;
      }
      if (ch == '-' || (ch.codeUnitAt(0) >= 48 && ch.codeUnitAt(0) <= 57)) {
        final start = i;
        while (i < json.length && '0123456789.eE+-'.contains(json[i])) {
          i++;
        }
        buffer.write('$_ma${json.substring(start, i)}$_r');
        continue;
      }
      if (json.startsWith('true', i)) {
        buffer.write('$_or${_b}true$_r');
        i += 4;
        continue;
      }
      if (json.startsWith('false', i)) {
        buffer.write('$_or${_b}false$_r');
        i += 5;
        continue;
      }
      if (json.startsWith('null', i)) {
        buffer.write('$_d$_or${_b}null$_r');
        i += 4;
        continue;
      }
      if ('{}[]'.contains(ch)) {
        buffer.write('$_cWarning$_b$ch$_r');
        i++;
        continue;
      }
      if (ch == ':') {
        buffer.write('$_d:$_r');
        i++;
        continue;
      }
      if (ch == ',') {
        buffer.write('$_d,$_r');
        i++;
        continue;
      }
      buffer.write(ch);
      i++;
    }
    return buffer.toString();
  }

  static String _indent(String text, String borderColor) =>
      text.split('\n').map((line) => '$borderColor│$_r  $line').join('\n');
}
