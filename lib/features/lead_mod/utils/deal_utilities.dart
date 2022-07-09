import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../awesome_notification/awesome_notification_service.dart';
import '../dbobj/dbobjs.dart';
import '../providers/providers.dart';
import '../services/services.dart';

const dealStatuses = [
  'Pending',
  'Paid',
];

void showDealBottomMenu(BuildContext context, Deal deal, ServiceProvider sp,
    {Function(Deal)? onDeal}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    backgroundColor: Colors.black,
    context: context,
    isScrollControlled: true,
    builder: (_) => bottomDealMenus(context, deal, sp, onDeal: onDeal),
  );
}

Container bottomDealMenus(BuildContext context, Deal deal, ServiceProvider sp,
    {Function(Deal)? onDeal}) {
  return Container(
    padding: const EdgeInsets.all(8),
    color: Colors.black54,
    height: 50,
    child: ListView(scrollDirection: Axis.horizontal, children: [
      ElevatedButton.icon(
        icon: const Icon(
          Icons.edit_note_outlined,
          color: Colors.blue,
        ),
        label: const Text(
          'Edit',
          style: TextStyle(color: Colors.blue),
        ),
        onPressed: () {
          Nav.close(context);
          editDeal(context, deal, onDeal: onDeal);
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.done_all_rounded,
          color: Colors.green,
        ),
        label: const Text(
          'Paid',
          style: TextStyle(color: Colors.green),
        ),
        onPressed: () {
          doneDeal(context, deal, sp);
          onDeal!(deal);
          Nav.close(context);
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.close,
          color: Colors.orange,
        ),
        label: const Text(
          'Rejected',
          style: TextStyle(color: Colors.orange),
        ),
        onPressed: () {
          notDoneDeal(context, deal, sp);
          onDeal!(deal);
          showMessage(context, 'Deal/Proposal Status Update as Rejected.');
          Nav.close(context);
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.red,
        ),
        label: const Text(
          'Delete ',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          Nav.close(context);
          deleteConfirmDialog(
            context,
            onAction: () {
              deal.delete();
              sp.getAllDeals();
              if (onDeal != null) {
                onDeal(deal);
              }
              showMessage(context, 'Deal/Proposal Data is Deleted.');
            },
          );
        },
      ),
    ]),
  );
}

// Not used in beta
void viewDeal(BuildContext context, Deal deal) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Deal Details'),
            IconButton(
              tooltip: 'Edit',
              icon: const Icon(Icons.edit),
              onPressed: () {
                Nav.close(context);
                editDeal(context, deal);
              },
            ),
          ],
        ),
        content: SizedBox(
          width: double.infinity,
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deal.name ?? 'Deal Title',
                style: const TextStyle(fontSize: 20),
              ),
              Text(deal.details ?? 'Deal Details'),
              const Divider(),
              Text(
                'Price: ' + deal.price.toString(),
                style: const TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  const Text(
                    'Status: ',
                    style: TextStyle(fontSize: 12),
                  ),
                  StatusText(label: deal.status ?? 'Pending'),
                ],
              )
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          // IconButton(
          //   tooltip: 'Share',
          //   icon: const Icon(
          //     Icons.share,
          //     color: Colors.blue,
          //   ),
          //   onPressed: () {
          //     Nav.close(context);
          //   },
          // ),
          // IconButton(
          //   tooltip: 'Send',
          //   icon: const Icon(
          //     Icons.send_outlined,
          //     color: Colors.green,
          //   ),
          //   onPressed: () {
          //     Nav.close(context);
          //   },
          // ),
          // IconButton(
          //   tooltip: 'Email',
          //   icon: const Icon(
          //     Icons.email,
          //     color: Colors.orange,
          //   ),
          //   onPressed: () {
          //     Nav.close(context);
          //   },
          // ),
          TextButton.icon(
            icon: const Icon(Icons.close_sharp),
            label: const Text('Close'),
            onPressed: () {
              Nav.close(context);
            },
          ),
        ],
      );
    },
  );
}

