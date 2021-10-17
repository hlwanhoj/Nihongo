import 'package:flutter/material.dart';
import 'package:nihongo/word_card_flow/word_card_route_path.dart';

class WordCardRouteParser extends RouteInformationParser<WordCardRoutePath> {
  @override
  Future<WordCardRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    // Always return word list
    return WordCardListRoutePath();
  }
}
