import UIKit

class DetailViewController: UIViewController {

    var value: String = ""
    
    private lazy var label: UITextView = {
        let view = UITextView()
        view.frame = self.view.frame
        view.textColor = .black
        view.textAlignment = .left
        view.backgroundColor = .white
        return view
    }()
    
    var name: String! {
        didSet {
            title = name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(label)
        label.text = value
    }
}
