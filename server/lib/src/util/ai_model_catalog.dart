class AiModelInfo {
  final String id;
  final String displayName;
  final String provider;     // 'openrouter' or 'gemini'
  final bool supportsVision;
  final bool isFree;
  final double inputPricePerM;
  final double outputPricePerM;
  const AiModelInfo({required this.id, required this.displayName, required this.provider, required this.supportsVision, required this.isFree, required this.inputPricePerM, required this.outputPricePerM});
}

abstract final class AiModelCatalog {
  static const List<AiModelInfo> models = [
    // FREE — text only
    AiModelInfo(id: 'google/gemma-2-9b-it:free',             displayName: 'Gemma 2 9B (free)',            provider: 'openrouter', supportsVision: false, isFree: true,  inputPricePerM: 0,    outputPricePerM: 0),
    AiModelInfo(id: 'meta-llama/llama-3.2-3b-instruct:free', displayName: 'Llama 3.2 3B (free)',          provider: 'openrouter', supportsVision: false, isFree: true,  inputPricePerM: 0,    outputPricePerM: 0),
    AiModelInfo(id: 'mistralai/mistral-7b-instruct:free',    displayName: 'Mistral 7B (free)',            provider: 'openrouter', supportsVision: false, isFree: true,  inputPricePerM: 0,    outputPricePerM: 0),
    AiModelInfo(id: 'gemini-2.0-flash-lite',                 displayName: 'Gemini 2.0 Flash Lite (free)', provider: 'gemini',     supportsVision: false, isFree: true,  inputPricePerM: 0,    outputPricePerM: 0),
    // FREE — text + image
    AiModelInfo(id: 'google/gemini-2.0-flash-exp:free',      displayName: 'Gemini 2.0 Flash Exp (free)',  provider: 'openrouter', supportsVision: true,  isFree: true,  inputPricePerM: 0,    outputPricePerM: 0),
    AiModelInfo(id: 'gemini-2.0-flash',                      displayName: 'Gemini 2.0 Flash (free tier)', provider: 'gemini',     supportsVision: true,  isFree: true,  inputPricePerM: 0,    outputPricePerM: 0),
    AiModelInfo(id: 'gemini-1.5-flash',                      displayName: 'Gemini 1.5 Flash (free tier)', provider: 'gemini',     supportsVision: true,  isFree: true,  inputPricePerM: 0.075,outputPricePerM: 0.30),
    // PAID — text only
    AiModelInfo(id: 'google/gemini-flash-1.5',               displayName: 'Gemini 1.5 Flash',             provider: 'openrouter', supportsVision: false, isFree: false, inputPricePerM: 0.075,outputPricePerM: 0.30),
    AiModelInfo(id: 'openai/gpt-4o-mini',                    displayName: 'GPT-4o Mini',                  provider: 'openrouter', supportsVision: false, isFree: false, inputPricePerM: 0.15, outputPricePerM: 0.60),
    AiModelInfo(id: 'anthropic/claude-haiku-3-5',            displayName: 'Claude 3.5 Haiku',             provider: 'openrouter', supportsVision: false, isFree: false, inputPricePerM: 0.80, outputPricePerM: 4.00),
    AiModelInfo(id: 'gemini-1.5-pro',                        displayName: 'Gemini 1.5 Pro',               provider: 'gemini',     supportsVision: false, isFree: false, inputPricePerM: 1.25, outputPricePerM: 5.00),
    // PAID — text + image
    AiModelInfo(id: 'openai/gpt-4o',                         displayName: 'GPT-4o',                       provider: 'openrouter', supportsVision: true,  isFree: false, inputPricePerM: 2.50, outputPricePerM: 10.00),
    AiModelInfo(id: 'anthropic/claude-sonnet-4',             displayName: 'Claude Sonnet 4',              provider: 'openrouter', supportsVision: true,  isFree: false, inputPricePerM: 3.00, outputPricePerM: 15.00),
    AiModelInfo(id: 'google/gemini-pro-1.5',                 displayName: 'Gemini Pro 1.5',               provider: 'openrouter', supportsVision: true,  isFree: false, inputPricePerM: 1.25, outputPricePerM: 5.00),
  ];
  static AiModelInfo? findById(String id) => models.where((m) => m.id == id).firstOrNull;
}
