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

    indicator: Rectangle {
        implicitWidth: 50
        implicitHeight: 25

        x: control.text ?
               (control.mirrored ?
                    control.width - width - control.rightPadding :
                    control.leftPadding) :
               control.leftPadding + (control.availableWidth - width) / 2

        y: control.topPadding + (control.availableHeight - height) / 2

        color: 'transparent'
        radius: 5
        border.color: control.visualFocus ? palette.highlight : palette.button

        Rectangle {
            id: ibox
            x: Math.min(Math.max(y, control.visualPosition * parent.width - height/2), parent.width - height - y)
            y: 3

            border.color: palette.button
            color: Hive.alpha(palette.button, control.down ? 0.3 : 0.4)

            width: {
                let pos = Math.abs(0.5 - (x-y)/(parent.implicitWidth - height - 2 * y));
                height + 8 - pos * 8 * 2
            }
            height: control.indicator.height - 6

            radius: 3

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
