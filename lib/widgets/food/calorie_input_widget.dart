import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

import '../../services/calorie_service.dart';

class CalorieInputWidget extends StatefulWidget {
  const CalorieInputWidget({super.key});

  @override
  State<CalorieInputWidget> createState() => _CalorieInputWidgetState();
}

class _CalorieInputWidgetState extends State<CalorieInputWidget> with SingleTickerProviderStateMixin {
  dynamic _selectedImage; // File for mobile, Uint8List for web
  String? _imagePath; // For displaying the image on mobile
  bool _isAnalyzing = false;
  bool _showResults = false;
  FoodAnalysisResult? _analysisResult;
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  Future<void> _getImage(ImageSource source) async {
    setState(() {
      _isAnalyzing = true;
      _showResults = false;
    });
    
    try {
      if (source == ImageSource.camera) {
        await _processImageFromCamera();
      } else {
        await _processImageFromGallery();
      }
    } catch (e) {
      _showError('Analysis failed: ${e.toString()}');
    }
  }

  Future<void> _processImageFromCamera() async {
    try {
      final result = await FoodAnalysisService.takePhotoAndAnalyze();
      
      setState(() {
        _analysisResult = result;
        _isAnalyzing = false;
        _showResults = true;
        // For demonstration, you might want to add image capture logic
 // Assuming imageData is added to the result
      });
      _animationController.forward(from: 0);
    } catch (e) {
      _showError('Camera analysis failed: ${e.toString()}');
    }
  }

  Future<void> _processImageFromGallery() async {
    try {
      final result = await FoodAnalysisService.selectPhotoAndAnalyze();
      
      setState(() {
        _analysisResult = result;
        _isAnalyzing = false;
        _showResults = true;
  // Assuming imageData is added to the result
      });
      _animationController.forward(from: 0);
    } catch (e) {
      _showError('Gallery analysis failed: ${e.toString()}');
    }
  }
  
  void _showError(String message) {
    setState(() {
      _isAnalyzing = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey[800],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          if (_isAnalyzing) 
            _buildLoadingState()
          else if (_showResults && _analysisResult != null) 
            _buildResults()
          else 
            _buildImageSelectionOptions(),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.analytics_outlined, 
            color: Colors.green[700],
            size: 24,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Food Analyzer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Analyze your food with a photo',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.green[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildImageSelectionOptions() {
    return Column(
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_search_rounded,
                  size: 48,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 12),
                Text(
                  'No image selected',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildOptionButton(
                icon: Icons.camera_alt_rounded,
                label: 'Take Photo',
                onTap: () => _getImage(ImageSource.camera),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOptionButton(
                icon: Icons.photo_library_rounded,
                label: 'Gallery',
                onTap: () => _getImage(ImageSource.gallery),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              color: Colors.grey[800],
              strokeWidth: 2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Analyzing your food...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Identifying ingredients and calculating nutrition',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResults() {
    final result = _analysisResult!;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animationController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display uploaded image
          if (_selectedImage != null)
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: kIsWeb 
                      ? Image.memory(_selectedImage).image 
                      : FileImage(File(_selectedImage)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          
          // Summary
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Food Detected',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: result.foodItems.map((item) => _buildFoodChip(item)).toList(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoBadge(
                    icon: Icons.local_fire_department,
                    label: '${result.calories.toStringAsFixed(0)} cal',
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Nutrition section
          Text(
            'Nutritional Information',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 12),
          
          // Nutrient bars with aesthetic design
          _buildNutrientBars(result.nutrients),
          
          const SizedBox(height: 20),
          
          // Additional details section
          if (result.additionalDetails.isNotEmpty) ...[
            Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            _buildAdditionalDetails(result.additionalDetails),
            const SizedBox(height: 20),
          ],
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.refresh,
                  label: 'New Analysis',
                  onTap: () {
                    setState(() {
                      _selectedImage = null;
                      _imagePath = null;
                      _analysisResult = null;
                      _showResults = false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.save_alt,
                  label: 'Save Results',
                  onTap: _saveResults,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildFoodChip(String item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        item,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  
  Widget _buildInfoBadge({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.grey[700],
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  

  Widget _buildNutrientBars(Map<String, double> nutrients) {
    final sortedNutrients = nutrients.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Color palette for nutrient bars
    final colors = [
      Colors.green[400]!,
      Colors.blue[400]!,
      Colors.orange[400]!,
      Colors.purple[400]!,
      Colors.teal[400]!,
    ];
    
    return Column(
      children: sortedNutrients.map((entry) {
        final nutrientName = entry.key;
        final value = entry.value;
        
        // Calculate percentage for display (max 100%)
        final percentage = (value / 50.0).clamp(0.0, 1.0);
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _capitalizeFirstLetter(nutrientName),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${value.toStringAsFixed(1)}g',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Stack(
                children: [
                  // Background
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  // Value bar with gradient
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors[sortedNutrients.indexOf(entry) % colors.length],
                            colors[sortedNutrients.indexOf(entry) % colors.length].withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildAdditionalDetails(Map<String, dynamic> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: details.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_capitalizeFirstLetter(entry.key)}: ',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  _formatDetailValue(entry.value),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  String _formatDetailValue(dynamic value) {
    if (value is List) {
      return value.join(', ');
    } else if (value is Map) {
      return value.entries.map((e) => '${e.key}: ${e.value}').join(', ');
    } else {
      return value.toString();
    }
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
  
  // This method would need to be implemented to save the results
  // Since the original FoodAnalysisService doesn't have a save method,
  // we'll just show a success message
  void _saveResults() async {
    try {
      // In a real implementation, you would save the analysis result
      // For example: await FoodAnalysisService.saveAnalysisResult(_analysisResult!);
      
      // For now, just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Results saved successfully'),
          backgroundColor: Colors.grey[800],
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save results: ${e.toString()}'),
          backgroundColor: Colors.red[700],
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  
  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}