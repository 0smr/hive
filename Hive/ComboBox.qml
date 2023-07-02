// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Templates 2.15  as T

T.ComboBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)
    leftPadding: 5 + (!control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    rightPadding: 5 + (control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    spacing: 5

    delegate: ItemDelegate {
        width: ListView.view.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        palette.text: control.palette.buttonText
        palette.highlightedText: control.palette.highlightedText
        hoverEnabled: control.hoverEnabled

        background: Crystal {
            radius: 5/_min
            color: Hive.alpha(Qt.lighter(palette.button, control.palette.window.hslLightness/2 + .75),
                              control.currentIndex === index || hovered ? 0.6 : 0.4)
            strokeWidth: visualFocus ? 2 : 1
            strokeColor: palette.button

            Behavior on opacity { NumberAnimation { duration: 100 } }
        }
    }

    indicator: Text {
        x: control.mirrored ? control.padding : control.availableWidth + control.spacing + 4
        y: control.topPadding + (control.availableHeight - height)/2
        width: implicitWidth
        color: palette.buttonText
        text: "\u2261"
        font.pixelSize: 12
        font.bold: true
        opacity: enabled ? 1 : 0.3
    }

    contentItem: T.TextField {
        leftPadding: !control.mirrored ? 12 : 13
        rightPadding: control.mirrored ? 12 : 13
        topInset: 5; bottomInset: 5
        text: control.editable ? control.editText : control.displayText

        enabled: control.editable
        autoScroll: control.editable
        readOnly: !control.editable
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        selectByMouse: control.selectTextByMouse

        font: control.font
        color: palette.windowText
        selectionColor: palette.highlight
        selectedTextColor: palette.highlightedText
        verticalAlignment: Text.AlignVCenter

        background: Rectangle {
            visible: control.enabled && control.editable && !control.flat
            color: palette.window
            opacity: parent.activeFocus && control.editable ? 0.9 : 0.6
            radius: 2
            Behavior on opacity { NumberAnimation { duration: 100 } }
        }
    }

    background: Crystal {
        implicitWidth: 140
        implicitHeight: 40

        visible: !control.flat || control.down
        radius: 5/_min
        color: Hive.alpha(palette.button, 0.2)
        strokeColor: palette.button

        opacity: control.down ? 0.8 : 1.0

        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    popup: T.Popup {
        id: popup
        y: control.height
        topPadding: 2
        width: control.width
        height: Math.min(contentItem.implicitHeight,
                         control.Window.height,
                         control.mapToItem(Window.window,0,0).y - 5) + 2

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            spacing: 2
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0
            T.ScrollIndicator.vertical: ScrollIndicator{}
        }
    }
}
