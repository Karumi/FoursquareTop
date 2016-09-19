
import Foundation

class FoursquareTopApplicationLifeCycleTasks {
    
    static var allTasks: [ApplicationLifecycleTask] {
        let tasks: [ApplicationLifecycleTask] = [
            ShortcutTask()
        ]
        
        return tasks
    }
    
}