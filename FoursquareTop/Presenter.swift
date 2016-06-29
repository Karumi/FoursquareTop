
import Foundation

public protocol Presenter {
    func viewDidLoad()
    func viewDidAppear()
    func viewWillAppear()
    func viewDidDisppear()
    func viewWillDisappear()
}

extension Presenter {
    func viewDidLoad() {}
    func viewDidAppear() {}
    func viewWillAppear() {}
    func viewDidDisppear() {}
    func viewWillDisappear() {}
}
