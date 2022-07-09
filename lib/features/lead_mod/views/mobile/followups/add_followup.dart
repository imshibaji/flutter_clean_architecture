import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../../awesome_notification/awesome_notification_service.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../providers/providers.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class AddFollowup extends StatefulWidget {
  const AddFollowup({Key? key}) : super(key: key);

  @override
  State<AddFollowup> createState() => _AddFollowupState();
}

class _AddFollowupState extends State<AddFollowup> {
  final GlobalKey<FormState> _followupFormState = GlobalKey<FormState>();
  String? discussion, status;
  String leadStatus = 'Pending';
  Lead? lead;
  Followup ifollowup = Followup();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    final sp = context.read<ServiceProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Followup'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
      body: SizedBox(
        child: Form(
          key: _followupFormState,
          child: ListView(
            children: [
              const SizedBox(
                height: 25,
              ),
              LeadSelectOptionField(
                prefixIcon: Icons.person,
                options: sp.leads,
                selected: null,
                validator: (vlead) {
                  if (vlead != null) {
                    lead = vlead;
                    return null;
                  }
                  return 'Please Choose A Lead';
                },
                onChanged: (vlead) {
                  if (vlead != null &&
                      vlead.status != null &&
                      vlead.status!.toLowerCase() != 'new') {
                    setState(() {
                      leadStatus = vlead.status!;
                    });
                  }
                },
              ),
              TextInputField(
                prefixIcon: Icons.edit_note,
                labelTextStr: 'Discuss Details',
                contentPadding: const EdgeInsets.all(15),
                maxLines: 3,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    discussion = val;
                    return null;
                  }
                  return 'Input Discussion Details';
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: SelectOptionField(
                      prefixIcon: Icons.water_drop_outlined,
                      labelTextStr: 'Lead Status',
                      options: followupStatuses,
                      selected: leadStatus,
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          status = val;
                          return null;
                        }
                        return 'Input Discussion Status';
                      },
                    ),
                  ),
                  Expanded(
                    child: SelectOptionField(
                      prefixIcon: Icons.water_drop_outlined,
                      labelTextStr: 'Task Status',
                      options: const [
                        'Done',
                        'Not Done',
                      ],
                      selected: 'Not Done',
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          isDone = (val == 'Done');
                          return null;
                        }
                        return 'Input Discussion Status';
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: DateInputField(
                      onDateChange: (date) => selectedDate = date,
                    ),
                  ),
                  Expanded(
                    child: TimeInputField(
                      onTimeChange: (time) => selectedTime = time,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AppButton(
                    label: 'Save Now',
                    onPressed: onFollowupSubmit,
                    stretch: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onFollowupSubmit() async {
    if (_followupFormState.currentState!.validate()) {
      setState(() {});
      // Leads Assign
      Lead ilead = lead!;
      ilead.status = status;

      // New Followup create
      Followup ifollowup = Followup();
      ifollowup.uid = uuid();
      ifollowup.discuss = discussion;
      ifollowup.status = status;
      ifollowup.leadUid = lead!.uid;

      ifollowup.schedule = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      ifollowup.isDone = isDone;

      // Box Initial
      FollowupService fs = FollowupService();
      fs.add(ifollowup);

      if (ilead.followups == null) {
        ilead.followups = HiveList(fs.box!);
        ilead.followups!.add(ifollowup);
      } else {
        ilead.followups!.add(ifollowup);
      }

      // Service Provider Initilized
      final sp = context.read<ServiceProvider>();
      // sp.updateLead(ilead);
      ilead.save();

      sp.getAllFollowups();

      showMessage(context, 'New Taks is Added');

      // Setup Notification
      if (ifollowup.status!.toLowerCase() != 'done') {
        AwesomeNotificationService().showActivityNotification(
          'Followup / Activity',
          ifollowup.discuss!,
          payload: {
            'mobile': ilead.mobile ?? '',
            'email': ilead.email ?? '',
            'type': 'LEAD',
            'id': ilead.uid ?? ''
          },
          schedule: ifollowup.schedule,
        );
      }

      Nav.close(context);
    }
  }
}
