import 'package:blogs_app/profile/controller/user_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  UserProfileController userProfileController = UserProfileController();
  final _formKey = GlobalKey<FormState>();
  late String _userName;
  late String _phoneNumber;
  late String _description;
  late String _email;

  File? _avatarImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProfileController.getUserProfile().then((value){
        print("initState : $value");

        _userName = "John Doe";
        _phoneNumber = "123-456-7890";
        _description = "Hey, I'm good";
        _email = "john.doe@example.com";
      });
    });
    super.initState();

  }

  // Function to pick an image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _avatarImage = File(image.path);
      });
    }
  }

  // Function to show Cupertino-style bottom sheet
  void _showImageSourceSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select Image Source'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text('Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text('Gallery'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void _updateProfile() {
    userProfileController.getUserProfile();
   /* if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Circular Avatar with option to change it
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _avatarImage != null
                        ? FileImage(_avatarImage!)
                        : const NetworkImage(
                        "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D") as ImageProvider,
                    backgroundColor: Colors.grey[200],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _showImageSourceSheet(context),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF6750A4),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Form to edit username, email, and phone number
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username field
                  TextFormField(
                    initialValue: _userName,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      _userName = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email field (read-only with caution)
                  TextFormField(
                    initialValue: _email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      enabled: false,
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Email cannot be updated",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  const SizedBox(height: 16),

                  // Phone number field
                  TextFormField(
                    initialValue: _phoneNumber,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      _phoneNumber = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 16),
                  // Description field
                  TextFormField(
                    initialValue: _description,
                    maxLines: 5,
                    minLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      _description = value ?? '';
                    },
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter description';
                      // }
                      // return null;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 32),

                  // Update button
                  ElevatedButton(
                    onPressed: _updateProfile,
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Rounded corners
                      ),
                      backgroundColor: Colors.black, // Button background color
                    ),
                    child: const Text('Update Profile'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
