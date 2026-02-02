import 'package:design_task_1/providers/country_code_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputNumber extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool isRequired;
  final void Function(String)? onCountryCodeChanged;

  const InputNumber({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    this.isRequired = true,
    this.onCountryCodeChanged,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputNumberState();
}

class _InputNumberState extends ConsumerState<InputNumber> {
  bool _hasError = false;

  String? selectedValue = '+91';
  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final controller = widget.controller;
    final hintText = widget.hintText;
    final isRequired = widget.isRequired;

    final countryCodesAsync = ref.watch(countryCodesProvider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              children: [
                TextSpan(text: label),
                isRequired
                    ? TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red),
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
              border: Border.all(
                color: _hasError ? Colors.red : const Color(0xffc1c1c1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  countryCodesAsync.when(
                    data: (codes) {
                      return DropdownButton<String>(
                        underline: SizedBox(),
                        value: selectedValue,
                        items: codes.map((code) {
                          return DropdownMenuItem(
                            value: code.label,
                            child: Text(code.label),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                          if (value != null &&
                              widget.onCountryCodeChanged != null) {
                            widget.onCountryCodeChanged!(value);
                          }
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        messageTost('Something went wrong', context);
                      });

                      return Center(child: Text('+ '));
                    },
                  ),

                  SizedBox(width: 8),
                  Container(width: 1, height: 24, color: Color(0xffe0e0e0)),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText ?? 'Enter details',
                        hintStyle: TextStyle(
                          color: Color(0xffa3a3a3),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        errorStyle: const TextStyle(height: 0, fontSize: 0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() => _hasError = true);
                          return 'Enter Your $label';
                        }

                        setState(() => _hasError = false);
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_hasError)
            Padding(
              padding: EdgeInsets.only(top: 4, left: 4),
              child: Text(
                '    Enter Your $label',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
