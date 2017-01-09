import Foundation
import Parse

struct Instructor {
    private struct Keys {
        static let curriculumKey = "curriculo"
        static let nameKey = "nome"
        static let ratingKey = "nota"
        static let courseKey = "materia"
        static let imageKey = "imagem"
    }
    let curriculum: String
    let name: String
    let rating: Float
    let course: String
    let image: PFFile

    init?(object: PFObject) {
        guard let curriculum = object[Keys.curriculumKey] as? String,
            let name = object[Keys.nameKey] as? String,
            let rating = object[Keys.ratingKey] as? Float,
            let course = object[Keys.courseKey] as? String,
            let image = object[Keys.imageKey] as? PFFile else {
                return nil
        }

        self.curriculum = curriculum
        self.name = name
        self.rating = rating
        self.course = course
        self.image = image
    }
}
