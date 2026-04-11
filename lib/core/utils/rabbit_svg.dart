/// 勤力兔 SVG 佔位圖 (簡約版)
/// 參考: prd.md Section 6.1
/// 使用程式化圓形兔子臉作為佔位符
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 程式化圓形兔子 SVG (站立微笑)
const String rabbitIdleSvg = '''
<svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
  <circle cx="100" cy="110" r="70" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="70" cy="50" rx="18" ry="35" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="130" cy="50" rx="18" ry="35" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="70" cy="48" rx="10" ry="25" fill="#FFB6C1"/>
  <ellipse cx="130" cy="48" rx="10" ry="25" fill="#FFB6C1"/>
  <circle cx="80" cy="100" r="8" fill="#424242"/>
  <circle cx="120" cy="100" r="8" fill="#424242"/>
  <circle cx="83" cy="97" r="3" fill="#FFFFFF"/>
  <circle cx="123" cy="97" r="3" fill="#FFFFFF"/>
  <ellipse cx="65" cy="115" rx="10" ry="6" fill="#FFB6C1" opacity="0.5"/>
  <ellipse cx="135" cy="115" rx="10" ry="6" fill="#FFB6C1" opacity="0.5"/>
  <path d="M 90 120 Q 100 130 110 120" stroke="#424242" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 95 128 Q 100 135 105 128" fill="#FFB6C1"/>
  <polygon points="100,150 85,170 115,170" fill="#DE2910"/>
  <path d="M 155 95 Q 175 85 180 65" stroke="#F5F5F5" stroke-width="8" stroke-linecap="round"/>
</svg>
''';

/// 程式化兔子 SVG (穿西裝拋金幣)
const String rabbitMoneySvg = '''
<svg viewBox="0 0 250 250" xmlns="http://www.w3.org/2000/svg">
  <circle cx="125" cy="130" r="75" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="90" cy="60" rx="20" ry="40" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="160" cy="60" rx="20" ry="40" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="90" cy="58" rx="11" ry="28" fill="#FFB6C1"/>
  <ellipse cx="160" cy="58" rx="11" ry="28" fill="#FFB6C1"/>
  <circle cx="105" cy="120" r="9" fill="#424242"/>
  <circle cx="145" cy="120" r="9" fill="#424242"/>
  <circle cx="108" cy="117" r="3.5" fill="#FFFFFF"/>
  <circle cx="148" cy="117" r="3.5" fill="#FFFFFF"/>
  <path d="M 110 140 Q 125 155 140 140" stroke="#424242" stroke-width="2.5" fill="none" stroke-linecap="round"/>
  <polygon points="125,170 100,200 150,200" fill="#333333"/>
  <line x1="125" y1="170" x2="125" y2="200" stroke="#DE2910" stroke-width="3"/>
  <circle cx="200" cy="60" r="25" fill="#FFD700" stroke="#E6B800" stroke-width="2"/>
  <text x="200" y="68" text-anchor="middle" font-size="24" fill="#8B6914">£</text>
</svg>
''';

