import UIKit

protocol SeriesListViewControllerProtocol: AnyObject {
    
}

final class SeriesListViewController: UIViewController {
    
    var viewModel: SeriesListViewModelProtocol
    
    init(viewModel: SeriesListViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

// MARK: - SeriesListViewControllerProtocol
extension SeriesListViewController: SeriesListViewControllerProtocol {
    
}
