import Foundation

func notify(title: String, body: String) {
    var note = NSUserNotification()
    note.title = title
    note.informativeText = body

    NSUserNotificationCenter.default.deliver(note)
}
/*
import UserNotifications

let center = UNUserNotificationCenter.current()

func notify(title: String, body: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body

    let request = UNNotificationRequest(
        identifier: UUID().uuidString,
        content: content,
        trigger: nil
    )

    center.add(request)
}
*/
