//
//  DefaultFetchReservationsUseCase.swift
//  Trinap
//
//  Created by kimchansoo on 2022/11/17.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

import RxSwift

final class DefaultFetchReservationsUseCase: FetchReservationsUseCase {
    
    // MARK: Properties
    private let reservationRepository: ReservationRepository
    
    // MARK: Initializer
    init(reservationRepository: ReservationRepository) {
        self.reservationRepository = reservationRepository
    }
    
    // MARK: Methods
    func fetchCustomerReservations() -> Observable<[Reservation]> {
        return reservationRepository
            .fetchCustomerReservations()
    }
    
    func fetchPhotographerReservations() -> Observable<[Reservation]> {
        return reservationRepository
            .fetchPhotographerReservations()
    }
}