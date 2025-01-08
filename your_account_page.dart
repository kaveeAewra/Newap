import 'package:flutter/material.dart';

class YourAccountPage extends StatelessWidget {
  const YourAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = {};

    final nameController = TextEditingController(text: userData['Name']);
    final emailController = TextEditingController(text: userData['Email']);
    final universityController =
        TextEditingController(text: userData['University']);
    final countryController = TextEditingController(text: userData['Country']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: universityController,
                decoration: InputDecoration(
                  labelText: 'University',
                ),
              ),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(
                  labelText: 'Country',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final updatedUserData = {
                    'Name': nameController.text,
                    'Email': emailController.text,
                    'University': universityController.text,
                    'Country': countryController.text,
                  };
                  print('Updated user data: $updatedUserData');
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
