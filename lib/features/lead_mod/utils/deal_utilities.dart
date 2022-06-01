import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../dbobj/dbobjs.dart';
import '../providers/providers.dart';

void showDealBottomMenu(BuildContext context, Deal deal, ServiceProvider sp) {
  showModalBottomSheet(
    context: context,
    builder: (_) => bottomDealMenus(context, deal, sp),
  );
}

Container bottomDealMenus(BuildContext context, Deal deal, ServiceProvider sp) {
  return Container(
    padding: const EdgeInsets.all(8),
    color: Colors.black54,
    height: 50,
    child: ListView(scrollDirection: Axis.horizontal, children: [
      ElevatedButton.icon(
        icon: const Icon(
          Icons.visibility,
        ),
        label: const Text(
          'View',
        ),
        onPressed: () {
          Nav.close(context);
          viewDeal(context, deal);
        },
      ),
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
          editDeal(context, deal);
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
          doneDeal(deal, sp);
          Nav.close(context);
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.done,
          color: Colors.orange,
        ),
        label: const Text(
          'Pending',
          style: TextStyle(color: Colors.orange),
        ),
        onPressed: () {
          notDoneDeal(deal, sp);
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
            },
          );
        },
      ),
    ]),
  );
}

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
          IconButton(
            tooltip: 'Share',
            icon: const Icon(
              Icons.share,
              color: Colors.blue,
            ),
            onPressed: () {
              Nav.close(context);
            },
          ),
          IconButton(
            tooltip: 'Send',
            icon: const Icon(
              Icons.send_outlined,
              color: Colors.green,
            ),
            onPressed: () {
              Nav.close(context);
            },
          ),
          IconButton(
            tooltip: 'Email',
            icon: const Icon(
              Icons.email,
              color: Colors.orange,
            ),
            onPressed: () {
              Nav.close(context);
            },
          ),
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

void editDeal(BuildContext context, Deal deal) {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  DateTime selectedDate = deal.createdAt!;

  TimeOfDay selectedTime = TimeOfDay(
    hour: selectedDate.hour,
    minute: selectedDate.minute,
  );
  Deal ideal = deal;
  showDialog(
    context: context,
    builder: (ctx) {
      return Form(
        key: _form,
        child: AlertDialog(
          title: const Text('Edit Deal'),
          scrollable: true,
          content: SizedBox(
            height: 370,
            child: Column(
              children: [
                TextInputField(
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
                TextInputField(
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
                  Nav.close(context);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

void doneDeal(Deal deal, ServiceProvider sp) {
  deal.status = 'Paid';
  deal.save();
  sp.getAllDeals();
}

void notDoneDeal(Deal deal, ServiceProvider sp) {
  deal.status = 'Pending';
  deal.save();
  sp.getAllDeals();
}
