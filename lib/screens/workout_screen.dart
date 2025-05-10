import 'package:elevate_fit/Widgets/custom_app_bar.dart';
import 'package:elevate_fit/Widgets/custom_drawer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: WorkoutsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WorkoutsPage extends StatefulWidget {
  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  List<Workout> workouts = [];

  void _goToAddWorkoutPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddWorkoutPage()),
    );

    if (result != null && result is Workout) {
      setState(() {
        workouts.add(result);
      });
    }
  }

  void _deleteWorkout(int index) {
    setState(() {
      workouts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        flexibleSpace: CustomAppBar(),
        title: Center(
          child: Text(
            "Workouts",
            style: GoogleFonts.montserrat(fontSize: 30, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person, color: Colors.white, size: 35),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.grey, height: 1.0),
        ),
      ),
      drawer: Drawertap(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: workouts.isEmpty
            ? Center(
          child: Text(
            "No Workouts Yet",
            style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white),
          ),
        )
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          workout.title,
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteWorkout(index),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ...workout.exercises.map(
                        (e) => Text(
                      e,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${workout.date.toLocal().toString().split(' ')[0]}",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF14AE5C),
        onPressed: _goToAddWorkoutPage,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class AddWorkoutPage extends StatefulWidget {
  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  final _titleController = TextEditingController();
  final List<TextEditingController> _exerciseControllers = [TextEditingController()];
  final _formKey = GlobalKey<FormState>();

  void _addExerciseField() {
    setState(() {
      _exerciseControllers.add(TextEditingController());
    });
  }

  void _removeExerciseField(int index) {
    setState(() {
      if (_exerciseControllers.length > 1) {
        _exerciseControllers.removeAt(index);
      }
    });
  }

  void _saveWorkout() {
    if (_formKey.currentState!.validate()) {
      final exercises = _exerciseControllers.map((ctrl) => ctrl.text).toList();
      final workout = Workout(
        title: _titleController.text,
        exercises: exercises,
        date: DateTime.now(),
      );
      Navigator.pop(context, workout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(
          "Add Workout",
          style: GoogleFonts.fugazOne(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Workout Title",
                  labelStyle: GoogleFonts.montserrat(color: Colors.white, fontSize: 30),
                ),
                validator: (val) =>
                val == null || val.isEmpty ? "Enter workout title" : null,
              ),
              SizedBox(height: 24),
              Text("Exercises:", style: GoogleFonts.montserrat(color: Colors.white)),
              SizedBox(height: 8),
              ..._exerciseControllers.asMap().entries.map((entry) {
                int idx = entry.key;
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: entry.value,
                        decoration: InputDecoration(
                          labelText: "Exercise ${idx + 1}",
                          labelStyle: GoogleFonts.montserrat(color: Colors.white, fontSize: 30),
                        ),
                        validator: (val) =>
                        val == null || val.isEmpty ? "Required" : null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeExerciseField(idx),
                    )
                  ],
                );
              }),
              TextButton.icon(
                onPressed: _addExerciseField,
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("Add More Exercise", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20)),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveWorkout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE30B5C),
                ),
                child: Text(
                  "Save",
                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Workout {
  final String title;
  final List<String> exercises;
  final DateTime date;

  Workout({required this.title, required this.exercises, required this.date});
}
