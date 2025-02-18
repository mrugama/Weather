import OSLog

public enum Module: String {
    case networking,
         endpoint,
         restAPI,
         landingPage
    
    var description: String {
        return rawValue
    }
}

public typealias WTLogger = Logger

public extension WTLogger {
    init (module: Module) {
        let subsystem: String = Bundle.main.bundleIdentifier ?? "com.mrugama.weather"
        self.init(subsystem: subsystem, category: module.description)
    }
    
    private init () { self.init(.default) }
    
    private init (subsystem: String, category: String) {
        self.init(.default)
    }
}
