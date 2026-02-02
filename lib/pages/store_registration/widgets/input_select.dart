import 'package:flutter/material.dart';

class InputSelect extends StatefulWidget {
  const InputSelect({
    super.key,
    this.hintText,
    required this.label,
    this.isRequired = true,
    required this.onSelected,
  });

  final String? hintText;
  final String label;
  final bool isRequired;
  final void Function(String) onSelected;

  @override
  State<InputSelect> createState() => _InputSelectState();
}

class _InputSelectState extends State<InputSelect> {
  bool _hasError = false;
  String? selectedValue;
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
              border: Border.all(color: Color(0xffc1c1c1)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButton<String>(
                hint: Text(
                  widget.hintText ?? 'Select details',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xffa3a3a3),
                  ),
                ),
                icon: Icon(Icons.keyboard_arrow_down),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xffa3a3a3),
                ),
                isExpanded: true,
                underline: SizedBox(),
                value: selectedValue,
                items: ['Select details', '', ''].map((code) {
                  return DropdownMenuItem(value: code, child: Text(code));
                }).toList(),
                onChanged: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() => _hasError = true);
                  }

                  setState(() => _hasError = false);

                  widget.onSelected;
                },
              ),
            ),
          ),
          if (_hasError)
            Padding(
              padding: EdgeInsets.only(top: 4, left: 4),
              child: Text(
                '    ${widget.hintText}',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
