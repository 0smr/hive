// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15  as T

T.Frame {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 6

    background: Crystal {
        color: 'transparent'
        radius: 10/_min
        strokeColor: palette.button
        corners: {
            const _x = 25 + control.padding, _y = 15 + control.padding;
            return Qt.vector4d(_x , _y, _x , _y);
        }
    }
}
