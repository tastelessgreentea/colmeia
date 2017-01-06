import Foundation
import Runes

struct Environment {
    private struct Constants {
        static let environmentFile = "environment"
    }

    static let shared = Environment()

    let parseInfo: ParseInfo

    private init() {
        func environmentXMLData(path: String) -> Data {
            guard let environmentXMLData = FileManager.default.contents(atPath: path) else {
                fatalError("Unable to read \(path) as an XML")
            }

            return environmentXMLData
        }

        let environmentPath = Bundle.main.path(
            forResource: Constants.environmentFile, ofType: "plist")

        guard let envXMLData = environmentXMLData <^> environmentPath else {
            fatalError("Unable to find the resource for \(Constants.environmentFile).plist")
        }

        let envDictionary: [String: AnyObject]?
        do {
            var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
            envDictionary = try PropertyListSerialization.propertyList(
                from: envXMLData, options: .mutableContainersAndLeaves,
                format: &propertyListFormat) as? [String:AnyObject]
        } catch {
            fatalError("Unable to decode \(Constants.environmentFile).plist into dictionary")
        }

        guard let envDictionaryUnwrapped = envDictionary else {
            fatalError("Unable to decode \(Constants.environmentFile).plist into dictionary")
        }

        parseInfo = ParseInfo(environmentDictionary: envDictionaryUnwrapped)
    }
}

struct ParseInfo {
    let appID: String
    let clientKey: String
    let server: String

    init(environmentDictionary: [String: AnyObject]) {
        guard let parseDictionary = environmentDictionary["parseInfo"] as? [String: AnyObject],
            let appID = parseDictionary["appID"] as? String,
            let clientKey = parseDictionary["clientKey"] as? String ,
            let server = parseDictionary["server"] as? String else {
                fatalError("Missing parse information")
        }

        self.appID = appID
        self.clientKey = clientKey
        self.server = server
    }
}
