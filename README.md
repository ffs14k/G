# G
Table / Collection DataSource generic wrapper

- bind model to cells
```
struct TitleCellModel {
    let title: String
    let color: UIColor
    let action: (IndexPath) -> Void
}
```

```
import UIKit
import G

final class TitleTableCell: UITableViewCell {
    var gtcModel: GTCellModel<TitleTableCell>?
    
    @objc final func tapAction() {
        gtcModel?.model.action(gtcModel!.indexPath)
    }
}


// MARK: - GTCSetupable
extension TitleTableCell: GTCSetupable {
    
    typealias Model = TitleCellModel
    
    static func createSelf() -> TitleTableCell {
        return TitleTableCell()
    }
    
    // setup(gtcModel: GTCellModel<Self>) call this method by default. See `GTCSetupable`
    func setup(model: TitleCellModel) {
    }
    
    func size(in rect: CGRect, model: TitleCellModel) -> CGSize {
        return CGSize(width: rect.width, height: 70)
    }   
}
```

- grid management, ready to use animations, custom animations available

![see example project](https://github.com/ffs14k/G/tree/master/GExample)
```swift
let cells = self.createCells(text: "Created at index", indexes: Array(0..<10))
let section = GridSection(header: nil, items: cells, footer: nil)
self.view?.gridManager.reloadData(section: section, animator: .fade())
```

![demo1](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExdWIwcDQxa2FoZjZpM2hlZzU3YTRsMmttajUzb3l3NWM0azZ3eWpzeSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/0K9u2nRzM48CVjg2da/giphy.gif)
![demo1](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMmltYWtmYzBlemR5cXQ3M3UzN3JyaHlsbXQ1b2dvMmI0ZzBjcGVtcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/bfg0kgoe8C2scjW40C/giphy.gif)
![demo1](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcjRxenhvZXJ5Mnc3bDF5YjZ1eGx2Znc1NGdkNnk1ZGs1NnloMnAweSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/vfEmYmH2FOhTTuelHd/giphy.gif)
