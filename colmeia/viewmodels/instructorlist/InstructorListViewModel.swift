import Foundation
import RxSwift

class InstructorListViewModel {
    private let disposeBag = DisposeBag()

    private let instructors: Observable<[Instructor]>
    private let instructorsViewModel: Observable<[InstructorListItemViewModel]>
    let filteredInstructors: Observable<[InstructorListItemViewModel]>
    let searchText = Variable<String>("")

    init() {
        let apiClient = APIClient()

        instructors = apiClient.instructors()
            .shareReplay(1)

        instructorsViewModel = instructors
            .map { $0.map { InstructorListItemViewModel(model: $0) } }
            .shareReplay(1)

        filteredInstructors = Observable.combineLatest(
            instructorsViewModel,
            searchText.asObservable()) { (allInstructors: [InstructorListItemViewModel],
                searchString: String) -> [InstructorListItemViewModel] in
                    return searchString.isEmpty ? allInstructors :
                        allInstructors.filter { $0.nameString.lowercased()
                            .contains(searchString.lowercased()) }
            }
    }
}
