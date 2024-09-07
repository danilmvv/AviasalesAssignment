import Foundation
import OSLog

final class CategoryLogger {
    private let logger: Logger
    
    init(category: AppLogger.Category) {
        self.logger = Logger(
            subsystem: Bundle.main.bundleIdentifier ?? "nilBundleIdentifier",
            category: category.rawValue
        )
    }
    
    func debug<Object>(
        _ object: Object,
        function: String = #function,
        fileId: String = #fileID,
        line: Int = #line
    ) {
        log(level: .debug, object: object, function: function, fileId: fileId, line: line)
    }
    
    func info<Object>(
        _ object: Object,
        function: String = #function,
        fileId: String = #fileID,
        line: Int = #line
    ) {
        log(level: .info, object: object, function: function, fileId: fileId, line: line)
    }
    
    func error<Object>(
        _ object: Object,
        function: String = #function,
        fileId: String = #fileID,
        line: Int = #line
    ) {
        log(level: .fault, object: object, function: function, fileId: fileId, line: line)
    }
    
    func warning<Object>(
        _ object: Object,
        function: String = #function,
        fileId: String = #fileID,
        line: Int = #line
    ) {
        log(level: .error, object: object, function: function, fileId: fileId, line: line)
    }
    
    private func log<Object>(
        level: OSLogType,
        object: Object,
        function: String,
        fileId: String = #fileID,
        line: Int = #line
    ) {
        // TODO: Release logs
        let message = self.formatMessage(object: object, function: function, fileId: fileId, line: line)
#if DEBUG
        switch level {
        case .debug:
            logger.debug("\(message)")
        case .info:
            logger.info("\(message)")
        case .error:
            logger.error("\(message)")
        case .fault:
            logger.fault("\(message)")
        default:
            logger.log("\(message)")
        }
#endif
    }
    
    private func formatMessage<Object>(object: Object, function: String, fileId: String, line: Int) -> String {
        """
        Log: \(object)
        File: \(fileId)
        Function: \(function) called on line \(line)
        """
    }
}