/// 程式化兔子 SVG (慶祝撒花)
const String rabbitCelebrateSvg = '''
<svg viewBox="0 0 300 300" xmlns="http://www.w3.org/2000/svg">
  <circle cx="150" cy="160" r="80" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="105" cy="75" rx="22" ry="45" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="195" cy="75" rx="22" ry="45" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="105" cy="73" rx="12" ry="30" fill="#FFB6C1"/>
  <ellipse cx="195" cy="73" rx="12" ry="30" fill="#FFB6C1"/>
  <circle cx="130" cy="145" r="10" fill="#424242"/>
  <circle cx="170" cy="145" r="10" fill="#424242"/>
  <circle cx="133" cy="142" r="4" fill="#FFFFFF"/>
  <circle cx="173" cy="142" r="4" fill="#FFFFFF"/>
  <path d="M 130 170 Q 150 190 170 170" stroke="#424242" stroke-width="3" fill="none" stroke-linecap="round"/>
  <circle cx="70" cy="50" r="5" fill="#FFD700"/>
  <circle cx="230" cy="40" r="4" fill="#FF6B6B"/>
  <circle cx="50" cy="120" r="4" fill="#007AFF"/>
  <circle cx="250" cy="100" r="5" fill="#34C759"/>
  <circle cx="80" cy="280" r="4" fill="#AF52DE"/>
  <circle cx="220" cy="270" r="5" fill="#FFD700"/>
  <circle cx="40" cy="200" r="3" fill="#FF9500"/>
  <circle cx="260" cy="180" r="4" fill="#FF6B6B"/>
  <path d="M 80 230 Q 60 200 40 180" stroke="#FFD700" stroke-width="3" stroke-linecap="round" fill="none"/>
  <path d="M 220 230 Q 240 200 260 180" stroke="#FFD700" stroke-width="3" stroke-linecap="round" fill="none"/>
</svg>
''';

/// 程式化兔子 SVG (豎拇指)
const String rabbitThumbsUpSvg = '''
<svg viewBox="0 0 150 150" xmlns="http://www.w3.org/2000/svg">
  <circle cx="75" cy="85" r="55" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="52" cy="40" rx="14" ry="30" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="98" cy="40" rx="14" ry="30" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="52" cy="38" rx="8" ry="20" fill="#FFB6C1"/>
  <ellipse cx="98" cy="38" rx="8" ry="20" fill="#FFB6C1"/>
  <path d="M 58 78 Q 63 73 68 78" stroke="#424242" stroke-width="3" fill="none"/>
  <path d="M 82 78 Q 87 73 92 78" stroke="#424242" stroke-width="3" fill="none"/>
  <ellipse cx="50" cy="92" rx="8" ry="5" fill="#FFB6C1" opacity="0.5"/>
  <ellipse cx="100" cy="92" rx="8" ry="5" fill="#FFB6C1" opacity="0.5"/>
  <path d="M 62 100 Q 75 112 88 100" stroke="#424242" stroke-width="2.5" fill="none" stroke-linecap="round"/>
</svg>
''';

/// 程式化兔子 SVG (驚訝)
const String rabbitSurprisedSvg = '''
<svg viewBox="0 0 150 150" xmlns="http://www.w3.org/2000/svg">
  <circle cx="75" cy="85" r="55" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="52" cy="40" rx="14" ry="30" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="98" cy="40" rx="14" ry="30" fill="#F5F5F5" stroke="#E0E0E0" stroke-width="2"/>
  <ellipse cx="52" cy="38" rx="8" ry="20" fill="#FFB6C1"/>
  <ellipse cx="98" cy="38" rx="8" ry="20" fill="#FFB6C1"/>
  <circle cx="58" cy="78" r="10" fill="#424242"/>
  <circle cx="92" cy="78" r="10" fill="#424242"/>
  <circle cx="61" cy="75" r="4" fill="#FFFFFF"/>
  <circle cx="95" cy="75" r="4" fill="#FFFFFF"/>
  <ellipse cx="75" cy="108" rx="10" ry="12" fill="#424242"/>
</svg>
''';

/// Get rabbit SVG string by type
String getRabbitSvg(String type) {
  switch (type) {
    case 'money':
      return rabbitMoneySvg;
    case 'celebrate':
      return rabbitCelebrateSvg;
    case 'thumbs_up':
      return rabbitThumbsUpSvg;
    case 'surprised':
      return rabbitSurprisedSvg;
    default:
      return rabbitIdleSvg;
  }
}

/// Rabbit widget that displays SVG from string
class RabbitSvgWidget extends StatelessWidget {
  const RabbitSvgWidget({super.key, this.type = 'idle', this.size = 150});

  final String type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.string(getRabbitSvg(type), width: size, height: size),
    );
  }
}
