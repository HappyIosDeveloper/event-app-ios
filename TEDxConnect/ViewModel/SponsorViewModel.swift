//
//  SponsorViewModel.swift
//  TEDxConnect
//
//  Created by Tadeh Alexani on 10/3/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

class SponsorViewModel: ObservableObject {
  
  var repo = SponsorRepository()
  @Published var repositories = [SponsorWithType]()
  
  @Published var errorMessage: String = ""
  @Published var statusView: StatusView = .none
  
  func setup(withEventId eventId: Int) {
    self.statusView = .loading
    repo.get(withEventId: eventId) { repositories, exception  in
      
      if let error = exception {
        self.statusView = .error
        self.errorMessage = error.message
        return
      }
      
      guard let repositories = repositories else {
        return
      }
      self.statusView = .complete
      self.repositories = repositories
    }
  }
  
}
