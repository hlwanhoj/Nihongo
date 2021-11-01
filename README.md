# Nihongo

App that helps me learn japanese, implemented with [Flutter](https://flutter.dev).


## Road Map

- Vocabularies
	* Help memorising with the use of flash cards
	* Front card face
		- [x] Show Kanji
	* Back card face
		- [x] Show accents
		- [x] Show meaning
		- [ ] Play pronunciation audio
	- Card
		- [x] Gesture to flip card face
	* Flash Cards page
		- [x] Add button to navigate to next card
		- [x] Read card list from local storage
		- [ ] Able to show:
      - [ ] All cards
      - [ ] All untagged cards
      - [ ] Cards with certain tag
      - [ ] Tag selector for changing the list of cards
		- [ ] Apply tinder-like gesture and animation for card navigation [(Reference)](https://pub.dev/packages/flutter_tindercard) 
	* Card tags page
		- [ ] Group cards by tag
		- [ ] Group cards which have no tags
		- [ ] Display the grouped cards
	* Add card
		- [x] Add card through UI
			- [x] Kanji field
			- [x] Kana field
			- [x] Accent selector based on kana input
			- [x] Meaning field 
			- [x] Tags field 
			- [x] Move focus to next field when editing done
		- [x] Save card list to local storage
	* Edit card
		- [x] Reuse the add card UI
		- [x] Save card list to local storage
