
import Foundation

public class JSONDateTimeDecoder: JSONDecoder {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "GMT")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return formatter
    }()

    override init() {
        super.init()
        self.dateDecodingStrategy = .formatted(JSONDateTimeDecoder.dateFormatter)
    }
}
