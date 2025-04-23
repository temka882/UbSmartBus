import 'package:get/get.dart';

const appname = "UB";
const appversion = "Version 1.0.0";
const credits = "@Temuulen @Selem @Miigaa";
const msg1 = "Автобусыг явах чиглэлийн дагуу хайх бол энд дарна уу";
const msg2 = "Автобусыг байрлах буудлын дагуу хайх бол энд дарна уу";
const msg3 = "Улаанбаатар ухаалаг автобус";
const msg4 = "Нийтийн тээвэр ";

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'favorites': 'Favorites',
          'bus_routes': 'Bus Routes',
          'bus_stops': 'Bus Stops',
          'report_issue': 'Report an Issue',
          'settings': 'Settings',
          'language': 'Language',
          'dark_mode': 'Dark Mode',
          'loading': 'Loading...',
          'bus': 'Bus',
          'bus_stop': 'Bus stop',
          'charge': 'charge',
          'scan_card': 'Scan card',
          'card_text1': 'Umoney recharge locations',
          'card_text2': 'Umoney card recharge',
          'card_text3': 'Please place your Umoney card steadily ',
          'card_text4': 'on your phone NFC reader to complete the recharge.',
          'card_text5': 'History',
        },
        'mn_MN': {
          'favorites': 'Таны дуртай',
          'bus_routes': 'Автобусны чиглэлүүд',
          'bus_stops': 'Автобусны буудлууд',
          'report_issue': 'Асуудал мэдээллэх',
          'settings': 'Тохиргоо',
          'language': 'Хэл',
          'dark_mode': 'Харанхуй горим',
          'loading': 'Уншиж байна...',
          'bus': 'Автобус',
          'bus_stop': 'Буудлал',
          'charge': 'цэнэгэх',
          'scan_card': 'Карт уншуулах',
          'card_text1': 'Umoney цэнэглэлт хийдэг цэгүүд',
          'card_text2': 'Umoney карт цэнэглэх',
          'card_text3': 'Umoney картаа утасныхаа NFC уншигчид',
          'card_text4': 'хөдөлгөөнгүй байрлуулан цэнэглэлт хийнэ үү',
          'card_text5': 'Автобусанд суусан түүх',
        }
      };
}
