import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/core/utils/extensions.dart';
import 'package:getx_task/app/data/models/task.dart';
import 'package:getx_task/app/modules/home/controller.dart';
import 'package:getx_task/app/widgets/icons.dart';

import '../../../core/values/colors.dart';

class AddCard extends StatelessWidget {
  final homeCtr = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeCtr.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtr.editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map((e) => Obx(
                                () {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    selectedColor: Colors.grey[200],
                                    pressElevation: 0,
                                    backgroundColor: Colors.white,
                                    label: e,
                                    selected: homeCtr.chipIndex.value == index,
                                    onSelected: (bool seleted) {
                                      homeCtr.chipIndex.value =
                                          seleted ? index : 0;
                                    },
                                  );
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (homeCtr.formKey.currentState!.validate()) {
                        int icon =
                            icons[homeCtr.chipIndex.value].icon!.codePoint;
                        String color =
                            icons[homeCtr.chipIndex.value].color!.toHex();
                        var task = Task(
                          title: homeCtr.editController.text,
                          icon: icon,
                          color: color,
                        );
                        // pop dialog
                        Get.back();
                        // add task
                        homeCtr.addTask(task)
                            ? EasyLoading.showSuccess('Create sucess')
                            : EasyLoading.showError('Duplicated Task');
                      }
                    },
                    child: const Text("Confirm"),
                  ),
                ],
              ),
            ),
          );
          // clear text form field
          homeCtr.editController.clear();
          homeCtr.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
