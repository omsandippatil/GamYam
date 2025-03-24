import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'package:openai_dart/openai_dart.dart';

// Model class for food analysis results
class FoodAnalysisResult {
  final List<String> foodItems;
  final Map<String, double> nutrients;
  final double calories;
  final Map<String, dynamic> additionalDetails;

  FoodAnalysisResult({
    required this.foodItems,
    required this.nutrients,
    required this.calories,
    required this.additionalDetails,
  });

  factory FoodAnalysisResult.fromJson(Map<String, dynamic> json) {
    return FoodAnalysisResult(
      foodItems: List<String>.from(json['foodItems'] ?? []),
      nutrients: Map<String, double>.from(json['nutrients'] ?? {}),
      calories: json['calories']?.toDouble() ?? 0.0,
      additionalDetails: json['additionalDetails'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodItems': foodItems,
      'nutrients': nutrients,
      'calories': calories,
      'additionalDetails': additionalDetails,
    };
  }
}

// Service class for food analysis
class FoodAnalysisService {
  // API key for Groq - replace with your own key from https://console.groq.com/
  static const String _groqApiKey = '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';

  // Groq API endpoint (OpenAI-compatible)
  static const String _groqApiBaseUrl = 'https://api.groq.com/openai/v1';

  // Helper to convert image data to base64
  static String _imageDataToBase64(Uint8List imageData) {
    return base64Encode(imageData);
  }

  // Analyze food details using Groq's LLaVA v1.5 7B model
  static Future<FoodAnalysisResult> _analyzeFoodWithGroq(String base64Image) async {
    try {
      // Initialize Groq client using openai_dart
      final client = OpenAIClient(
        apiKey: _groqApiKey,
        baseUrl: _groqApiBaseUrl,
      );

      // Prompt for Groq to analyze the image
      final promptText = '''
      Analyze the food in this image and provide:
      1. List of all food items visible
      2. Estimated total calories
      3. Nutritional breakdown (protein, carbs, fat, fiber, sugar) in grams
      4. Additional details (e.g., preparation, ingredients)
      
      Return the response in JSON format:
      {
        "foodItems": ["item1", "item2", ...],
        "calories": number,
        "nutrients": {
          "protein": number,
          "carbs": number,
          "fat": number,
          "fiber": number,
          "sugar": number
        },
        "additionalDetails": {}
      }
      ''';

      // For direct API access instead of using the high-level client
      final url = Uri.parse('$_groqApiBaseUrl/chat/completions');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_groqApiKey',
      };
      
      final body = jsonEncode({
        'model': 'llava-v1.5-7b-4096',
        'messages': [
          {
            'role': 'user',
            'content': [
              {
                'type': 'text',
                'text': promptText,
              },
              {
                'type': 'image_url',
                'image_url': {
                  'url': 'data:image/jpeg;base64,$base64Image',
                },
              },
            ],
          },
        ],
        'max_tokens': 500,
      });

      final response = await http.post(url, headers: headers, body: body);
      
      if (response.statusCode != 200) {
        throw Exception('API request failed with status: ${response.statusCode}, body: ${response.body}');
      }
      
      final responseJson = jsonDecode(response.body);
      final responseText = responseJson['choices'][0]['message']['content'];

      if (responseText == null || responseText.isEmpty) {
        throw Exception('Empty response from Groq');
      }

      // Extract JSON from the response
      final jsonMatch = RegExp(r'{[\s\S]*}').firstMatch(responseText);
      if (jsonMatch == null) {
        debugPrint('Failed to parse JSON from Groq response: $responseText');
        throw Exception('Invalid JSON in Groq response');
      }

      final jsonString = jsonMatch.group(0)!;
      final Map<String, dynamic> resultJson = jsonDecode(jsonString);

      return FoodAnalysisResult.fromJson(resultJson);
    } catch (e) {
      debugPrint('Groq analysis error: $e');
      return FoodAnalysisResult(
        foodItems: [],
        calories: 0.0,
        nutrients: {
          'protein': 0.0,
          'carbs': 0.0,
          'fat': 0.0,
          'fiber': 0.0,
          'sugar': 0.0,
        },
        additionalDetails: {'error': 'Groq analysis failed: $e'},
      );
    }
  }

  // [Rest of the code remains the same]
  static Future<FoodAnalysisResult> analyzeFoodImage(dynamic imageSource) async {
    try {
      String base64Image;

      if (kIsWeb) {
        if (imageSource is! Uint8List) {
          throw Exception('Invalid image source for web: expected Uint8List');
        }
        base64Image = _imageDataToBase64(imageSource);
      } else {
        if (imageSource is File) {
          final bytes = await imageSource.readAsBytes();
          base64Image = _imageDataToBase64(bytes);
        } else if (imageSource is Uint8List) {
          base64Image = _imageDataToBase64(imageSource);
        } else {
          throw Exception('Invalid image source: expected File or Uint8List');
        }
      }

      return await _analyzeFoodWithGroq(base64Image);
    } catch (e) {
      debugPrint('Food analysis failed: $e');
      return FoodAnalysisResult(
        foodItems: [],
        calories: 0.0,
        nutrients: {},
        additionalDetails: {'error': 'Food analysis failed: $e'},
      );
    }
  }

  // Take a photo and analyze it
  static Future<FoodAnalysisResult> takePhotoAndAnalyze() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedImage == null) {
        throw Exception('No image captured');
      }

      if (kIsWeb) {
        final bytes = await pickedImage.readAsBytes();
        return await analyzeFoodImage(bytes);
      } else {
        return await analyzeFoodImage(File(pickedImage.path));
      }
    } catch (e) {
      debugPrint('Photo capture failed: $e');
      return FoodAnalysisResult(
        foodItems: [],
        calories: 0.0,
        nutrients: {},
        additionalDetails: {'error': 'Photo capture failed: $e'},
      );
    }
  }

  // Select a photo from gallery and analyze it
  static Future<FoodAnalysisResult> selectPhotoAndAnalyze() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedImage == null) {
        throw Exception('No image selected');
      }

      if (kIsWeb) {
        final bytes = await pickedImage.readAsBytes();
        return await analyzeFoodImage(bytes);
      } else {
        return await analyzeFoodImage(File(pickedImage.path));
      }
    } catch (e) {
      debugPrint('Photo selection failed: $e');
      return FoodAnalysisResult(
        foodItems: [],
        calories: 0.0,
        nutrients: {},
        additionalDetails: {'error': 'Photo selection failed: $e'},
      );
    }
  }

  // Analyze web-uploaded image
  static Future<FoodAnalysisResult> analyzeWebUploadedImage(Uint8List imageBytes) async {
    try {
      if (!kIsWeb) {
        throw Exception('This method is only for web platforms');
      }
      return await analyzeFoodImage(imageBytes);
    } catch (e) {
      debugPrint('Web upload analysis failed: $e');
      return FoodAnalysisResult(
        foodItems: [],
        calories: 0.0,
        nutrients: {},
        additionalDetails: {'error': 'Web upload analysis failed: $e'},
      );
    }
  }

  // Analyze image from URL
  static Future<FoodAnalysisResult> analyzeImageFromUrl(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download image: ${response.statusCode}');
      }
      final imageBytes = response.bodyBytes;
      return await analyzeFoodImage(imageBytes);
    } catch (e) {
      debugPrint('URL image analysis failed: $e');
      return FoodAnalysisResult(
        foodItems: [],
        calories: 0.0,
        nutrients: {},
        additionalDetails: {'error': 'URL image analysis failed: $e'},
      );
    }
  }
}