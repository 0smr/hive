// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.TextArea {
    id: control

    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6
    leftPadding: padding + 4

    color: palette.windowText
    placeholderTextColor: palette.mid
    selectionColor: palette.highlight
    selectedTextColor: palette.highlightedText

    Text {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width    - (control.leftPadding  + control.rightPadding)
        height: control.height  - (control.topPadding   + control.bottomPadding)

        text: control.placeholderText
        font: control.font

        color: control.placeholderTextColor

        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    background: Crystal {
        implicitWidth: 200
        implicitHeight: 40

        property real _ecr: control.activeFocus ? 10 : 20

        opacity: control.activeFocus ? 1 : 0.8
        color: Qt.lighter(palette.window, palette.window.hslLightness * 2)

        strokeColor: palette.button
        strokeWidth: 1
        radius: 5/_min

        corners: Qt.vector4d(_ecr, 10, _ecr, 10)

        Behavior on opacity { NumberAnimation { duration: 100 } }
        Behavior on _ecr { NumberAnimation { duration: 100 } }
    }
}
