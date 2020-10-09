import 'package:controle_real/dialogs/earning_dialog.dart';
import 'package:controle_real/models/MoneyModel.dart';
import 'package:controle_real/widgets/card_list_panel_widget.dart';
import 'package:controle_real/widgets/panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Controle Real',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => MoneyModel(),
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, Function> _actions() {
    return {
      'gasto': (BuildContext _cntx, MoneyModel moneyModel) => showDialog(
            context: _cntx,
            builder: (cntx) =>
                EarningDialog(context: cntx, moneyModel: moneyModel),
          )
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoneyModel>(
      builder: (_, moneyModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Controle Real'),
          elevation: 0,
        ),
        drawer: Drawer(),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: EdgeInsets.only(top: 30),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Panel(),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: CardListPanel(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: PopupMenuButton(
            itemBuilder: (ctnx) => [
              PopupMenuItem(
                child: Text('Gasto'),
                value: 'gasto',
              ),
              PopupMenuItem(
                child: Text('Bloco de Gastos'),
                value: 'block_gasto',
              ),
              PopupMenuItem(
                child: Text('Ganhos'),
                value: 'ganho',
              ),
            ],
            icon: Icon(Icons.add),
            onSelected: (str) => _actions()[str] != null
                ? _actions()[str](context, moneyModel)
                : print(str),
          ),
        ),
      ),
    );
  }
}
