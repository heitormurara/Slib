import UIKit

protocol SeriesListViewControllerProtocol: AnyObject {
    
    func reloadTableView()
}

final class SeriesListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(SeriesTableViewCell.self,
                           forCellReuseIdentifier: SeriesTableViewCell.reuseIdentifier)
        tableView.backgroundColor = Colors.clear
        return tableView
    }()
    
    var presenter: SeriesListPresenterProtocol?
    
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
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - SeriesListViewControllerProtocol
extension SeriesListViewController: SeriesListViewControllerProtocol {
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SeriesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter?.tableViewDataSource.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: SeriesTableViewCell.reuseIdentifier,
                                                         for: indexPath)
        guard let cell = reusableCell as? SeriesTableViewCell,
              let model = presenter?.tableViewDataSource[indexPath.row]
        else { return reusableCell }
        
        cell.set(model)
        return cell
    }
}
