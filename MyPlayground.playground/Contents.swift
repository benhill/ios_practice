import Foundation

let calendar = Calendar.current
let startTimeComponent = DateComponents(calendar: calendar, hour: 8)
let endTimeComponent   = DateComponents(calendar: calendar, hour: 17, minute: 30)

let now = Date()
let startOfToday = calendar.startOfDay(for: now)
let startTime    = calendar.date(byAdding: startTimeComponent, to: startOfToday)!
let endTime      = calendar.date(byAdding: endTimeComponent, to: startOfToday)!

if startTime <= now && now <= endTime {
    print("between 8 AM and 5:30 PM")
} else {
    print("not between 8 AM and 5:30 PM")
}
