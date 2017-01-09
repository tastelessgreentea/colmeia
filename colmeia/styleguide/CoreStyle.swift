import UIKit

class CoreStyle {
    static let color = (
        black: UIColor.black,
        white: UIColor.white,
        transparent: UIColor.clear,
        red: UIColor.red,
        blue: UIColor.blue,
        green: UIColor.green,
        yellow: UIColor.yellow,
        gray: UIColor.gray,
        lightGray: UIColor.lightGray,
        orange: UIColor(hexCode: "#FDA52F")
    )

    static let gutter = (
        top: 10,
        left: 10,
        right: -10,
        bottom: -10
    )

    static let font = (
        regular: UIFont.systemFont(ofSize: 1),
        bold: UIFont.systemFont(ofSize: 1, weight: UIFontWeightBold)
    )

    static let ratingStar = UIImage(named:"star")?
        .withRenderingMode(.alwaysTemplate)
}
