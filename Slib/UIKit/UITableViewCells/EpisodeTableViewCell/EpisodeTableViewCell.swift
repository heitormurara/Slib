import UIKit
import SnapKit

final class EpisodeTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel(style: .primaryText)
    
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
        selectionStyle = .none
    }
    
    func set(name: String) {
        nameLabel.text = name
    }
    
    private func setUpSubviews() {
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(Spacings.m)
            $0.top.equalToSuperview()
                .offset(Spacings.m)
            $0.trailing.equalToSuperview()
                .offset(Spacings.m)
            $0.bottom.equalToSuperview()
                .offset(Spacings.m)
        }
    }
}
