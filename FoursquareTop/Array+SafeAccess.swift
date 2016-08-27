
// See: http://stackoverflow.com/a/30593673/802118
extension Array {
    subscript (optional index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}