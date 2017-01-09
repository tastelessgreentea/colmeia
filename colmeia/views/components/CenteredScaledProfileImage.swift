import UIKit
import SnapKit

class CenteredScaledProfileImage: UIView {

    let profileImageView = UIImageView()
    init() {
        super.init(frame:CGRect.zero)

        loadContent()
        makeLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadContent() {
        clipsToBounds = true
        addSubview(profileImageView)
    }

    private func makeLayout() {

    }

    func update(withImage: UIImage) {
        profileImageView.image = withImage
        profileImageView.snp.remakeConstraints { make in
            if withImage.size.height == 0 || withImage.size.width == 0 {
                return
            }

            if withImage.size.height > withImage.size.width {
                make.centerY.equalTo(self)
                make.left.right.equalTo(self)
                make.height.equalTo(self.profileImageView.snp.width)
                    .multipliedBy(withImage.size.height/withImage.size.width)
            } else {
                make.centerX.equalTo(self)
                make.top.bottom.equalTo(self)
                make.width.equalTo(self.profileImageView.snp.height)
                    .multipliedBy(withImage.size.width/withImage.size.height)
            }
        }
    }
}
