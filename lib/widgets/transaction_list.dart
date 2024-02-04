import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction__item.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover)),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(transactions: transactions[index], deleteTx: deleteTx);

                // return   Card(
                //             child: Row(
                //               children: <Widget>[
                //                 Container(
                //                   margin: EdgeInsets.symmetric(
                //                     vertical: 10,
                //                     horizontal: 15,
                //                   ),
                //                   decoration: BoxDecoration(
                //                     border: Border.all(
                //                       color: Theme.of(context).primaryColor,
                //                       width: 2,
                //                     ),
                //                   ),
                //                   child: Text(

                //                     'A: '+'\$${transactions[index].amount.toStringAsFixed(2)}',
                //                     style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Theme.of(context).primaryColor,
                //                       fontSize: 20,
                //                     ),
                //                   ),
                //                 ),
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: <Widget>[
                //                     Text( transactions[index].title,
                //                     style: Theme.of(context).textTheme.titleLarge,
                //                     ),
                //                     Text(DateFormat('EEE, M/d/y').format(transactions[index].date),
                //                     style: TextStyle(
                //                       fontSize: 13,

                //                     ),
                //                     ),
                //                   ],
                //                 )
                //               ],
                //             ),
                //           );
              },
              itemCount: transactions.length,
            ),
    );
  }
}


