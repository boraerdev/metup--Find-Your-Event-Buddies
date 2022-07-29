//
//  ExploreViewModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation
import Combine

class ExploreViewModel: ObservableObject {
    
    @Published var searched: String = ""
    @Published var searchedList: [Post] = []
    @Published var vm = HomeViewModel()
    var cancellable = Set<AnyCancellable>()
    
    init(){
        self.fetchData()
    }
    
    func fetchData(){
        $searched
            .combineLatest(vm.$allPost)
            .map { searched, allPosts -> [Post] in
                
                if searched == "" {
                    return self.vm.allPost
                } else {
                    let lowercase = searched.lowercased()
                    let filtered = allPosts.filter { post in
                        return post.etkinlikAdresi.lowercased().contains(lowercase) ||
                        post.etkinlikAdi.lowercased().contains(lowercase) ||
                        post.etkinlikAciklamasi.lowercased().contains(lowercase)
                    }
                    return filtered

                }
            }
            .sink { [weak self] gelen in
                self?.searchedList = gelen
            }
            .store(in: &cancellable)
    }
    
}
