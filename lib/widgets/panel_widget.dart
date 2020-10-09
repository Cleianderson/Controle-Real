import 'package:controle_real/models/MoneyModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Panel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoneyModel>(
      builder: (_, moneyModel, child) {
        var balance = moneyModel.earnings + moneyModel.spending;

        _colorize() {
          if (balance.sign > 0)
            return Colors.green[800];
          else if (balance.sign == -1) return Colors.red[800];
          return Colors.grey[700];
        }

        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Ganhos',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${moneyModel.earnings}',
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Saldo',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$balance',
                    style: TextStyle(
                      color: _colorize(),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Gastos',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${moneyModel.spending}',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
