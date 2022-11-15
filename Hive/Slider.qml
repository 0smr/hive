// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)
    padding: 6

    handle: Hexagon {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))

        implicitWidth: 20
        implicitHeight: implicitWidth * 0.85106

        color: Hive.alpha(palette.button, 0.4)
        radius: 2

        strokeColor: palette.button
        strokeWidth: visualFocus ? width : 1

        Behavior on strokeWidth { NumberAnimation {} }
    }

    background: Item {
        x: (control.width  - width) / 2
        y: (control.height - height) / 2

        implicitWidth: !control.horizontal ?  1 : 200
        implicitHeight: control.horizontal ? 1 : 200

        width: !control.horizontal ? implicitWidth : control.availableWidth
        height: control.horizontal ? implicitHeight : control.availableHeight

        Rectangle {
            width: control.handle.x - 5
            color: palette.button
            height: parent.height
        }

        Rectangle {
            x: parent.width - width + 1
            y: 0

            width: parent.width - control.handle.x - 12
            color: palette.button
            height: parent.height
        }
    }
}
