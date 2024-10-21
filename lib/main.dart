// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Main Function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queue Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthScreen(),
    );
  }
}

// Authentication Screen (Login/Register)
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isRegistering = false;
  bool isCustomer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isRegistering ? 'Register' : 'Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Are you a business owner?'),
              value: !isCustomer,
              onChanged: (value) {
                setState(() {
                  isCustomer = !value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isRegistering) {
                  if (isCustomer) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CustomerProfileScreen()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BusinessOwnerProfileScreen()));
                  }
                } else {
                  // Login logic goes here
                  if (isCustomer) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerSearchScreen()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BusinessOwnerProfileScreen()));
                  }
                }
              },
              child: Text(isRegistering ? 'Register' : 'Login'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isRegistering = !isRegistering;
                });
              },
              child: Text(isRegistering
                  ? 'Already Registered? Login'
                  : 'New here? Register'),
            ),
          ],
        ),
      ),
    );
  }
}

// Customer Profile Screen
class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Save customer profile logic here
              },
              child: const Text('Update Info'),
            ),
          ],
        ),
      ),
    );
  }
}

// Customer Search Screen
class CustomerSearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  CustomerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Business')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Business',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Search business logic here
                    String businessName = _searchController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AppointmentSlotSelector(businessName: businessName),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Appointment Slot Selector (Customer Side)
class AppointmentSlotSelector extends StatelessWidget {
  final String businessName;
  final Map<String, List<String>> availableSlots = {
    'Monday': ['9:00 AM', '10:00 AM', '11:00 AM'], // Example slots
    'Tuesday': ['12:00 PM', '1:00 PM'],
  };

  AppointmentSlotSelector({super.key, required this.businessName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Slot for $businessName')),
      body: Column(
        children: [
          Text('Select a time slot for an appointment with $businessName'),
          Expanded(
            child: ListView.builder(
              itemCount:
                  availableSlots['Monday']?.length ?? 0, // Example for Monday
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(availableSlots['Monday']![index]),
                  onTap: () {
                    // Save appointment and sync with the business owner logic here
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Feedback logic
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FeedbackScreen(businessName: businessName),
                ),
              );
            },
            child: Text('Give feedback to $businessName'),
          ),
        ],
      ),
    );
  }
}

// Feedback Screen
class FeedbackScreen extends StatelessWidget {
  final String businessName;

  const FeedbackScreen({super.key, required this.businessName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback for $businessName')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Your feedback'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Submit feedback logic
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

// Business Owner Profile Screen
class BusinessOwnerProfileScreen extends StatelessWidget {
  const BusinessOwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Owner Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Business Name'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Save business owner profile logic
              },
              child: const Text('Update Info'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SetTimeSlotsScreen()),
                );
              },
              child: const Text('Set Time Slots'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingManagementScreen()),
                );
              },
              child: const Text('Manage Bookings'),
            ),
          ],
        ),
      ),
    );
  }
}

// Set Appointment Slots (Business Owner)
class SetTimeSlotsScreen extends StatefulWidget {
  const SetTimeSlotsScreen({super.key});

  @override
  _SetTimeSlotsScreenState createState() => _SetTimeSlotsScreenState();
}

class _SetTimeSlotsScreenState extends State<SetTimeSlotsScreen> {
  Map<String, List<String>> timeSlots = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
    'Sunday': [],
  };

  final TextEditingController _slotDurationController = TextEditingController();
  final TextEditingController _timeSlotController = TextEditingController();

  void _addTimeSlot(String day) {
    setState(() {
      timeSlots[day]!.add(_timeSlotController.text);
    });
  }

  void _removeTimeSlot(String day, int index) {
    setState(() {
      timeSlots[day]!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Appointment Slots')),
      body: ListView(
        children: timeSlots.keys.map((day) {
          return ExpansionTile(
            title: Text(day),
            children: [
              Column(
                children: timeSlots[day]!.map((slot) {
                  int index = timeSlots[day]!.indexOf(slot);
                  return ListTile(
                    title: Text(slot),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeTimeSlot(day, index),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _timeSlotController,
                        decoration: const InputDecoration(
                            hintText: 'Add time slot (e.g., 9:00 AM)'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _addTimeSlot(day),
                      child: const Text('Add Slot'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _slotDurationController,
                        decoration: const InputDecoration(
                            hintText:
                                'Slot duration (e.g., 1 hour, 30 minutes)'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle setting slot duration
                        // ignore: unused_local_variable
                        final duration = _slotDurationController.text;
                        // Logic to handle the duration and apply it to the time slots
                      },
                      child: const Text('Set Duration'),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// Booking Management Screen (Business Owner Side)
class BookingManagementScreen extends StatelessWidget {
  final Map<String, List<String>> bookings = {
    'Monday': ['9:00 AM', '10:00 AM'], // Example data
    'Tuesday': ['1:00 PM'],
  };

  BookingManagementScreen({super.key});

  void _cancelBooking(String day, int index) {
    // Normally, this would also involve backend logic
    bookings[day]!.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Bookings')),
      body: ListView(
        children: bookings.keys.map((day) {
          return ExpansionTile(
            title: Text('$day Bookings'),
            children: bookings[day]!.map((slot) {
              int index = bookings[day]!.indexOf(slot);
              return ListTile(
                title: Text(slot),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => _cancelBooking(day, index),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
