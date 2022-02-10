import UIKit
import SnapKit
import Kingfisher

final class SeriesTableViewCell: UITableViewCell {
    
    private struct Constants {
        
        static let bannerImageHeight: CGFloat = 295 / 2
        static let bannerImageWidth: CGFloat = 210 / 2
    }
    
    private let bannerImageView = UIImageView(style: .rounded)
    
    private let titleLabel = UILabel(style: .title)
    
    private let genresLabel = UILabel(style: .secondaryText)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpStyle()
        setUpSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ model: SeriesTableViewCellModel) {
        bannerImageView.kf.setImage(with: model.bannerImageURL)
        titleLabel.text = model.title
        genresLabel.text = model.genres.joined(separator: ", ")
    }
    
    private func setUpStyle() {
        backgroundColor = Colors.clear
        selectionStyle = .none
    }
    
    private func setUpSubviews() {
        addSubviews(bannerImageView,
                    titleLabel,
                    genresLabel)
        
        bannerImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
                .offset(Spacings.m)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(bannerImageView.snp.height)
                .multipliedBy(0.7)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bannerImageView.snp.trailing)
                .offset(Spacings.m)
            $0.centerY.equalTo(bannerImageView)
            $0.trailing.equalToSuperview()
                .offset(-Spacings.m)
        }
        
        genresLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(Spacings.ss)
        }
    }
}
