import Foundation

// sourcery: skipDiffing
#if canImport(ObjectiveC)
@objcMembers
#endif
public final class ClosureParameter: NSObject, SourceryModel, Typed, Annotated {
    /// Parameter external name
    public var argumentLabel: String?

    /// Parameter internal name
    public let name: String?

    /// Parameter type name
    public let typeName: TypeName

    /// Parameter flag whether it's inout or not
    public let `inout`: Bool

    // sourcery: skipEquality, skipDescription
    /// Parameter type, if known
    public var type: Type?

    /// Parameter type attributes, i.e. `@escaping`
    public var typeAttributes: AttributeList {
        return typeName.attributes
    }

    /// Method parameter default value expression
    public var defaultValue: String?

    /// Annotations, that were created with // sourcery: annotation1, other = "annotation value", alterantive = 2
    public var annotations: Annotations = [:]

    /// :nodoc:
    public init(argumentLabel: String? = nil, name: String? = nil, typeName: TypeName, type: Type? = nil,
                defaultValue: String? = nil, annotations: [String: NSObject] = [:], isInout: Bool = false) {
        self.typeName = typeName
        self.argumentLabel = argumentLabel
        self.name = name
        self.type = type
        self.defaultValue = defaultValue
        self.annotations = annotations
        self.`inout` = isInout
    }

    public var asSource: String {
        let typeInfo = "\(`inout` ? "inout " : "")\(typeName.asSource)"
        if argumentLabel?.nilIfNotValidParameterName == nil, name?.nilIfNotValidParameterName == nil {
            return typeInfo
        }

        let typeSuffix = ": \(typeInfo)"
        guard argumentLabel != name else {
            return name ?? "" + typeSuffix
        }

        let labels = [argumentLabel ?? "_", name?.nilIfEmpty]
          .compactMap { $0 }
          .joined(separator: " ")

        return (labels.nilIfEmpty ?? "_") + typeSuffix
    }

    public override var hash: Int {
        var hasher = Hasher()
        hasher.combine(self.argumentLabel)
        hasher.combine(self.name)
        hasher.combine(self.typeName)
        hasher.combine(self.`inout`)
        hasher.combine(self.defaultValue)
        hasher.combine(self.annotations)
        return hasher.finalize()
    }

    /// :nodoc:
    override public var description: String {
        var string = "\(Swift.type(of: self)): "
        string += "argumentLabel = \(String(describing: self.argumentLabel)), "
        string += "name = \(String(describing: self.name)), "
        string += "typeName = \(String(describing: self.typeName)), "
        string += "`inout` = \(String(describing: self.`inout`)), "
        string += "typeAttributes = \(String(describing: self.typeAttributes)), "
        string += "defaultValue = \(String(describing: self.defaultValue)), "
        string += "annotations = \(String(describing: self.annotations)), "
        string += "asSource = \(String(describing: self.asSource))"
        return string
    }

    /// :nodoc:
    public override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? ClosureParameter else { return false }
        if self.argumentLabel != rhs.argumentLabel { return false }
        if self.name != rhs.name { return false }
        if self.typeName != rhs.typeName { return false }
        if self.`inout` != rhs.`inout` { return false }
        if self.defaultValue != rhs.defaultValue { return false }
        if self.annotations != rhs.annotations { return false }
        return true
    }

    // sourcery:inline:ClosureParameter.AutoCoding

            /// :nodoc:
            required public init?(coder aDecoder: NSCoder) {
                self.argumentLabel = aDecoder.decode(forKey: "argumentLabel")
                self.name = aDecoder.decode(forKey: "name")
                guard let typeName: TypeName = aDecoder.decode(forKey: "typeName") else { 
                withVaList(["typeName"]) { arguments in
                    NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: arguments)
                }
                fatalError()
             }; self.typeName = typeName
                self.`inout` = aDecoder.decode(forKey: "`inout`")
                self.type = aDecoder.decode(forKey: "type")
                self.defaultValue = aDecoder.decode(forKey: "defaultValue")
                guard let annotations: Annotations = aDecoder.decode(forKey: "annotations") else { 
                withVaList(["annotations"]) { arguments in
                    NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: arguments)
                }
                fatalError()
             }; self.annotations = annotations
            }

            /// :nodoc:
            public func encode(with aCoder: NSCoder) {
                aCoder.encode(self.argumentLabel, forKey: "argumentLabel")
                aCoder.encode(self.name, forKey: "name")
                aCoder.encode(self.typeName, forKey: "typeName")
                aCoder.encode(self.`inout`, forKey: "`inout`")
                aCoder.encode(self.type, forKey: "type")
                aCoder.encode(self.defaultValue, forKey: "defaultValue")
                aCoder.encode(self.annotations, forKey: "annotations")
            }

    // sourcery:end
}

extension Array where Element == ClosureParameter {
    public var asSource: String {
        "(\(map { $0.asSource }.joined(separator: ", ")))"
    }
}
