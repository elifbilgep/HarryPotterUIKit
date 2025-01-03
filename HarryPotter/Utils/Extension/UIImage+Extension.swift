//
//  UIImage+Extension.swift
//  HarryPotter
//
//  Created by Elif Parlak on 29.12.2024.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        self.image = nil
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self,
                  let data,
                  error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
