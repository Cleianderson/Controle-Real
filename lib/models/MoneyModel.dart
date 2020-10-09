import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneyModel extends ChangeNotifier {
  double _earnings;
  double _spending;
  List<MoneyCard> _items = [];

  _transformArrayInMoneyModel(List<String> _strArr) {
    List<MoneyCard> _itemsFromString = [];
    for (var arr in _strArr) {
      arr = arr.replaceAll('[', '').replaceAll(']', '');
      var values = arr.split(',');
      print(values[2]);
      var moneyCard = new MoneyCard(
        title: values[0],
        value: double.parse(values[1]),
        date: DateTime.parse(values[2]),
        description: values[3],
      );
      _itemsFromString.add(moneyCard);
    }
    this._items = _itemsFromString;
  }

  _transformMoneyModelInArray() {
    List<String> _strItems = [];
    for (var items in _items) {
      var _date = items.date.toIso8601String();
      var _value = items.value.toString();
      _strItems.add([
        items.title,
        _value,
        _date,
        items.description,
      ].toString());
    }
    print(_strItems);
    return _strItems;
  }

  _initMoneyModelFromStorage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var moneyCard = _pref.getStringList(MoneyKeys.moneyCards);
    if (moneyCard != null) {
      _transformArrayInMoneyModel(moneyCard);
    }
  }

  _writeMoneyModelToStorage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setStringList(MoneyKeys.moneyCards, _transformMoneyModelInArray());
  }

  MoneyModel({double earning, double spending}) {
    this._earnings = earning != null ? earning : 0;
    this._spending = spending != null ? spending : 0;
    _initMoneyModelFromStorage();
  }

  double get earnings {
    double _count = 0;
    this._items.forEach((moneyCard) {
      if (moneyCard.value.sign > 0) return _count += moneyCard.value;
    });
    return _count;
  }

  double get spending {
    double _count = 0;
    this._items.forEach((moneyCard) {
      if (moneyCard.value.sign < 0) return _count += moneyCard.value;
    });
    return _count;
  }

  UnmodifiableListView<MoneyCard> get items => UnmodifiableListView(_items);

  add(MoneyCard card) {
    this._items.add(card);
    notifyListeners();
    _writeMoneyModelToStorage();
  }

  remove(MoneyCard card) {
    this._items.remove(card);
    notifyListeners();
    _writeMoneyModelToStorage();
  }

  increase(double value) {
    if (value.sign > 0) {
      this._earnings += value;
    } else if (value.sign == -1) {
      this._spending += value;
    }
    print(value);
    notifyListeners();
  }
}

class MoneyCard {
  String title;
  String description;
  DateTime date;
  double value;

  String get time {
    var day = date.day < 10 ? '0${date.day}' : date.day;
    var month = date.month < 10 ? '0${date.month}' : date.month;
    var year = date.year.toString().substring(
          date.year.toString().length - 2,
        );
    return '$day/$month/$year';
  }

  MoneyCard({
    @required this.title,
    @required this.date,
    @required this.value,
    this.description,
  });
}

class MoneyKeys {
  static final String moneyCards = 'ControleReal:moneyCards';
}
