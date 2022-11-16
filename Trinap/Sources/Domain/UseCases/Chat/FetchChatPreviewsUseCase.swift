//
//  FetchChatPreviewsUseCase.swift
//  Trinap
//
//  Created by 김세영 on 2022/11/16.
//  Copyright © 2022 Trinap. All rights reserved.
//

import RxSwift

protocol FetchChatPreviewsUseCase {
    
    // MARK: - Methods
    func execute() -> Observable<[ChatPreview]>
}
