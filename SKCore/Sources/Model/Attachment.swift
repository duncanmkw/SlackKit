//
// Attachment.swift
//
// Copyright © 2017 Peter Zignego. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

public struct Attachment {
    public let fallback: String?
    public let callbackID: String?
    public let type: String?
    public let color: String?
    public let pretext: String?
    public let authorName: String?
    public let authorLink: String?
    public let authorIcon: String?
    public let title: String?
    public let titleLink: String?
    public let text: String?
    public let fields: [AttachmentField]?
    public let actions: [Action]?
    public let imageURL: String?
    public let thumbURL: String?
    public let footer: String?
    public let footerIcon: String?
    public let ts: Int?
    public let markdownEnabledFields: Set<AttachmentTextField>?

    enum CodingKeys: String, CodingKey {
        case fallback
        case callbackId = "callback_id"
        case type = "attachment_type"
        case color
        case pretext
        case authorName = "author_name"
        case authorLink = "author_link"
        case authorIcon = "author_icon"
        case title
        case titleLink = "title_link"
        case text
        case fields
        case actions
        case imageURL = "image_url"
        case thumbURL = "thumb_url"
        case footer
        case footerIcon = "footer_icon"
        case ts
        case markdownEnabledFields = "mrkdwn_in"
    }
    
    public init(attachment: [String: Any]?) {
        fallback = attachment?["fallback"] as? String
        callbackID = attachment?["callback_id"] as? String
        type = attachment?["attachment_type"] as? String
        color = attachment?["color"] as? String
        pretext = attachment?["pretext"] as? String
        authorName = attachment?["author_name"] as? String
        authorLink = attachment?["author_link"] as? String
        authorIcon = attachment?["author_icon"] as? String
        title = attachment?["title"] as? String
        titleLink = attachment?["title_link"] as? String
        text = attachment?["text"] as? String
        imageURL = attachment?["image_url"] as? String
        thumbURL = attachment?["thumb_url"] as? String
        footer = attachment?["footer"] as? String
        footerIcon = attachment?["footer_icon"] as? String
        ts = attachment?["ts"] as? Int
        fields = (attachment?["fields"] as? [[String: Any]])?.map { AttachmentField(field: $0) }
        actions = (attachment?["actions"] as? [[String: Any]])?.map { Action(action: $0) }
        markdownEnabledFields = (attachment?["mrkdwn_in"] as? [String]).map { Set($0.compactMap(AttachmentTextField.init)) }
    }

    public init(
        fallback: String,
        title: String?,
        callbackID: String? = nil,
        type: String? = nil,
        colorHex: String? = nil,
        pretext: String? = nil,
        authorName: String? = nil,
        authorLink: String? = nil,
        authorIcon: String? = nil,
        titleLink: String? = nil,
        text: String? = nil,
        fields: [AttachmentField]? = nil,
        actions: [Action]? = nil,
        imageURL: String? = nil,
        thumbURL: String? = nil,
        footer: String? = nil,
        footerIcon: String? = nil,
        ts: Int? = nil,
        markdownFields: Set<AttachmentTextField>? = nil
    ) {
        self.fallback = fallback
        self.callbackID = callbackID
        self.type = type
        self.color = colorHex
        self.pretext = pretext
        self.authorName = authorName
        self.authorLink = authorLink
        self.authorIcon = authorIcon
        self.title = title
        self.titleLink = titleLink
        self.text = text
        self.fields = fields
        self.actions = actions
        self.imageURL = imageURL
        self.thumbURL = thumbURL
        self.footer = footer
        self.footerIcon = footerIcon
        self.ts = ts
        self.markdownEnabledFields = markdownFields
    }

    public var dictionary: [String: Any] {
        var attachment = [String: Any]()
        attachment["fallback"] = fallback
        attachment["callback_id"] = callbackID
        attachment["attachment_type"] = type
        attachment["color"] = color
        attachment["pretext"] = pretext
        attachment["author_name"] = authorName
        attachment["author_link"] = authorLink
        attachment["author_icon"] = authorIcon
        attachment["title"] = title
        attachment["title_link"] = titleLink
        attachment["text"] = text
        attachment["fields"] = fields?.map { $0.dictionary }
        attachment["actions"] = actions?.map { $0.dictionary }
        attachment["image_url"] = imageURL
        attachment["thumb_url"] = thumbURL
        attachment["footer"] = footer
        attachment["footer_icon"] = footerIcon
        attachment["ts"] = ts
        attachment["mrkdwn_in"] = markdownEnabledFields?.map { $0.rawValue }
        return attachment
    }
}

extension Attachment: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fallback, forKey: .fallback)
        try container.encode(callbackID, forKey: .callbackId)
        try container.encode(type, forKey: .type)
        try container.encode(color, forKey: .color)
        try container.encode(pretext, forKey: .pretext)
        try container.encode(authorName, forKey: .authorName)
        try container.encode(authorLink, forKey: .authorLink)
        try container.encode(authorIcon, forKey: .authorIcon)
        try container.encode(title, forKey: .title)
        try container.encode(titleLink, forKey: .titleLink)
        try container.encode(text, forKey: .text)
        try container.encode(fields, forKey: .fields)
        try container.encode(actions, forKey: .actions)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(thumbURL, forKey: .thumbURL)
        try container.encode(footer, forKey: .footer)
        try container.encode(footerIcon, forKey: .footerIcon)
        try container.encode(ts, forKey: .ts)
        try container.encode(markdownEnabledFields, forKey: .markdownEnabledFields)
    }
}

extension Attachment: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fallback = try values.decode(String.self, forKey: .fallback)
        callbackID = try values.decode(String.self, forKey: .callbackId)
        type = try values.decode(String.self, forKey: .type)
        color = try values.decode(String.self, forKey: .color)
        pretext = try values.decode(String.self, forKey: .pretext)
        authorName = try values.decode(String.self, forKey: .authorName)
        authorLink = try values.decode(String.self, forKey: .authorLink)
        authorIcon = try values.decode(String.self, forKey: .authorIcon)
        title = try values.decode(String.self, forKey: .title)
        titleLink = try values.decode(String.self, forKey: .titleLink)
        text = try values.decode(String.self, forKey: .text)
        fields = try values.decode([AttachmentField].self, forKey: .fields)
        actions = try values.decode([Action].self, forKey: .actions)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        thumbURL = try values.decode(String.self, forKey: .thumbURL)
        footer = try values.decode(String.self, forKey: .footer)
        footerIcon = try values.decode(String.self, forKey: .footerIcon)
        ts = try values.decode(Int.self, forKey: .ts)
        markdownEnabledFields = try values.decode(Set<AttachmentTextField>.self, forKey: .markdownEnabledFields)
    }
}

public enum AttachmentColor: String, Codable {
    case good, warning, danger
}

public enum AttachmentTextField: String, Codable {
    case fallback
    case pretext
    case authorName = "author_name"
    case title
    case text
    case fields
    case footer
}
