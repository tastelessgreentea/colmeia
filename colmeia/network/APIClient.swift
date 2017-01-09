import Foundation
import Parse
import RxSwift

struct APIClient {
    init() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = Environment.shared.parseInfo.appID
            $0.clientKey = Environment.shared.parseInfo.clientKey
            $0.server = Environment.shared.parseInfo.server
        }

        Parse.initialize(with: configuration)
    }
}

extension APIClient {
    private struct Constants {
        static let instructorParseClass = "Professores"
    }

    func instructors() -> Observable<[Instructor]> {
        let query = PFQuery(className:Constants.instructorParseClass)
        return Observable.create { observer in
            query.findObjectsInBackground { object, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let object = object else {
                    observer.onNext([])
                    return
                }

                observer.onNext(object.flatMap { Instructor(object: $0) })
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
