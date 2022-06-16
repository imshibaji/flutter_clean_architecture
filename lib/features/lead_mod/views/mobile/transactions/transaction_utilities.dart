import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../providers/providers.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';

const transactonsStatuses = [
  'Income',
  'Expense',
];

List getTransactionFilter(List list, [String status = 'All']) {
  if ((status != 'All')) {
    return list
        .where((element) => element?.type.toLowerCase() == status.toLowerCase())
        .toList();
  } else {
    return list;
  }
}

Container quickTotalView(ServiceProvider sp) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              '   Income',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green,
              ),
            ),
            Text(
              '   ',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
            Text(
              'Expense',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
            Text(
              '  ',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              'Balance',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              getTotalIncome(sp.payments!).toM(),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const Text(
              ' - ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            Text(
              getTotalExpense(sp.payments!).toM(),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
            const Text(
              ' = ',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              getBalance(sp.payments!).toM(),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

void showTransactionAdd(BuildContext context) {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  GlobalKey<FormState> _form = GlobalKey();
  Payment payment = Payment();

  showDialog(
    context: context,
    builder: (context) => Form(
      key: _form,
      child: AlertDialog(
        title: const Text('Add Transection'),
        scrollable: true,
        content: SizedBox(
          height: 330,
          child: Column(
            children: [
              TextInputField(
                prefixIcon: Icons.edit,
                labelTextStr: 'Details',
                initialValue: null,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    payment.details = val;
                    return null;
                  }
                  return 'Please Input Details';
                },
              ),
              TextInputField(
                prefixIcon: Icons.edit,
                labelTextStr: 'Amount',
                keyboardType: TextInputType.number,
                initialValue: null,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    payment.amount = double.parse(val);
                    return null;
                  }
                  return 'Please Input Amount';
                },
              ),
              SelectOptionField(
                prefixIcon: Icons.edit,
                options: transactonsStatuses,
                selected: null,
                validator: (val) {
                  if (val != null && val.isNotEmpty) {
                    payment.type = val;
                    return null;
                  }
                  return 'Select Transection Type';
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DateInputField(
                      initialDate: selectedDate,
                      onDateChange: (date) => selectedDate = date,
                    ),
                  ),
                  Expanded(
                    child: TimeInputField(
                      initialTime: selectedDate,
                      onTimeChange: (time) => selectedTime = time,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.cancel),
            label: const Text('Cancel'),
            onPressed: () {
              Nav.close(context);
            },
          ),
          TextButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Save'),
            onPressed: () async {
              if (_form.currentState!.validate()) {
                payment.uid = uuid();
                payment.createdAt = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );

                PaymentService ps = PaymentService();
                await ps.add(payment);

                showMessage(context, 'New transaction added successfully');

                final sp = context.read<ServiceProvider>();
                sp.getAllPayments();

                Nav.close(context);
              }
            },
          )
        ],
      ),
    ),
  );
}

void addTransection(Lead lead, Deal deal, [bool doTran = false]) async {
  if (doTran == true) {
    Payment payment = Payment();
    payment.uid = uuid();
    payment.createdAt = DateTime.now();

    if (deal.status == 'Paid') {
      payment.details = deal.name! + ' paid by ' + lead.name!;
      payment.type = 'Income';
    } else {
      payment.details = deal.name! + ' unpaid by ' + lead.name!;
      payment.type = 'Expense';
    }

    PaymentService ps = PaymentService();
    await ps.add(payment);
  }
}
