import 'package:controle_real/models/MoneyModel.dart';
import 'package:flutter/material.dart';

class EarningDialog extends StatefulWidget {
  final BuildContext context;
  final MoneyModel moneyModel;

  EarningDialog({Key key, this.context, this.moneyModel}) : super(key: key);

  @override
  _EarningDialogState createState() => _EarningDialogState();
}

class _EarningDialogState extends State<EarningDialog> {
  String value = '';
  String title = '';
  String description = '';

  get _enableButton => value.isNotEmpty && title.isNotEmpty;

  _increase(MoneyModel moneyModel) {
    try {
      double num = double.parse(value);
      if (!num.isNaN) {
        var moneyCard = new MoneyCard(
          title: this.title,
          value: num,
          date: DateTime.now(),
          description: this.description,
        );
        moneyModel.add(moneyCard);
        Navigator.pop(context);
      } else
        return null;
    } catch (err) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar gasto'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('cancelar'),
        ),
        FlatButton(
          onPressed: _enableButton ? () => _increase(widget.moneyModel) : null,
          color: Theme.of(context).primaryColor,
          child: Text(
            'adicionar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      content: StatefulBuilder(
        builder: (_, __) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (str) => setState(() => value = str),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      prefixText: 'R\$',
                      // prefixStyle: TextStyle(fontSize: 18),
                      helperText: 'Valor',
                      filled: true,
                    ),
                    style: TextStyle(
                      // fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    onChanged: (str) => setState(() => title = str),
                    textAlign: TextAlign.center,
                    enableSuggestions: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      helperText: 'Título',
                      // filled: true,
                    ),
                  ),
                  TextField(
                    onChanged: (str) => setState(() => description = str),
                    textAlign: TextAlign.center,
                    maxLength: 40,
                    enableSuggestions: true,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      helperText: 'Descrição (opcional)',
                      // filled: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
