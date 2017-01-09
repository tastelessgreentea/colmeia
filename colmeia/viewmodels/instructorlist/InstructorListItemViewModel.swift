import Foundation
import RxSwift
import Parse

class InstructorListItemViewModel {
    private let disposeBag = DisposeBag()

    private let model: Instructor

    let name: Observable<String>
    let course: Observable<String>
    let rating: Observable<Float>

    var image: PFFile {
        return model.image
    }

    var nameString: String {
        return model.name
    }

    var curriculumString: String {
        return model.curriculum
    }

    init(model: Instructor) {
        self.model = model

        name = Observable<String>.just(model.name)
        course = Observable<String>.just(model.course)
        rating = Observable<Float>.just(model.rating)
    }
}
