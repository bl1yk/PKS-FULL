import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;

  SupabaseService._internal();

  Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://xijqnaivowednometnrb.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhpanFuYWl2b3dlZG5vbWV0bnJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ3OTMzMTksImV4cCI6MjA1MDM2OTMxOX0.2MFFDffcyaQwwdbW97O3So-HLTn2IWONoGOObcb6LV8',
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}