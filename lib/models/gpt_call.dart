class GPTCall {
  final int letterChunkId;
  final int promptTypeId;
  final int inputTokens;
  final int outputTokens;
  final String userInput;
  final String gptRawResponse;
  final String model;
  final DateTime createdAt;

  GPTCall({
    required this.letterChunkId,
    required this.promptTypeId,
    required this.inputTokens,
    required this.outputTokens,
    required this.userInput,
    required this.gptRawResponse,
    required this.model,
    required this.createdAt,
  });

  factory GPTCall.fromMap(Map<String, dynamic> map) {
    return GPTCall(
      letterChunkId: map['letter_chunk_id'] ?? 0,
      promptTypeId: map['prompt_type_id'] ?? 0,
      inputTokens: map['input_tokens'] ?? 0,
      outputTokens: map['output_tokens'] ?? 0,
      userInput: map['user_input'] ?? '',
      gptRawResponse: map['gpt_raw_response'] ?? '',
      model: map['model'] ?? '',
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'letter_chunk_id': letterChunkId,
      'prompt_type_id': promptTypeId,
      'input_tokens': inputTokens,
      'output_tokens': outputTokens,
      'user_input': userInput,
      'gpt_raw_response': gptRawResponse,
      'model': model,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
