//
//  OpenRouterChatMessage.swift
//  SwiftOpenRouter
//
//  Created by Piotr Gorzelany on 20/03/2025.
//

import Foundation

public struct OpenRouterRequestChatMessage: Codable, Sendable {
    public enum Content: Codable, Sendable {
        case text(String)
        case base64Image(Base64Image)
        
        private enum CodingKeys: String, CodingKey {
            case text
            case base64Image = "image_url"
        }
    }
    
    public struct Base64Image: Codable, Sendable {
        public let image: String
        
        public init(data: Data, mediaType: String = "image/jpeg") {
            let base64String = "data:\(mediaType);base64,\(data.base64EncodedString())"
            self.image = base64String
        }
        
        private enum CodingKeys: String, CodingKey {
            case image = "url"
        }
    }

    public let role: OpenRouterChatMessage.Role
    public let content: [Content]

    public init(role: OpenRouterChatMessage.Role, content: [Content]) {
        self.role = role
        self.content = content
    }
}

public struct OpenRouterChatMessage: Codable, Sendable {
    public enum Role: String, Codable, Sendable {
        case user
        case assistant
        case system
        case tool
    }

    public let role: Role
    public let content: String

    public init(role: Role, content: String) {
        self.role = role
        self.content = content
    }
}
