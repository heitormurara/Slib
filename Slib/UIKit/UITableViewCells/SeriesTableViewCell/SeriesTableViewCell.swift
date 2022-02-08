import UIKit
import SnapKit

final class SeriesTableViewCell: UITableViewCell {
    
    private let bannerImageView = UIImageView()
    
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
    
    private func setUpStyle() {
        backgroundColor = Colors.clear
    }
    
    private func setUpSubviews() {
        addSubviews(bannerImageView,
                    titleLabel,
                    genresLabel)
        
        bannerImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bannerImageView)
                .offset(Spacings.m)
            $0.centerY.equalTo(bannerImageView)
            $0.trailing.equalToSuperview()
                .offset(Spacings.m)
        }
    }
}
