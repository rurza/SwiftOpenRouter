import Foundation

public struct OpenRouterModel: Decodable, Sendable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case created
        case description
        case contextLength = "context_length"
        case architecture
        case topProvider = "top_provider"
        case pricing
        case perRequestLimits = "per_request_limits"
        case supportedParameters = "supported_parameters"
    }
    
    public let id: String
    public let name: String
    public let created: Date
    public let description: String
    public let contextLength: Int
    public let architecture: Architecture
    public let topProvider: TopProvider
    public let pricing: Pricing
    public let perRequestLimits: [String: String]?
    public let supportedParameters: Set<Parameter>
    
    public struct Architecture: Decodable, Sendable {
        public let modality: String
        public let tokenizer: String
    }
    
    public struct TopProvider: Decodable, Sendable {
        enum CodingKeys: String, CodingKey {
            case contextLength = "context_length"
            case maxCompletionTokens = "max_completion_tokens"
            case isModerated = "is_moderated"
        }
        
        public let contextLength: Int?
        public let maxCompletionTokens: Int?
        public let isModerated: Bool
    }
    
    public enum Parameter: Hashable, Decodable, Sendable {
        case known(Key)
        case unknown(String)
        
        public enum Key: String, Codable, Sendable {
            case logprobs
            case maxTokens = "max_tokens"
            case reasoning
            case responseFormat = "supported_parameters"
            case seed
            case stop
            case structuredOutputs = "structured_outputs"
            case temperature
            case toolChoice = "tool_choice"
            case tools
            case webSearchOptions = "web_search_options"
        }
        
        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value: Key? = try? container.decode(Key.self)
            switch value {
            case let .some(key):
                self = .known(key)
            case .none:
                let unknownValue = try container.decode(String.self)
                self = .unknown(unknownValue)
            }
        }
    }
    
    public struct Pricing: Decodable, Sendable {
        enum CodingKeys: String, CodingKey {
            case prompt
            case completion
            case image
            case request
            case inputCacheRead = "input_cache_read"
            case inputCacheWrite = "input_cache_write"
            case webSearch = "web_search"
            case internalReasoning = "internal_reasoning"
        }
        
        public let prompt: Decimal
        public let completion: Decimal
        public let image: Decimal?
        public let request: Decimal?
        public let inputCacheRead: Decimal?
        public let inputCacheWrite: Decimal?
        public let webSearch: Decimal?
        public let internalReasoning: Decimal?
    }
}

public struct ListAvailableModelsResponse: Decodable, Sendable {
    public let data: [OpenRouterModel]
}
