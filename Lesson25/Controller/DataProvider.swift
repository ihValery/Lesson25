import UIKit

enum Section: Int {
    case todo
    case done
}

//Наследование от NSObject так как мы его подгружаем со storyboard
class DataProvider: NSObject {
    
    var taskManager: TaskManager?
    
}

extension DataProvider: UITableViewDelegate {
    
}

extension DataProvider: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let taskManager = taskManager else { return 0 }
//        guard section == 0 else { return taskManager.tasksDoneCount }
//        return taskManager.tasksCount

        //Если не можем создать section из enum, то у нас явная ошибка
        guard let section = Section(rawValue: section) else { fatalError() }
        guard let taskManager = taskManager else { return 0 }
        switch section {
            case .todo: return taskManager.tasksCount
            case .done: return taskManager.tasksDoneCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TaskCell()
    }
}
