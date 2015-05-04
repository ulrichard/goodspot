import QtQuick 2.0
import Ubuntu.Components 1.1
import Spotconnect 1.0
import "database.js" as Storage

/*!
    \brief MainView with Tabs element.
           First Tab has a single Label and
           second Tab has a single ToolbarAction.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "goodspot.ulrichard"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(76)

    Page {
        title: i18n.tr("App with backend")

        MyType {
            id: myType

            Component.onCompleted: {
                myType.helloWorld = i18n.tr("Hello world..")
            }
        }

        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Label {
                id: label
                objectName: "label"

                text: myType.helloWorld
            }

            Button {
                objectName: "button"
                width: parent.width

                text: i18n.tr("Tap me!")

                onClicked: {
                    myType.helloWorld = i18n.tr("..from Cpp Backend")
                }
            }
        }
    }

	ScannerPage {
        id: scannerPage
        orientationLock: PageOrientation.LockPortrait
    }
    MainPage {
        id: mainPage
        btAddress: "00:80:e1:fb:db:97"
        orientationLock: PageOrientation.LockPortrait
    }

    Component.onCompleted: {
        // Initialize the database
        Storage.initialize();
        // Sets a value in the database
        //Storage.setSetting("mySetting","myValue");
        // Sets the textDisplay element's text to the value we just set
        mainPage.btAddress = Storage.getSetting("btAddress");
    }

    function saveAddress(){
        Storage.setSetting("btAddress", mainPage.btAddress);
    }



    ToolBarLayout {
        id: commonTools
        visible: true
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: qsTr("Bluetooth Discovery")
                onClicked: scannerPage.startScan();
            }
        }
    }
}

