import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Parse

class InstructorListCell: UITableViewCell {
    struct Constants {
        static let cellHeight = 76
    }

    private let userImagePlaceholder = UIView()
    private let userImageView = CenteredScaledProfileImage()
    private let nameLabel = UILabel()
    private let courseLabel = UILabel()
    private let ratingStars = InstructorRatingStars()
    private let ratingLabel = InstructorRatingLabel()
    private let separator = UIView()

    var viewModel: InstructorListItemViewModel?
    private var disposeBag = DisposeBag()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        loadContent()
        makeLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadContent() {
        let radius = CGFloat(Constants.cellHeight - CoreStyle.gutter.top
            + CoreStyle.gutter.bottom) / CGFloat(2)

        userImagePlaceholder.backgroundColor = CoreStyle.color.lightGray
        userImagePlaceholder.alpha = 0.5
        userImagePlaceholder.layer.cornerRadius = radius

        userImageView.alpha = 0
        userImageView.layer.cornerRadius = radius

        separator.backgroundColor = CoreStyle.color.lightGray
        separator.alpha = 0.5

        nameLabel.font = CoreStyle.font.regular.withSize(13)
        courseLabel.font = CoreStyle.font.bold.withSize(11)

        contentView.addSubview(userImagePlaceholder)
        contentView.addSubview(userImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(courseLabel)
        contentView.addSubview(ratingStars)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(separator)
    }

    private func makeLayout() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(Constants.cellHeight)
            make.left.top.right.equalTo(0)
        }

        userImagePlaceholder.snp.makeConstraints { make in
            make.left.equalTo(CoreStyle.gutter.left)
            make.top.equalTo(CoreStyle.gutter.top)
            make.bottom.equalTo(CoreStyle.gutter.bottom)
            make.width.equalTo(userImagePlaceholder.snp.height)
        }

        userImageView.snp.makeConstraints { make in
            make.edges.equalTo(userImagePlaceholder)
        }

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(userImagePlaceholder.snp.right)
                .offset(CoreStyle.gutter.left)
            make.right.equalTo(CoreStyle.gutter.right)
            make.top.equalTo(userImagePlaceholder.snp.top)
        }

        courseLabel.snp.makeConstraints { make in
            make.left.equalTo(userImagePlaceholder.snp.right)
                .offset(CoreStyle.gutter.left)
            make.right.equalTo(CoreStyle.gutter.right)
            make.centerY.equalTo(userImagePlaceholder.snp.centerY)
        }

        ratingStars.snp.makeConstraints { make in
            make.left.equalTo(userImagePlaceholder.snp.right)
                .offset(CoreStyle.gutter.left)
            make.bottom.equalTo(userImagePlaceholder.snp.bottom)
        }

        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(ratingStars.snp.right)
                .offset(12)
            make.centerY.equalTo(ratingStars)
        }

        separator.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.left.equalTo(CoreStyle.gutter.left)
            make.right.equalTo(CoreStyle.gutter.right)
            make.height.equalTo(1)
        }
    }

    func populate(withViewModel: InstructorListItemViewModel) {
        viewModel = withViewModel

        viewModel?.name
            .bindTo(nameLabel.rx.text)
            .addDisposableTo(disposeBag)

        viewModel?.course
            .bindTo(courseLabel.rx.text)
            .addDisposableTo(disposeBag)

        viewModel?.rating
            .bindTo(ratingStars.rating)
            .addDisposableTo(disposeBag)

        viewModel?.rating.map { String($0) }
            .bindTo(ratingLabel.ratingLabel.rx.text)
            .addDisposableTo(disposeBag)

        viewModel?.image.getDataInBackground { [weak self] imageData, error in
            guard let this = self else {
                return
            }

            if let error = error {
                print(error)
                return
            }

            guard let imageData = imageData else {
                return
            }

            guard let image = UIImage(data: imageData) else {
                return
            }

            this.userImageView.update(withImage: image)
            UIView.animate(withDuration: 0.4) {
                this.userImageView.alpha = 1
            }
        }
    }

    override func prepareForReuse() {
        userImageView.alpha = 0
        userImageView.profileImageView.image = nil
        disposeBag = DisposeBag()
    }
}
