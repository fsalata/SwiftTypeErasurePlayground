import UIKit

protocol ConversationProtocol {
    var threadId: String { get }
    var message: String { get }
    var isUnread: Bool { get }
}

extension ConversationProtocol where Self: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(threadId)
    }
    
    func isEqualTo(_ other: ConversationProtocol) -> Bool {
        guard let otherConversation = other as? Self else {
            return false
        }
        
        return threadId == otherConversation.threadId
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqualTo(rhs)
    }
}

struct Conversation: ConversationProtocol {
    var threadId: String
    var message: String
    var isUnread: Bool
}

extension Conversation: Hashable {}

struct AnyHashableConversation: ConversationProtocol, Hashable {

    private let conversation: ConversationProtocol
    
    var threadId: String {
        return conversation.threadId
    }
    
    var message: String {
        return conversation.message
    }
    
    var isUnread: Bool {
        conversation.isUnread
    }
    
    init(conversation: ConversationProtocol) {
        self.conversation = conversation
    }
}

let conversation1 = Conversation(threadId: "1", message: "Conversation 1", isUnread: false)
let conversation2 = Conversation(threadId: "2", message: "Conversation 2", isUnread: false)

print(conversation1 == conversation2)

var conversations = Set<AnyHashableConversation>()

conversations.insert(AnyHashableConversation(conversation: conversation1))

print(conversations.first?.message)

