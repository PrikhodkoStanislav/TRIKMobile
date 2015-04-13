TEMPLATE = app

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp \
    connector.cpp \
    connectorhandler.cpp \
    blocks/abstractblock.cpp \
    qmlsignalhandler.cpp \
    scriptgenerator.cpp \
    blocks/sayblock.cpp \
    blocks/accelerometerBlocks/accelerometerxblock.cpp \
    blocks/backgroundColorsBlocks/greenblock.cpp \
    blocks/conditionalBlocks/dowhileblock.cpp \
    blocks/conditionalBlocks/forblock.cpp \
    blocks/conditionalBlocks/ifblock.cpp \
    blocks/conditionalBlocks/ifelseblock.cpp \
    blocks/conditionalBlocks/infiniteblock.cpp \
    blocks/conditionalBlocks/negationblock.cpp \
    blocks/conditionalBlocks/whiledoblock.cpp \
    blocks/drawingBlocks/sadsmileblock.cpp \
    blocks/drawingBlocks/smileblock.cpp \
    blocks/enginesBlocks/backwardblock.cpp \
    blocks/enginesBlocks/forwardblock.cpp \
    blocks/enginesBlocks/stopblock.cpp \
    blocks/waitBlocks/timerblock.cpp \
    blocks/functionsBlocks/absblock.cpp \
    blocks/gamepadBlocks/gamepadbuttonblock.cpp \
    blocks/gyroscopeBlocks/gyroscopexblock.cpp \
    blocks/luaPrintingBlocks/additionblock.cpp \
    blocks/messagesBlocks/sendmessageblock.cpp \
    blocks/portsBlocks/gamepadbutton1portblock.cpp \
    blocks/sensorsBlocks/upblock.cpp \
    blocks/signsBlocks/equalsblock.cpp \
    blocks/subprogramsBlocks/implementationblock.cpp \
    blocks/switchBlocks/headblock.cpp \
    blocks/threadsBlocks/callblock.cpp \
    blocks/typesBlocks/intblock.cpp \
    blocks/variablesBlocks/variabledeclarationblock.cpp \
    blocks/videosensorsBlocks/detectlineblock.cpp \
    blocks/ledColorsBlocks/ledgreenblock.cpp

HEADERS += \
    connector.h \
    connectorhandler.h \
    blocks/abstractblock.h \
    qmlsignalhandler.h \
    scriptgenerator.h \
    blocks/sayblock.h \
    blocks/accelerometerBlocks/accelerometerxblock.h \
    blocks/backgroundColorsBlocks/greenblock.h \
    blocks/conditionalBlocks/dowhileblock.h \
    blocks/conditionalBlocks/forblock.h \
    blocks/conditionalBlocks/ifblock.h \
    blocks/conditionalBlocks/ifelseblock.h \
    blocks/conditionalBlocks/infiniteblock.h \
    blocks/conditionalBlocks/negationblock.h \
    blocks/conditionalBlocks/whiledoblock.h \
    blocks/drawingBlocks/sadsmileblock.h \
    blocks/drawingBlocks/smileblock.h \
    blocks/enginesBlocks/backwardblock.h \
    blocks/enginesBlocks/forwardblock.h \
    blocks/enginesBlocks/stopblock.h \
    blocks/waitBlocks/timerblock.h \
    blocks/functionsBlocks/absblock.h \
    blocks/gamepadBlocks/gamepadbuttonblock.h \
    blocks/gyroscopeBlocks/gyroscopexblock.h \
    blocks/luaPrintingBlocks/additionblock.h \
    blocks/messagesBlocks/sendmessageblock.h \
    blocks/portsBlocks/gamepadbutton1portblock.h \
    blocks/sensorsBlocks/upblock.h \
    blocks/signsBlocks/equalsblock.h \
    blocks/subprogramsBlocks/implementationblock.h \
    blocks/switchBlocks/headblock.h \
    blocks/threadsBlocks/callblock.h \
    blocks/typesBlocks/intblock.h \
    blocks/variablesBlocks/variabledeclarationblock.h \
    blocks/videosensorsBlocks/detectlineblock.h \
    blocks/ledColorsBlocks/ledgreenblock.h

RESOURCES += qml.qrc \
    templates.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
