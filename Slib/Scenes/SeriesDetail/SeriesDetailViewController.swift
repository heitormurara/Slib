import UIKit
import Kingfisher

protocol SeriesDetailViewControllerProtocol: AnyObject {
    
    func displaySeries()
    func displaySeasonEpisodes()
}

final class SeriesDetailViewController: UIViewController {
    
    private let tableHeaderView = UIView()
    
    private let bannerImageView = UIImageView(style: .rounded)
    
    private let titleLabel = UILabel(styles: .largeTitle, .center)
    
//    private let scheduleLabel = UILabel(style: .secondaryText)
    
    private let genresLabel = UILabel(styles: .tertiaryText, .center)
    
    private let summaryLabelTitle = UILabel(style: .title)
    
    private let summaryLabel = UILabel(styles: .primaryText, .unlimitedLines)
    
    private let episodesTitleLabel = UILabel(style: .title)
    
    private lazy var episodesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(EpisodeTableViewCell.self,
                           forCellReuseIdentifier: EpisodeTableViewCell.reuseIdentifier)
        tableView.backgroundColor = Colors.clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var presenter: SeriesDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
        setUpConstraints()
        presenter?.viewDidLoad()
        
        episodesTitleLabel.text = "Episodes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.configureSmallNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let header = episodesTableView.tableHeaderView {
            header.setNeedsLayout()
            header.layoutIfNeeded()
            
            let height = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = header.frame
            frame.size.height = height
            header.frame = frame
            
            episodesTableView.tableHeaderView = header
        }
    }
    
    private func setUpStyle() {
        view.backgroundColor = Colors.backgroundSystem
    }
    
    private func setUpConstraints() {
        view.addSubview(episodesTableView)
        tableHeaderView.addSubviews(bannerImageView,
                                    titleLabel,
                                    genresLabel,
                                    summaryLabelTitle,
                                    summaryLabel,
                                    episodesTitleLabel)
        episodesTableView.tableHeaderView = tableHeaderView
        
        episodesTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
                .inset(Spacings.m)
            $0.top.bottom.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(bannerImageView.snp.bottom)
                .offset(Spacings.m)
        }
        
        genresLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(Spacings.ss)
        }
        
        summaryLabelTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(genresLabel.snp.bottom)
                .offset(Spacings.g)
        }

        summaryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(summaryLabelTitle.snp.bottom)
                .offset(Spacings.m)
        }

        episodesTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(summaryLabel.snp.bottom)
                .offset(Spacings.g)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - SeriesDetailViewControllerProtocol
extension SeriesDetailViewController: SeriesDetailViewControllerProtocol {
    
    func displaySeries() {
        guard let series = presenter?.series else { return }
        bannerImageView.kf.setImage(with: URL(string: series.image.mediumSizeURL))
        titleLabel.text = series.name
        genresLabel.text = series.genres.joined(separator: ",")
        summaryLabelTitle.text = "Summary"
        summaryLabel.text = series.summary.strippingHTMLTags()
    }
    
    func displaySeasonEpisodes() {
        episodesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SeriesDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.seasonEpisodes.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter?.seasonEpisodes[section]?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.reuseIdentifier,
                                                         for: indexPath)
        guard let cell = reusableCell as? EpisodeTableViewCell,
              let episode = presenter?.seasonEpisodes[indexPath.section]?[indexPath.row]
        else { return reusableCell }
        
        cell.set(name: "\(episode.id) - \(episode.name)")
        return cell
    }
}
