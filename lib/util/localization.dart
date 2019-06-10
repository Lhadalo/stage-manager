import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class Localization {
  Localization(this._locale);

  final Locale _locale;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  static Map<String, Map<int, String>> _localizedNumbers = {
    'en': {
      1: 'One',
      2: 'Two',
      3: 'Three',
      4: 'Four',
      5: 'Five',
      6: 'Six',
      7: 'Seven',
      8: 'Eight',
      9: 'Nine',
      10: 'Ten',
    },
    'sv': {
      1: 'Ett',
      2: 'Två',
      3: 'Tre',
      4: 'Fyra',
      5: 'Fem',
      6: 'Sex',
      7: 'Sju',
      8: 'Åtta',
      9: 'Nio',
      10: 'Tio',
    }
  };

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Stage Manager',
      'title_edit': 'Edit Counters',
      'btn_edit': 'Edit Counters',
      'btn_start': 'Start',
      'btn_reset': 'Reset',
      'btn_finish': 'Finish Show',
      'btn_share': 'Share Show',
      'btn_add_act': 'Add Act',
      'btn_add_paus': 'Add Intermission',
      'title_started': 'Started',
      'title_start_time': 'Start Time',
      'title_stop_time': 'Stop Time',
      'title_duration': 'Duration',
      'title_total_playing_time': 'Total playing time',
      'alert_reset_title': 'Reset Show?',
      'alert_reset_message': 'Are you sure? All data will be lost.',
      'alert_reset_btn_positive': 'Reset',
      'alert_reset_btn_negative': 'Cancel',
      'alert_add_title': 'Add Counter',
      'alert_add_label': 'Act/Interval',
      'alert_add_text_hint': 'Name of act',
      'alert_add_btn_positive': 'Update',
      'alert_add_btn_negative': 'Cancel',
      'edit_counters_empty_state': 'No acts',
      'share_started': 'Started',
      'share_ended': 'Ended',
      'share_total_time': 'Total Time',
      'act_prefix': 'Act ',
      'paus': 'Intermission'
    },
    'sv': {
      'title': 'Föreställningsapp',
      'title_edit': 'Redigera Räknare',
      'btn_edit': 'Redigera',
      'btn_start': 'Starta',
      'btn_reset': 'Återställ',
      'btn_finish': 'Avsluta Föreställning',
      'btn_share': 'Dela Föreställning',
      'btn_add_act': 'Lägg Till Akt',
      'btn_add_paus': 'Lägg Till Paus',
      'title_started': 'Startade',
      'title_start_time': 'Starttid',
      'title_stop_time': 'Stopptid',
      'title_duration': 'Tid',
      'title_total_playing_time': 'Total Speltid',
      'alert_reset_title': 'Återställ Föreställning?',
      'alert_reset_message': 'Är du säker? All data förloras.',
      'alert_reset_btn_positive': 'Återställ',
      'alert_reset_btn_negative': 'Avbryt',
      'alert_add_title': 'Lägg till räknare',
      'alert_add_label': 'Akt/Paus',
      'alert_add_hint': 'Namn på akt',
      'alert_add_btn_positive': 'Uppdatera',
      'alert_add_btn_negative': 'Avbryt',
      'edit_counters_empty_state': 'Inga akter, lägg till med knappar nedan!',
      'share_started': 'Startade',
      'share_ended': 'Slutade',
      'share_total_time': 'Total Tid',
      'act_prefix': 'Akt ',
      'paus': 'Paus'
    }
  };

  String getString(String code) {
    return _localizedValues[_locale.languageCode][code];
  }

  String getCounterTitle(int index, {bool isIntermission = false}) {
    if (isIntermission) return _localizedValues[_locale.languageCode]['paus'];
    if (index < 10 && index > 0) return _localizedValues[_locale.languageCode]['act_prefix'] +
        _localizedNumbers[_locale.languageCode][index];
    else return _localizedValues[_locale.languageCode]['act_prefix'] + '$index';
  }
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'sv'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) {
    return SynchronousFuture<Localization>(Localization(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}
