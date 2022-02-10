import UIKit

protocol SeriesDetailViewControllerProtocol: AnyObject {
    
}

final class SeriesDetailViewController: UIViewController {
    
    var presenter: SeriesDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
        setUpConstraints()
        presenter?.viewDidLoad()
    }
    
    private func setUpStyle() {
        view.backgroundColor = Colors.backgroundSystem
    }
    
    private func setUpConstraints() {
        
    }
}

// MARK: - SeriesDetailViewControllerProtocol
extension SeriesDetailViewController: SeriesDetailViewControllerProtocol {
    
}
