import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(identifier: "InputTaskViewController") as? InputTaskViewController {
            present(viewController, animated: true, completion: nil)
        }
    }
}
