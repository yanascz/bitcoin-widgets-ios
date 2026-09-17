import SwiftUI

extension Text {

    init(mempoolFee value: Double) {
        let precision = abs(value) < 1 ? 1 : 0
        self.init(value, format: .number.precision(.fractionLength(precision)))
    }

}
