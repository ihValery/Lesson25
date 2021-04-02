import UIKit

//CaseIterable - предоставляет коллекцию всех своих значений.
enum Section: Int, CaseIterable {
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
        return Section.allCases.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        guard let taskManager = taskManager else { fatalError() }
        
        let task: Task
        switch section {
            case .todo: task = taskManager.task(at: indexPath.row)
            case .done: task = taskManager.doneTask(at: indexPath.row)
        }
        cell.configure(withTask: task)
        
        return cell
    }
}
