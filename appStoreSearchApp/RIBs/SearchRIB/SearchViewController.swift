//
//  SearchViewController.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol SearchPresentableListener: AnyObject {
    var searchListObservable: Observable<[AppInfoDTO]> { get }
    
    func search(term: String)
    func showDetail(item: AppInfoDTO)
}

final class SearchViewController: UIViewController, SearchPresentable {

    weak var listener: SearchPresentableListener?
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "SearchListCell", bundle: nil)
        searchTableView.register(cellNib, forCellReuseIdentifier: SearchListCell.reuseID)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "검색"
        
        subscribeUI()
        bind()
    }
    
    func subscribeUI() {
        searchBar.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(with: self, onNext: { owner, text in
                 owner.listener?.search(term: text ?? String())
            })
            .disposed(by: disposeBag)
        
        searchTableView.rx.modelSelected(AppInfoDTO.self)
            .subscribe(with: self, onNext: { owner, item in
                owner.listener?.showDetail(item: item)
            })
            .disposed(by: disposeBag)
    }
    
    func bind() {
        listener?.searchListObservable
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .observe(on: MainScheduler.instance)
            .bind(to: searchTableView.rx.items(
                cellIdentifier: SearchListCell.reuseID,
                cellType: SearchListCell.self)
            ) { index, element, cell in
                cell.configure(data: element)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: SearchViewControllable {
    func push(viewController: ViewControllable) {
        viewController.uiviewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}
