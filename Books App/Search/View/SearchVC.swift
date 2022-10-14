//
//  SearchVC.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    var pickerView = UIPickerView()
    @IBOutlet weak var searchTableView: UITableView!
    private let tableViewKey = "SearchTableViewCell"
    var searchPresenterObject: ViewToPresenterSearchProtocol?
    var books: [Books] = []
    var filteredBooks: [Books] = []
    var categoryBaseBooks: [Books] = []
    var isCategorySearchActive: Bool = false
    var categories = ["All", "Romance", "Military", "Fantasy", "Paranormal", "Romantic Comedy", "New Adult"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchActivityIndicator.stopAnimating()
        self.title = "Arama"
        SearchRouter.createModule(ref: self)
        searchPresenterObject?.fetchData()
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        setupUI()
    }
    
    func setupUI() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        registerTableView()
        searchTextField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
    }
    
    func registerTableView() {
        searchTableView.register(.init(nibName: tableViewKey, bundle: nil), forCellReuseIdentifier: tableViewKey)
    }
    
    func getFilteredItems() -> [Books] {
        let filteredList = books.filter { !(($0.genres ?? []).filter { ($0.name ?? "").localizedCaseInsensitiveContains(categoryTextField.text ?? "") }.isEmpty) }
        return filteredList
    }
    
    func getTextBaseItems() {
        if let searchText = searchTextField.text, !searchText.isEmpty {
            if isCategorySearchActive {
                filteredBooks = categoryBaseBooks.filter { ($0.name ?? "").localizedCaseInsensitiveContains(searchText) }
            }else {
                filteredBooks = books.filter { ($0.name ?? "").localizedCaseInsensitiveContains(searchText) }
            }
        }else {
            if isCategorySearchActive {
                filteredBooks = categoryBaseBooks
            }else {
                filteredBooks = []
            }
        }
        searchTableView.reloadData()
    }
    
    @objc func didChangeText() {
        getTextBaseItems()
    }
}


extension SearchVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            isCategorySearchActive = false
            categoryTextField.text = ""
            categoryBaseBooks = []
        }else {
            isCategorySearchActive = true
            categoryTextField.text = categories[row]
            filteredBooks = getFilteredItems()
            categoryBaseBooks = filteredBooks
            searchTableView.reloadData()
        }
        getTextBaseItems()
    }
}

extension SearchVC: UITableViewDelegate {
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func makeTransformToDetails(_ books: [Books]) -> [DetailsEntity] {
        return books.map {
            .init(id: $0.id!, imageView: $0.artworkUrl100!, bookTitle: $0.name!, authorName: $0.artistName!, bookDate: $0.releaseDate!) }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = makeTransformToDetails(filteredBooks)[indexPath.row]
        let details = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        details.result = cellModel
        navigationController?.pushViewController(details, animated: true)
    }
}

extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = filteredBooks[indexPath.row]
        let cell = searchTableView.dequeueReusableCell(withIdentifier: tableViewKey) as! SearchTableViewCell
        
        DispatchQueue.global().async { [weak self] in
            let data = try! Data(contentsOf: URL(string: cellModel.artworkUrl100!)!)
            DispatchQueue.main.async { [weak self] in
                guard let _ = self else { return }
                cell.bookImageView.image = UIImage(data: data)
            }
        }
        cell.bookNameLabel.text = cellModel.name
        cell.authorNameLabel.text = cellModel.artistName
        cell.dateLabel.text = cellModel.releaseDate
        return cell
    }
}

extension SearchVC: PresenterToViewSearchProtocol {
    
    func updateData(with books: [Books]) {
        DispatchQueue.main.async {
            self.books = books
            self.searchTableView.reloadData()
        }
    }
    
    func updateError(with error: String) {
        DispatchQueue.main.async {
            self.books = []
            self.searchTableView.reloadData()
        }
    }
    
    
}
