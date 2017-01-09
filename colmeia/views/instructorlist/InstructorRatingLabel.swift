import UIKit
import SnapKit

class InstructorRatingLabel: UIView {
    private struct Constants {
        static let gutter = (
            left: 8,
            right: -8,
            top: 2,
            bottom: -2
        )
    }

    let ratingLabel = UILabel()

    init() {
        super.init(frame:CGRect.zero)

        loadContent()
        makeLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadContent() {
        layer.borderColor = CoreStyle.color.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        ratingLabel.font = CoreStyle.font.regular.withSize(13)

        addSubview(ratingLabel)
    }

    private func makeLayout() {
        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(Constants.gutter.left)
            make.right.equalTo(Constants.gutter.right)
            make.top.equalTo(Constants.gutter.top)
            make.bottom.equalTo(Constants.gutter.bottom)
        }
    }
}
