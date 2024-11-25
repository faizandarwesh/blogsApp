import 'package:blogs_app/blogs/controller/blog_controller.dart';
import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockHelperFunctions extends Mock implements HelperFunctions {}

class MockPostgrestTransformBuilder extends Mock
    implements PostgrestTransformBuilder {}

main() {
  late BlogController blogController;
  late MockSupabaseClient mockSupabaseClient;
  late MockPostgrestTransformBuilder mockPostgrestTransformBuilder;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockPostgrestTransformBuilder = MockPostgrestTransformBuilder();
    blogController = BlogController(
        supabase: mockSupabaseClient, helperFunctions: MockHelperFunctions());

  });

  tearDown(() {});

  group('It contains all the test cases related to create blog controller', () {
    test('This is the test case for checking success flow', () async {
      //Arrange
/*
      when(() => mockSupabaseClient.from('blogs').insert(any()).select())
          .thenAnswer((_) async => [
                {'id': 1, 'title': 'Test Blog', ""}
              ]);
*/

      //Act
      final result = BlogController(
              supabase: Supabase.instance.client,
              helperFunctions: HelperFunctions())
          .createBlog(
              24,
              "Learning GPT-4 o-mini models",
              """We're releasing OpenAI o1-mini, a cost-efficient reasoning model. o1-mini excels at STEM, especially math and coding—nearly matching the performance of OpenAI o1 on evaluation benchmarks such as AIME and Codeforces. We expect o1-mini will be a faster, cost-effective model for applications that require reasoning without broad world knowledge.Today, we are launching o1-mini to tier 5 API users⁠(opens in a new window) at a cost that is 80% cheaper than OpenAI o1-preview. ChatGPT Plus, Team, Enterprise, and Edu users can use o1-mini as an alternative to o1-preview, with higher rate limits and lower latency (see Model Speed⁠).
Optimized for STEM Reasoning Large language models such as o1 are pre-trained on vast text datasets. While these high-capacity models have broad world knowledge, they can be expensive and slow for real-world applications. In contrast, o1-mini is a smaller model optimized for STEM reasoning during pretraining. After training with the same high-compute reinforcement learning (RL) pipeline as o1, o1-mini achieves comparable performance on many useful reasoning tasks, while being significantly more cost efficient.
When evaluated on benchmarks requiring intelligence and reasoning, o1-mini performs well compared to o1-preview and o1. However, o1-mini performs worse on tasks requiring non-STEM factual knowledge (see Limitations⁠). 
""",
              "https://images.unsplash.com/photo-1678483789105-2720201bee03?q=80&w=2128&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");

      //Assert
      expect(result, 'success');
    });

    test('This is the test case for checking error flow', () async {
      //Arrange

      /*  when(() => mockSupabaseClient.from('blogs'))
          .thenReturn(mockPostgrestTransformBuilder);

      when(() => mockPostgrestTransformBuilder.insert(any()))
          .thenReturn(mockPostgrestTransformBuilder);

      when(() => mockPostgrestTransformBuilder.select())
          .thenAnswer((_) async => [{'id': 1, 'title': 'Test Blog'}]);


      when(() => mockSupabaseClient.from('blogs').insert(any()).select())
          .thenAnswer((_) async => []);
*/

      //Act
      final result = BlogController(
              supabase: Supabase.instance.client,
              helperFunctions: HelperFunctions())
          .createBlog(
              24,
              "Learning GPT-4 o-mini models",
              """We're releasing OpenAI o1-mini, a cost-efficient reasoning model. o1-mini excels at STEM, especially math and coding—nearly matching the performance of OpenAI o1 on evaluation benchmarks such as AIME and Codeforces. We expect o1-mini will be a faster, cost-effective model for applications that require reasoning without broad world knowledge.Today, we are launching o1-mini to tier 5 API users⁠(opens in a new window) at a cost that is 80% cheaper than OpenAI o1-preview. ChatGPT Plus, Team, Enterprise, and Edu users can use o1-mini as an alternative to o1-preview, with higher rate limits and lower latency (see Model Speed⁠).
Optimized for STEM Reasoning Large language models such as o1 are pre-trained on vast text datasets. While these high-capacity models have broad world knowledge, they can be expensive and slow for real-world applications. In contrast, o1-mini is a smaller model optimized for STEM reasoning during pretraining. After training with the same high-compute reinforcement learning (RL) pipeline as o1, o1-mini achieves comparable performance on many useful reasoning tasks, while being significantly more cost efficient.
When evaluated on benchmarks requiring intelligence and reasoning, o1-mini performs well compared to o1-preview and o1. However, o1-mini performs worse on tasks requiring non-STEM factual knowledge (see Limitations⁠). 
""",
              "https://images.unsplash.com/photo-1678483789105-2720201bee03?q=80&w=2128&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");

      //Assert
      expect(result, 'error');
    });

    test('This is the test case for checking exception case flow', () async {
      // Arrange
      when(() => mockSupabaseClient.from('blogs').insert(any()).select())
          .thenThrow(Exception('Supabase Error'));

      // Act
      final result = await blogController.createBlog(
        1,
        'Test Blog',
        'This is content',
        'image_url',
      );

      // Assert
      expect(result, 'exception');
    });
  });
}
