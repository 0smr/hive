// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Switch {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    indicator: Crystal {
        implicitWidth: 50
        implicitHeight: 25

        x: control.text ?
               (control.mirrored ?
                    control.width - width - control.rightPadding :
                    control.leftPadding) :
               control.leftPadding + (control.availableWidth - width) / 2

        y: control.topPadding + (control.availableHeight - height) / 2

        color: 'transparent'
        radius: 5/_min
        strokeColor: control.visualFocus ? palette.highlight : palette.button
        corners: Qt.vector4d(13, 8, 13, 8)

        Crystal {
            id: ibox
            x: Math.min(Math.max(y, control.visualPosition * parent.width - height/2), parent.width - height - y)
            y: 3

            strokeColor: palette.button
            color: Hive.alpha(palette.button, control.down ? 0.3 : 0.4)

            width: height
            height: control.indicator.height - 6

            radius: 5/_min
            corners: Qt.vector4d(10, 5, 10, 5)

            Behavior on x {
                enabled: !control.down
                NumberAnimation{ duration: 200 }
            }
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator &&  control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: palette.windowText
    }
}
