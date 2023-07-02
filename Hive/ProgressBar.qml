// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15  as T
import Hive 1.0

T.ProgressBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property int orientation: Qt.Horizontal
    padding: 2

    QtObject {
        id: orient
        property bool vertical: control.orientation == Qt.Vertical
        property bool horizontal: control.orientation == Qt.Horizontal
    }

    contentItem: Item {
        Crystal {
            property real _right: Math.max(0, width - parent.width + 8)

            x: 1; y: 1
            width: control.position * (parent.width - 2)
            height: parent.height - 2

            radius: .2
            strokeColor: palette.button
            color: Hive.alpha(palette.button, 0.4)
            corners: Qt.vector4d(6, _right, _right, 6)
        }
    }

    background:  Crystal {
        implicitWidth: orient.horizontal ? 200 : 18
        implicitHeight: orient.vertical ? 200 : 18

        strokeColor: palette.button
        color: 'transparent'
        radius: .2
    }
}
