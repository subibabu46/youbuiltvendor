import 'dart:io';

import 'package:design_task_1/providers/file_picker_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadFile extends ConsumerStatefulWidget {
  const UploadFile({
    super.key,
    this.hintText,
    required this.label,
    this.isRequired = true,
    this.showFile = false,
    required this.onPressed,
  });

  final String? hintText;
  final String label;
  final bool isRequired;
  final bool showFile;
  final ValueChanged<File?> onPressed;

  @override
  ConsumerState<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends ConsumerState<UploadFile> {
  File? selectedFile;
  bool isFileVisible = false;

  @override
  void initState() {
    super.initState();
    isFileVisible = widget.showFile;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
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
          if (selectedFile != null && widget.showFile && isFileVisible)
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 8),
              child: Stack(
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Color(0xffd1d5db)),
                      color: Color(0xfff4f4f4),
                    ),
                    child: selectedFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              selectedFile!,
                              fit: BoxFit.contain,
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() => isFileVisible = false);
                      },
                      icon: Icon(Icons.close, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              try {
                final result = await ref
                    .read(filePickerServiceProvider)
                    .pickFile();
                setState(() {
                  selectedFile = result;
                  isFileVisible = true;
                });
                widget.onPressed(result);
              } catch (e) {
                if (context.mounted) messageTost(e.toString(), context);
              }
            },
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                dashPattern: [6, 6],
                strokeWidth: 1,
                radius: Radius.circular(6),
                color: Color(0xffc1c1c1),
              ),
              child: Container(
                width: 361,
                height: 58,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (selectedFile == null)
                        Image.asset('assets/Vector.png', width: 24, height: 24),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          selectedFile != null
                              ? '${selectedFile?.path.split('/').last}'
                              : 'Upload File',
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
