import SwiftyJSON

public struct Creature {
    public let id: String?
    public let name: String
    public let picture: String?

    public init(id: String?, name: String, picture: String?) {
        self.id = id
        self.name = name
        self.picture = picture
    }

    public init(json: JSON) throws {
        // Required properties
        guard json["name"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "name")
        }
        guard let name = json["name"].string else {
            throw ModelError.propertyTypeMismatch(name: "name", type: "string", value: json["name"].description, valueType: String(describing: json["name"].type))
        }
        self.name = name

        // Optional properties
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        self.id = json["id"].string
        if json["picture"].exists() &&
           json["picture"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "picture", type: "string", value: json["picture"].description, valueType: String(describing: json["picture"].type))
        }
        self.picture = json["picture"].string

        // Check for extraneous properties
        if let jsonProperties = json.dictionary?.keys {
            let properties: [String] = ["id", "name", "picture"]
            for jsonPropertyName in jsonProperties {
                if !properties.contains(where: { $0 == jsonPropertyName }) {
                    throw ModelError.extraneousProperty(name: jsonPropertyName)
                }
            }
        }
    }

    public func settingID(_ newId: String?) -> Creature {
      return Creature(id: newId, name: name, picture: picture)
    }

    public func updatingWith(json: JSON) throws -> Creature {
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        let id = json["id"].string ?? self.id

        if json["name"].exists() &&
           json["name"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "name", type: "string", value: json["name"].description, valueType: String(describing: json["name"].type))
        }
        let name = json["name"].string ?? self.name

        if json["picture"].exists() &&
           json["picture"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "picture", type: "string", value: json["picture"].description, valueType: String(describing: json["picture"].type))
        }
        let picture = json["picture"].string ?? self.picture

        return Creature(id: id, name: name, picture: picture)
    }

    public func toJSON() -> JSON {
        var result = JSON([:])
        result["name"] = JSON(name)
        if let id = id {
            result["id"] = JSON(id)
        }
        if let picture = picture {
            result["picture"] = JSON(picture)
        }

        return result
    }
}
