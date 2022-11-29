//
//  PhotographerListViewModel.swift
//  Trinap
//
//  Created by kimchansoo on 2022/11/23.
//  Copyright © 2022 Trinap. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift

final class PhotographerListViewModel: ViewModelType {
    
    struct Input {
        let searchTrigger: Observable<Void>
        var tagType: Observable<TagType>
//        var selectedPreview: Observable<PhotographerPreview>
    }

    struct Output {
        var previews: Driver<[PhotographerPreview]>
    }

    // MARK: - Properties
    let disposeBag = DisposeBag()
    private weak var coordinator: MainCoordinator?
    private let previewsUseCase: FetchPhotographerPreviewsUseCase
    
    let defaultString = "추억을 만들 장소를 선택해주세요."
    
    var searchText = BehaviorRelay<String>(value: "")
    var coordinate = BehaviorRelay<Coordinate?>(value: nil)

    // MARK: - Initializer
    init(
        previewsUseCase: FetchPhotographerPreviewsUseCase,
        coordinator: MainCoordinator
    ) {
        self.previewsUseCase = previewsUseCase
        self.coordinator = coordinator
    }

    // MARK: - Methods
    func transform(input: Input) -> Output {        
        input.searchTrigger
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                if self.searchText.value == self.defaultString {
                    self.searchText.accept("")
                }
                
                self.coordinator?.showSearchViewController(
                    searchText: self.searchText,
                    coordinate: self.coordinate
                )
            })
            .disposed(by: disposeBag)
        
        let previews = Observable.combineLatest(
            self.coordinate,
            input.tagType.startWith(.all)
//                .debounce(.seconds(1), scheduler: MainScheduler.instance)
        )
            .withUnretained(self)
            .flatMap { (owner, val) -> Observable<[PhotographerPreview]> in
                let (coordinate, type) = val
                return owner.previewsUseCase.fetch(coordinate: coordinate, type: type)
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(previews: previews)
    }
}

extension PhotographerListViewModel {
    
    func showDetailPhotographer(userId: String) {
        //TODO: 여기서 userId만 넘겨줘도 괜찮을까요?
        coordinator?.showDetailPhotographerViewController(userId: userId)
    }
}
