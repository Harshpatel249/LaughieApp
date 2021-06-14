import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class SignUpPrescription extends StatefulWidget {
  @override
  _SignUpPrescriptionState createState() => _SignUpPrescriptionState();
}

class _SignUpPrescriptionState extends State<SignUpPrescription> {
  String prescribedValue;
  String sessionValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prescription',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Duration:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfffbb313), width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Select the starting date',
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  print(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xfffbb313), width: 2.0),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Select the last date',
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  print(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '''How many number of sessions per day?                                  ''',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<String>(
                  value: sessionValue,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 24,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black),
                  underline: SizedBox(),
                  hint: Text('Number of sessions per day'),
                  onChanged: (newValue) {
                    setState(() {
                      sessionValue = newValue;
                    });
                  },
                  items: <String>['1', '2', '3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '''Prescribed By?                                  ''',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<String>(
                  value: prescribedValue,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 24,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black),
                  underline: SizedBox(),
                  hint: Text('Prescribed by'),
                  onChanged: (newValue) {
                    setState(() {
                      prescribedValue = newValue;
                    });
                  },
                  items: <String>['Self', 'Doctor', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Finish',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xfffbb313),
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // <-- Radius
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
