
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';




class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.transactions,
    required this.deleteTx,
  });

  final Transaction transactions;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
 

  Color? _bgColor;


  void initState()
  {
    const availableColors =[
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,


    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState(); 
  
  }
   @override

  Widget build(BuildContext context) {
    return Card(
      
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text('\$${widget.transactions.amount}'),
              ),
            ),
          ),
          title: Text(
            widget.transactions.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            DateFormat.yMMMMEEEEd()
                .format(widget.transactions.date),
          ),
          trailing: MediaQuery.of(context).size.width > 360
              ? TextButton.icon(
                  onPressed: () => widget.deleteTx(widget.transactions.id),
                  icon: Icon(Icons.delete),
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                  label: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : IconButton(
                  onPressed: () {
                    widget.deleteTx(widget.transactions.id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                )),
    );
  }
}