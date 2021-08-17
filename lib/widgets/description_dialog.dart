import 'package:flutter/material.dart';
import 'package:movie_app_hivedb/model/description.dart';

class DescriptionDialog extends StatefulWidget {
  final Description? description;
  final Function(String name, String director, String imgUrl, bool isDesc)
      onClickedDone;

  const DescriptionDialog({
    Key? key,
    this.description,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _DescriptionDialogState createState() => _DescriptionDialogState();
}

class _DescriptionDialogState extends State<DescriptionDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final directorController = TextEditingController();
  final imgController = TextEditingController();

  bool isDesc = true;

  @override
  void initState() {
    super.initState();

    if (widget.description != null) {
      final description = widget.description!;

      nameController.text = description.name;
      directorController.text = description.director;
      imgController.text = description.imgUrl;
      isDesc = description.isDesc;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    directorController.dispose();
    imgController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.description != null;
    final title = isEditing ? 'Edit Description' : 'Add Description';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildDirector(),
              SizedBox(height: 8),
              buildImage(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name of the Movie..',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildDirector() => TextFormField(
        controller: directorController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name of the Director',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildImage() => TextFormField(
        controller: imgController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter image url',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a url' : null,
      );

  //

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final director = directorController.text;
          final imgUrl = imgController.text;

          widget.onClickedDone(name, director, imgUrl, isDesc);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
