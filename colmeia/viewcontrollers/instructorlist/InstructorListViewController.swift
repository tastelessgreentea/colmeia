import UIKit
import SnapKit
import RxCocoa
import RxSwift

class InstructorListViewController: UIViewController, UISearchBarDelegate {
    private struct Constants {
        static let screenTitle = "Professores"
        static let instructorListCellIdentifier
            = "InstructorListCell"
        static let alertTitle = "Currículo"
        static let alertOkButtonTitle = "Ok"
    }

    let viewModel = InstructorListViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadContent()
        makeLayout()
    }

    func loadContent() {
        title = Constants.screenTitle
        definesPresentationContext = true

        configureSearchBar()
        configureTableView()

        view.addSubview(tableView)
    }


    func makeLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }

    func configureSearchBar() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.rx.text.orEmpty
            .bindTo(viewModel.searchText)
            .addDisposableTo(disposeBag)
    }

    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight =
            CGFloat(InstructorListCell.Constants.cellHeight)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(InstructorListCell.self,
            forCellReuseIdentifier: Constants.instructorListCellIdentifier)

        viewModel.filteredInstructors.asObservable()
            .bindTo(tableView.rx.items(
                cellIdentifier: Constants.instructorListCellIdentifier,
                cellType: InstructorListCell.self)) { (row, element, cell) in
                    cell.populate(withViewModel: element)
            }.addDisposableTo(disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let this = self else {
                    return
                }

                guard let cell = this.tableView.cellForRow(
                    at: indexPath) as? InstructorListCell,
                    let viewModel = cell.viewModel else {
                        return
                }

                let alertController = UIAlertController(title: Constants.alertTitle,
                    message: viewModel.curriculumString, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Constants.alertOkButtonTitle,
                    style: .default, handler: { [weak self](alertAction) in
                        self?.tableView.deselectRow(at: indexPath, animated: false)
                }))
                this.present(alertController, animated: true, completion: nil)
                this.searchController.searchBar.resignFirstResponder()
            })
            .addDisposableTo(disposeBag)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText.value = ""
    }
}
