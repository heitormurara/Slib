import UIKit
import Kingfisher

protocol SeriesDetailViewControllerProtocol: AnyObject {
    
    func displaySeries()
}

final class SeriesDetailViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let containerView = UIView()
    
    private let bannerImageView = UIImageView(style: .rounded)
    
    private let titleLabel = UILabel(styles: .largeTitle, .center)
    
    private let scheduleLabel = UILabel(style: .secondaryText)
    
    private let genresLabel = UILabel(styles: .tertiaryText, .center)
    
    private let summaryLabelTitle = UILabel(style: .title)
    
    private let summaryLabel = UILabel(styles: .primaryText, .unlimitedLines)
    
    var presenter: SeriesDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
        setUpConstraints()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.configureSmallNavigationBar()
    }
    
    private func setUpStyle() {
        view.backgroundColor = Colors.backgroundSystem
    }
    
    private func setUpConstraints() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubviews(bannerImageView,
                                  titleLabel,
                                  scheduleLabel,
                                  genresLabel,
                                  summaryLabelTitle,
                                  summaryLabel)
        
        scrollView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
                .offset(Spacings.m)
            $0.trailing.equalToSuperview()
                .offset(-Spacings.m)
            $0.top.equalTo(bannerImageView.snp_bottomMargin)
                .offset(Spacings.g)
        }
        
        genresLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
                .offset(Spacings.m)
            $0.trailing.equalToSuperview()
                .offset(-Spacings.m)
            $0.top.equalTo(titleLabel.snp_bottomMargin)
                .offset(Spacings.s)
        }
        
        summaryLabelTitle.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(Spacings.m)
            $0.trailing.equalToSuperview()
                .offset(-Spacings.m)
            $0.top.equalTo(genresLabel.snp_bottomMargin)
                .offset(Spacings.g)
        }
        
        summaryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(Spacings.m)
            $0.trailing.equalToSuperview()
                .offset(-Spacings.m)
            $0.top.equalTo(summaryLabelTitle.snp_bottomMargin)
                .offset(Spacings.m)
            $0.bottom.equalToSuperview()
                .offset(-Spacings.g)
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
}
