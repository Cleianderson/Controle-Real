import 'package:controle_real/models/MoneyModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardListPanel extends StatefulWidget {
  @override
  _CardListPanelState createState() => _CardListPanelState();
}

class _CardListPanelState extends State<CardListPanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoneyModel>(
      builder: (_, moneyModel, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: moneyModel.items.length,
          padding: EdgeInsets.only(bottom: 100),
          physics: BouncingScrollPhysics(),
          itemBuilder: (_context, index) {
            var _title = moneyModel.items.elementAt(index).title;
            var _value = moneyModel.items.elementAt(index).value;
            var _time = moneyModel.items.elementAt(index).time;
            var _description = moneyModel.items.elementAt(index).description;

            return Card(
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            _time,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                          _description.trim() != ''
                              ? Column(
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      _description,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(width: 0, height: 0),
                        ],
                      ),
                    ),
                    Text(
                      '$_value',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: _value.sign < 0 ? Colors.red : Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
