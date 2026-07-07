import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalGeocodingService {

static final Map<String, LatLng> places = {

  // Tenkasi District
  "tenkasi": const LatLng(8.9598,77.3152),
  "sengottai": const LatLng(8.9733,77.4800),
  "courtallam": const LatLng(8.9296,77.2758),
  "kadayanallur": const LatLng(9.0727,77.3418),
  "puliyangudi": const LatLng(9.1737,77.3973),
  "shencottai": const LatLng(8.9733,77.4800),
  "alangulam": const LatLng(8.8648,77.4994),
  "surandai": const LatLng(8.9755,77.4210),
  "melagaram": const LatLng(8.9510,77.3090),
  "ayikudi": const LatLng(8.9778,77.3494),
  "pavoorchatram": const LatLng(8.9177,77.3835),
  "vasudevanallur": const LatLng(9.2417,77.4116),

  // Tirunelveli
  "tirunelveli": const LatLng(8.7139,77.7567),
  "palayamkottai": const LatLng(8.7284,77.7354),
  "pettai": const LatLng(8.7435,77.7162),
  "cheranmahadevi": const LatLng(8.6843,77.5802),
  "ambasamudram": const LatLng(8.7065,77.4525),
  "valliyur": const LatLng(8.3825,77.6145),
  "nanguneri": const LatLng(8.4933,77.6585),
  "thisayanvilai": const LatLng(8.3372,77.8673),
  "manur": const LatLng(8.8791,77.6538),
  "kalakkad": const LatLng(8.5147,77.5518),

  // Virudhunagar
  "rajapalayam": const LatLng(9.4520,77.5536),
  "sivakasi": const LatLng(9.4496,77.7970),
  "virudhunagar": const LatLng(9.5851,77.9579),
  "srivilliputhur": const LatLng(9.5127,77.6337),
  "sattur": const LatLng(9.3658,77.9243),
  "aruldhaspuram": const LatLng(9.4920,77.6200),
  "watrap": const LatLng(9.6355,77.6317),

  // Madurai
  "madurai": const LatLng(9.9252,78.1198),
  "thirumangalam": const LatLng(9.8232,77.9860),
  "usilampatti": const LatLng(9.9694,77.7862),
  "melur": const LatLng(10.0327,78.3394),
  "vadipatti": const LatLng(10.0853,77.9628),

  // Thoothukudi
  "thoothukudi": const LatLng(8.7642,78.1348),
  "kovilpatti": const LatLng(9.1717,77.8692),
  "kayathar": const LatLng(8.9470,77.7748),
  "ettayapuram": const LatLng(9.1452,78.0044),

  // Kanyakumari
  "nagercoil": const LatLng(8.1780,77.4344),
  "kanyakumari": const LatLng(8.0883,77.5385),
  "marthandam": const LatLng(8.3123,77.2235),
  "colachel": const LatLng(8.1798,77.2580),

  // Theni
  "theni": const LatLng(10.0104,77.4768),
  "cumbum": const LatLng(9.7372,77.2848),
  "bodinayakanur": const LatLng(10.0116,77.3497),

  // Dindigul
  "dindigul": const LatLng(10.3673,77.9803),
  "palani": const LatLng(10.4500,77.5200),

  // Ramanathapuram
  "paramakudi": const LatLng(9.5460,78.5907),
  "ramanathapuram": const LatLng(9.3639,78.8395),

  // Popular Landmarks
  "tenkasi bus stand": const LatLng(8.9592,77.3155),
  "tenkasi railway station": const LatLng(8.9580,77.3114),
  "courtallam main falls": const LatLng(8.9292,77.2746),
  "agasthiyar falls": const LatLng(8.6730,77.3435),
  "tirunelveli junction": const LatLng(8.7330,77.7270),
  "nellaiappar temple": const LatLng(8.7287,77.7086),
  "rajapalayam bus stand": const LatLng(9.4515,77.5530),
  "sivakasi bus stand": const LatLng(9.4495,77.7980),
  "madurai railway station": const LatLng(9.9186,78.1107),
  "madurai meenakshi temple": const LatLng(9.9195,78.1193),
  "kovilpatti bus stand": const LatLng(9.1712,77.8688),
  "nagercoil bus stand": const LatLng(8.1778,77.4330),
};
  static LatLng? getCoordinates(String place) {
    return places[place.trim().toLowerCase()];
  }
}