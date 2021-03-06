import UIKit

protocol SeriesListViewControllerProtocol: AnyObject {
    
    func reloadTableView()
    func displayActivityIndicator(_ isDisplayed: Bool)
}

final class SeriesListViewController: UIViewController {
    
    private struct Constants {
        
        static let activityIndicatorViewHeight: CGFloat = 44
        static let rowHeightViewBoundsMultiplier: CGFloat = 0.2
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SeriesTableViewCell.self,
                           forCellReuseIdentifier: SeriesTableViewCell.reuseIdentifier)
        tableView.backgroundColor = Colors.clear
        tableView.rowHeight = view.bounds.height * Constants.rowHeightViewBoundsMultiplier
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Series"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        return searchController
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = Colors.primaryText
        activityIndicatorView.frame = CGRect(x: .zero,
                                             y: .zero,
                                             width: view.bounds.width,
                                             height: Constants.activityIndicatorViewHeight)
        
        tableView.tableFooterView = activityIndicatorView
        tableView.tableFooterView?.isHidden = false
        
        return activityIndicatorView
    }()
    
    var presenter: SeriesListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
        setUpConstraints()
        presenter?.viewDidLoad()
        
        navigationItem.title = "Slib"
        _ = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.configureLargeNavigationBar()
    }
    
    private func setUpStyle() {
        view.backgroundColor = Colors.backgroundSystem
    }
    
    private func setUpConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(Spacings.m)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
                .offset(Spacings.m)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - SeriesListViewControllerProtocol
extension SeriesListViewController: SeriesListViewControllerProtocol {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func displayActivityIndicator(_ isDisplayed: Bool) {
        switch isDisplayed {
        case true:
            tableView.tableFooterView = activityIndicatorView
        case false:
            tableView.tableFooterView = nil
        }
    }
}

// MARK: - UITableViewDelegate
extension SeriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: .zero) - 1
        if indexPath.row == lastRowIndex {
            presenter?.viewDidReachScrollLimit()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        presenter?.tableViewDidSelectRowAt(indexPath)
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

// MARK: - UISearchBarDelegate
extension SeriesListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchString = searchBar.text else { return }
        presenter?.searchBarSearchButtonClicked(searchString)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchBarCancelButtonClicked()
    }
}
