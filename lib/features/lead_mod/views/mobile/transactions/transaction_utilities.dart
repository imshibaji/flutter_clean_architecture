import 'package:clean_architecture/features/lead_mod/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../services/services.dart';

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
          height: 310,
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
                options: const ['Income', 'Expense'],
                selected: 'Income',
                validator: (val) {
                  if (val!.isNotEmpty) {
                    payment.type = val;
                    return null;
                  }
                  return 'Please Input Details';
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
