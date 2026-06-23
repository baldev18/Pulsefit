import 'package:flutter/material.dart';

import 'activity.dart';

class HealthCategory {
  const HealthCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.goal,
    required this.description,
    required this.activities,
  });

  final String title;
  final IconData icon;
  final Color color;
  final String goal;
  final String description;
  final List<Activity> activities;

  static const List<HealthCategory> samples = [
    HealthCategory(
      title: 'Cardio',
      icon: Icons.directions_run_rounded,
      color: Color(0xFFE74C3C),
      goal: '30 min daily',
      description: 'Improve stamina, heart health, and daily calorie burn.',
      activities: [
        Activity(
          title: 'Morning Run',
          time: 'Today • 06:45 AM',
          metric: '3.2 km • 24 min',
          note: 'Average pace 7:30/km',
        ),
        Activity(
          title: 'Cycling',
          time: 'Yesterday • 07:10 PM',
          metric: '8.4 km • 38 min',
          note: 'Great endurance session',
        ),
        Activity(
          title: 'Treadmill Walk',
          time: 'Mon • 08:20 AM',
          metric: '2.1 km • 20 min',
          note: 'Low intensity recovery',
        ),
      ],
    ),
    HealthCategory(
      title: 'Strength',
      icon: Icons.fitness_center_rounded,
      color: Color(0xFF8E44AD),
      goal: '4 workouts/week',
      description: 'Build muscle strength with controlled resistance training.',
      activities: [
        Activity(
          title: 'Upper Body',
          time: 'Today • 08:00 AM',
          metric: '6 exercises • 42 min',
          note: 'Chest, shoulder, and triceps',
        ),
        Activity(
          title: 'Core Training',
          time: 'Yesterday • 06:30 PM',
          metric: '4 sets • 18 min',
          note: 'Plank improved by 20 seconds',
        ),
        Activity(
          title: 'Leg Day',
          time: 'Sun • 07:45 AM',
          metric: '5 exercises • 45 min',
          note: 'Squats and lunges focused',
        ),
      ],
    ),
    HealthCategory(
      title: 'Flexibility',
      icon: Icons.self_improvement_rounded,
      color: Color(0xFF3498DB),
      goal: '15 min daily',
      description: 'Increase mobility, reduce stiffness, and recover faster.',
      activities: [
        Activity(
          title: 'Yoga Flow',
          time: 'Today • 07:20 AM',
          metric: '18 min • 120 kcal',
          note: 'Back and hip mobility',
        ),
        Activity(
          title: 'Stretch Routine',
          time: 'Yesterday • 09:15 PM',
          metric: '12 min • Recovery',
          note: 'Post-workout relaxation',
        ),
        Activity(
          title: 'Breathing Practice',
          time: 'Sat • 06:50 AM',
          metric: '8 min • Calm',
          note: 'Improved focus and posture',
        ),
      ],
    ),
    HealthCategory(
      title: 'Diet',
      icon: Icons.restaurant_menu_rounded,
      color: Color(0xFF27AE60),
      goal: '2200 kcal target',
      description: 'Track nutrition, hydration, and healthy meal habits.',
      activities: [
        Activity(
          title: 'Protein Breakfast',
          time: 'Today • 09:00 AM',
          metric: '420 kcal • 28g protein',
          note: 'Oats, banana, and milk',
        ),
        Activity(
          title: 'Hydration Check',
          time: 'Today • 12:30 PM',
          metric: '1.8 L / 3 L',
          note: 'Keep water intake steady',
        ),
        Activity(
          title: 'Balanced Lunch',
          time: 'Yesterday • 01:45 PM',
          metric: '680 kcal • Veg meal',
          note: 'Dal, rice, salad, and curd',
        ),
      ],
    ),
  ];
}
