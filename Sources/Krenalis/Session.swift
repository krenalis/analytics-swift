import Foundation

func newSession(id: Int64?, timeout: Int64) -> SessionInfo {
    var sessionId = id
    let now = Int64(Date().timeIntervalSince1970 * 1000)
    if (sessionId == nil) {
        sessionId = now
    }
    let expiration = now + timeout
    return SessionInfo(id: sessionId, expiration: expiration, start: true)
}