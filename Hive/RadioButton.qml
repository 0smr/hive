// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.RadioButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    indicator: Hexagon {
        implicitWidth:  28
        implicitHeight: 0.85 * implicitWidth

        x: control.text ?
               (control.mirrored ?
                    control.width - width - control.rightPadding :
                    control.leftPadding) :
               control.leftPadding + (control.availableWidth - width) / 2

        y: control.topPadding + (control.availableHeight - height) / 2

        radius: 2
        color: 'transparent'
        strokeWidth: 1
        strokeColor: control.visualFocus ? palette.highlight : palette.button

        Hexagon {
            id: ibox
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            width: control.checked ? parent.width - 8 : 0
            height: 0.85 * width

            strokeWidth: 1
            strokeColor: palette.button
            color: Hive.alpha(palette.button, control.down ? 0.3 : 0.4)

            radius: 2

            Behavior on width {
                NumberAnimation { duration: 100 }
            }
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        color: palette.windowText
        text: control.text
        font: control.font
    }
}
