import 'package:design_task_1/models/response_model.dart';
import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputSelect extends StatefulWidget {
  const InputSelect({
    super.key,
    this.hintText,
    required this.label,
    this.isRequired = true,
    this.onSelectedString,
    required this.asyncList,
    this.onSelectedInt,
  });

  final String? hintText;
  final String label;
  final bool isRequired;
  final void Function(String)? onSelectedString;
  final void Function(int)? onSelectedInt;
  final AsyncValue<ResponseModel>? asyncList;

  @override
  State<InputSelect> createState() => _InputSelectState();
}

class _InputSelectState extends State<InputSelect> {
  bool _hasError = false;
  GetModel? selectedValue;
  @override
  void didUpdateWidget(covariant InputSelect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.asyncList != widget.asyncList) {
      setState(() {
        selectedValue = null;
        _hasError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              children: [
                TextSpan(text: widget.label),
                widget.isRequired
                    ? TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.textRequired),
                      )
                    : TextSpan(),
              ],
            ),
          ),

          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: widget.asyncList != null
                  ? widget.asyncList?.when(
                      data: (result) {
                        final data = result.data as List<GetModel>;
                        return DropdownButton<GetModel>(
                          hint: Text(
                            widget.hintText ?? 'Select details',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.textHint,
                            ),
                          ),
                          icon: Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.textHint,
                          ),
                          isExpanded: true,
                          underline: SizedBox(),
                          value: selectedValue,
                          items: data.isNotEmpty
                              ? data.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e.label),
                                  );
                                }).toList()
                              : [],

                          onChanged: (value) {
                            if (value == null ||
                                value.label.isEmpty ||
                                value.value.isNaN) {
                              setState(() => _hasError = true);
                              return;
                            }

                            setState(() {
                              _hasError = false;
                              selectedValue = value;
                            });

                            if (widget.onSelectedInt != null) {
                              widget.onSelectedInt!(value.value);
                            } else if (widget.onSelectedString != null) {
                              widget.onSelectedString!(value.label);
                            }
                          },
                        );
                      },
                      loading: () => SizedBox(
                        height: 44,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            textAlign: TextAlign.left,
                            'Select details',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                      ),
                      error: (error, stackTrace) => Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 44,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          textAlign: TextAlign.left,
                          'Select details',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.textHint,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          if (_hasError)
            Padding(
              padding: EdgeInsets.only(top: 4, left: 4),
              child: Text(
                '    ${widget.hintText}',
                style: TextStyle(color: AppColors.textRequired, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
