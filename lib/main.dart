import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'dart:io';

import './models/transaction.dart';

                  //press ctrl+i for autoformatting the code
import 'package:flutter/material.dart';        //always remeber to add comma after each paranthesis except when have to add semicolon

void main() {

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,

  // ]);


   runApp(MyApp());


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
            primarySwatch: Colors.purple,
            colorScheme: ColorScheme.fromSwatch(accentColor: Colors.amber),
            fontFamily: 'Quicksand',
            appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
                       titleLarge: TextStyle(
                         fontFamily: 'OpenSans',
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     ),
       
            
            textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
           fontWeight: FontWeight.bold,
          ),
          
        ),
      
     
       
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //late final String titleInput;
  

  

   final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 760,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Copy',
    //   amount: 765,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart=false;

  List<Transaction> get _recentTransactions{
              return _userTransactions.where((tx) {
                return tx.date.isAfter(
                  DateTime.now().subtract(
                    Duration(days: 7),
                  
                ),
                );
              }).toList();
            }

  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(
      () {
        _userTransactions.add(newTx);
      },
    );
  }

  void _startAddNewTransaction(BuildContext ctx)
  {

    showModalBottomSheet(context: ctx,
     builder: (bctx){
      
      return GestureDetector(
        onTap: () {
          
        },
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_addNewTransaction));

     },
     );



  }

  void _deleteTansaction(String id)
  {
    setState(() {
      _userTransactions.removeWhere(
        (tx) => tx.id==id
      );
      
    });

  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget)
  {
    return <Widget>[
      Row(
                children: <Widget>[
                  Text('Show Chart'),
                  Switch.adaptive(value: _showChart, onChanged: (val)

                  
                  {
                    setState(() {
                      _showChart= val;
                      
                    });
                  } 
                  )
                ],
              ),_showChart
              ? Container(
                height: (mediaQuery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top) * 0.8,child: Chart(_recentTransactions),)
                : txListWidget,];


              

  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget)
  {
    return  [Container(
              height: (mediaQuery.size.height-appBar.preferredSize.height-mediaQuery.padding.top) * 0.3,
              child: Chart(_recentTransactions),
              ),
              txListWidget];

  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    
    final appBar=        AppBar(
          title: Text('Expense Planner',
          
        style: Theme.of(context).appBarTheme.textTheme!.titleSmall,),
          backgroundColor: Theme.of(context).primaryColor,
          
          actions: <Widget>[
            IconButton(onPressed: ()=>_startAddNewTransaction(context)

            , icon: Icon(Icons.add),
            )
          ],
        );
        final txListWidget=Container(
                height: (mediaQuery.size.height-appBar.preferredSize.height-mediaQuery.padding.top) * 0.7,
                child: TransactionList(_userTransactions,_deleteTansaction)
                );
    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child:Icon(Icons.add,
        ),
        onPressed:
          ()=>_startAddNewTransaction(context)
        , 
        ),
 
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             if (isLandscape)  ..._buildLandscapeContent(mediaQuery,appBar,txListWidget),
              
              if(! isLandscape) ..._buildPortraitContent(mediaQuery,appBar,txListWidget),
                
            
               
              
             


              

          
          ],
          ),
        ));
  }
}
 