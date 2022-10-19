// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Dial {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    value: (to - from)/2

    background: Item {
        id: back
        implicitWidth: 184
        implicitHeight: 184

        Repeater {
            model: control.width/10
            Hexagon {
                x: (control.availableWidth - width)/2
                y: (control.availableHeight - height)/2

                implicitWidth: back.width - index * 10
                implicitHeight: 0.85 * implicitWidth

                rotation: (control.angle * 1.07) * (1 - index/10) - 30

                radius: 5
                strokeColor: palette.button
                strokeWidth: 1

                color: Hive.alpha(palette.button, 0.1)
            }
        }
    }

    handle: Item {
        width: control.width
        height: control.height

        rotation: control.angle * 1.07

        Rectangle {
            x: (parent.width - width)/2; y: 3
            width: 3; height: 3; radius: 2
            color: palette.windowText
        }
    }
}
