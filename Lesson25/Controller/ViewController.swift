import UIKit

class ViewController: UIViewController
{
    private(set) var volume = 0
    
    func setVolume(value: Int)
    {
        volume = min(max(value, 0), 100)
    }
    
    func chacarterCompare(strOne: String, strTwo: String) -> Bool
    {
        return Set(strOne) == Set(strTwo)
    }
}
