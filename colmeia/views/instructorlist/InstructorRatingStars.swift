import UIKit
import SnapKit
import RxSwift

class InstructorRatingStars: UIView {
    private struct Constants {
        static let starSize = 11
    }
    private let stars = 5.times { UIImageView() }

    let rating = Variable<Float>(5)

    let disposeBag = DisposeBag()

    init() {
        super.init(frame:CGRect.zero)

        loadContent()
        makeLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadContent() {
        configureRatingObservable()

        stars.forEach { item in
            item.image = CoreStyle.ratingStar
            item.tintColor = CoreStyle.color.orange
            addSubview(item)
        }
    }

    private func makeLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(Constants.starSize)
        }

        var lastItem: UIImageView?

        for item in stars {
            item.snp.makeConstraints { make in
                if let lastItem = lastItem {
                    make.left.equalTo(lastItem.snp.right).offset(2)
                } else {
                    make.left.equalTo(0)
                }
                make.height.width.equalTo(Constants.starSize)
                make.centerY.equalTo(snp.centerY)
            }

            lastItem = item
        }

        stars.last?.snp.makeConstraints { make in
            make.right.equalTo(0)
        }
    }

    private func configureRatingObservable() {
        rating.asObservable()
            .subscribe(onNext: { [weak self] rating in
                guard let this = self else {
                    return
                }

                let clampedRating = clamp(
                    value: rating, lower: 0, upper: 5)
                let roundedRating = Int(roundf(clampedRating)) - 1
                let clampedRoundedRating = clamp(
                    value: roundedRating, lower: 0, upper: 5)

                for (index, item) in this.stars.enumerated() {
                    if index <= clampedRoundedRating {
                        item.tintColor = CoreStyle.color.orange
                    } else {
                        item.tintColor = CoreStyle.color.lightGray
                    }
                }
            })
            .addDisposableTo(disposeBag)
    }
}