editDeal(BuildContext context, Deal deal, {Function(Deal)? onDeal}) {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  DateTime selectedDate = deal.createdAt!;

  TimeOfDay selectedTime = TimeOfDay(
    hour: selectedDate.hour,
    minute: selectedDate.minute,
  );
  Deal ideal = deal;
  return showDialog(
    context: context,
    builder: (ctx) {
      return Form(
        key: _form,
        child: AlertDialog(
          title: const Text('Edit Deal'),
          scrollable: true,
          content: SizedBox(
            height: 430,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextInputField(
                    prefixIcon: Icons.edit_note,
                    labelTextStr: 'Deal Name',
                    initialValue: deal.name,
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        ideal.name = val;
                        return null;
                      }
                      return 'Input Discussion Details';
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextInputField(
                    prefixIcon: Icons.edit_note,
                    labelTextStr: 'Deal Deatils',
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    contentPadding: const EdgeInsets.all(9),
                    initialValue: deal.details,
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        ideal.details = val;
                        return null;
                      }
                      return 'Input Deal Details';
                    },
                  ),
                ),
                TextInputField(
                  prefixIcon: Icons.edit_note,
                  labelTextStr: 'Deal Amount',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  contentPadding: const EdgeInsets.all(9),
                  initialValue: deal.price.toString(),
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      ideal.price = double.parse(val);
                      return null;
                    }
                    return 'Input Deal Amount';
                  },
                ),
                TextInputField(
                  prefixIcon: Icons.edit_note,
                  labelTextStr: 'Discount Amount',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  contentPadding: const EdgeInsets.all(9),
                  initialValue:
                      (deal.discount != null) ? deal.discount.toString() : '',
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      ideal.discount = double.parse(val);
                      return null;
                    }
                    return null;
                  },
                ),
                SelectOptionField(
                  prefixIcon: Icons.water_drop_outlined,
                  labelTextStr: 'Status',
                  options: const [
                    'Pending',
                    'Paid',
                  ],
                  selected: deal.status,
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      ideal.status = val;
                      return null;
                    }
                    return 'Input Discussion Status';
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: DateInputField(
                        initialDate: deal.createdAt,
                        onDateChange: (date) => selectedDate = date,
                      ),
                    ),
                    Expanded(
                      child: TimeInputField(
                        initialTime: deal.createdAt,
                        onTimeChange: (time) => selectedTime = time,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Cancel'),
              onPressed: () {
                Nav.close(context);
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              onPressed: () {
                if (_form.currentState!.validate()) {
                  ideal.createdAt = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  ideal.save();
                  final sp = context.read<ServiceProvider>();
                  sp.getAllDeals();

                  // Setup Notification
                  if (ideal.status!.toLowerCase() != 'paid') {
                    final sp = context.read<ServiceProvider>();
                    sp.getAllLeads();
                    Lead ilead = sp.leads!
                        .where(
                          (element) => element.uid == ideal.leadUid,
                        )
                        .first;
                    AwesomeNotificationService().showActivityNotification(
                      'Deal: ' + ideal.name!,
                      ideal.details! +
                          ' amount of ' +
                          (ideal.price! - ideal.discount!).toString() +
                          ' is ' +
                          ideal.status!,
                      payload: {
                        'mobile': ilead.mobile ?? '',
                        'email': ilead.email ?? '',
                        'type': 'LEAD',
                        'id': ilead.uid ?? ''
                      },
                      schedule: ideal.createdAt,
                    );
                  }

                  Nav.close(context);
                  showMessage(context, 'Deal Data is Updated.');
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

void doneDeal(BuildContext context, Deal deal, ServiceProvider sp) async {
  if (deal.status!.toLowerCase() != 'paid') {
    deal.status = 'Paid';
    await deal.save();

    dealPaymentAdd(deal);
    showMessage(context, 'Deal Data is Updated as Paid.');
  }

  sp.getAllDeals();
}

void dealPaymentAdd(Deal deal) async {
  final ps = PaymentService();
  Payment payment = Payment();
  payment.uid = uuid();
  payment.dealUid = deal.uid;
  payment.details = deal.details;
  payment.amount = ((deal.price ?? 0) - (deal.discount ?? 0));
  payment.leadUid = deal.leadUid;
  payment.type = 'Income';
  payment.createdAt = DateTime.now();
  int i = await ps.add(payment);
  payment.save();
  // log(payment.toString());
  log(i.toString());

  final ls = LeadService();
  Lead lead = ls
      .getAll()
      .firstWhere((element) => element.uid!.startsWith(deal.leadUid!));
  lead.status = 'Success';
  await lead.save();
}

void notDoneDeal(BuildContext context, Deal deal, ServiceProvider sp) async {
  if (deal.status!.toLowerCase() == 'paid') {
    deal.status = 'Pending';
    await deal.save();
    // log("Deal: " + deal.uid!);
    dealPaymentRemove(deal);
    showMessage(context, 'Deal Data is Updated as Pending.');
  }
  sp.getAllDeals();
}

void dealPaymentRemove(Deal deal) async {
  final ps = PaymentService();
  Payment payment = ps.getAll().firstWhere((pay) {
    if (pay.dealUid != null && pay.dealUid!.isNotEmpty) {
      return pay.dealUid!.startsWith(deal.uid!);
    }
    return false;
  });

  // log('PayDeal: ' + payment.dealUid!);
  // log(payment.toString());
  await payment.delete();

  final ls = LeadService();
  Lead lead = ls
      .getAll()
      .firstWhere((element) => element.uid!.startsWith(deal.leadUid!));
  lead.status = 'Rejected';
  await lead.save();
}
