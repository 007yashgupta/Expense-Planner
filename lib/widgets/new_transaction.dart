import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime ?_selectedDate;
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(amountController.text.isEmpty)
    {
      return;
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0  || _selectedDate==null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount,_selectedDate);
    print(titleController.text);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){

    showDatePicker(
      context: context,
       initialDate: _selectedDate ?? DateTime.now(),
       //DateTime.now(),
        firstDate: DateTime(2023),
         lastDate: DateTime.now(),
         ).then((pickedDate) {
          if (pickedDate==null){
            return null;
          }

          setState(() {
            _selectedDate=pickedDate;
            
          });

          

         }
          );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left : 10,
            right : 10, 
            bottom: MediaQuery.of(context).viewInsets.bottom+10,
          ),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
    
                //onChanged: (value) => titleInput=value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (_) => submitData(),
                //onChanged: (val) => amountInput=val ,
              ),
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Text(
                      _selectedDate==null ?
    
                      'No Date Chosen!'
                      : DateFormat.yMMMMEEEEd().format(_selectedDate ?? DateTime.now()),
                      //DateFormat.yMd().format(_selectedDate),
                    ),
                    TextButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {_presentDatePicker();},
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white
                      ),
                  child: Text('Add Transaction'),
                  onPressed: () {
                    submitData();
    
                    print(titleController);
                    print(amountController);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
