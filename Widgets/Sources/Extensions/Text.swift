import SwiftUI

extension Text {

    init(mempoolFee value: Double) {
        let precision = abs(value) < 0.95 ? 1 : 0
        self.init(value, format: .number.precision(.fractionLength(precision)))
    }

}
