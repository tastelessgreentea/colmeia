import Foundation
import Runes

struct Environment {
    private struct Constants {
        static let environmentFile = "environment"
    }

    static let shared = Environment()

    let parseInfo: ParseInfo

    private init() {
        let environmentPath = Bundle.main.path(
            forResource: Constants.environmentFile, ofType: "plist")

        guard let envDict = Environment.environmentDictionaryFromData -<<
            Environment.environmentXMLDataFromPath <^> environmentPath else {
                fatalError("Unable to find the resource for \(Constants.environmentFile).plist")
        }

        parseInfo = ParseInfo(environmentDictionary: envDict)
    }

    private static func environmentXMLDataFromPath(path: String) -> Data {
        guard let environmentXMLData = FileManager.default.contents(atPath: path) else {
            fatalError("Unable to read \(path) as an XML")
        }

        return environmentXMLData
    }

    private static func environmentDictionaryFromData(
            environmentXMLData: Data) -> [String: AnyObject] {
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml

        guard let envDictionary = try? PropertyListSerialization.propertyList(
            from: environmentXMLData, options: .mutableContainersAndLeaves,
            format: &propertyListFormat) as? [String:AnyObject] else {
                fatalError("Unable to decode \(Constants.environmentFile).plist into dictionary")
        }

        guard let envDictionaryUnwrapped = envDictionary else {
            fatalError("Unable to decode \(Constants.environmentFile).plist into dictionary")
        }

        return envDictionaryUnwrapped
    }
}

struct ParseInfo {
    private struct Keys {
        static let parseInfoKey = "parseInfo"
        static let appIDKey = "appID"
        static let clientKey = "clientKey"
        static let serverKey = "server"
    }

    let appID: String
    let clientKey: String
    let server: String

    init(environmentDictionary: [String: AnyObject]) {
        guard let parseDictionary = environmentDictionary[Keys.parseInfoKey] as? [String: AnyObject],
            let appID = parseDictionary[Keys.appIDKey] as? String,
            let clientKey = parseDictionary[Keys.clientKey] as? String ,
            let server = parseDictionary[Keys.serverKey] as? String else {
                fatalError("Missing parse information")
        }

        self.appID = appID
        self.clientKey = clientKey
        self.server = server
    }
}
