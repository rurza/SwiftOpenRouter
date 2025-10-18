import Foundation

public enum OpenRouterEndpoint {
    case chatCompletions
    case models
    case credits
    case userModels

    var path: String {
        switch self {
        case .chatCompletions:
            return "/chat/completions"
        case .models:
            return "/models"
        case .credits:
            return "/credits"
        case .userModels:
            return "/models/user"
        }
    }

    func url(baseURL: URL) -> URL {
        baseURL.appendingPathComponent(path)
    }
}
