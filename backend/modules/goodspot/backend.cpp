#include <QtQml>
#include <QtQml/QQmlContext>
#include "backend.h"
#include "mytype.h"
#include "spotconnect.h"


void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("goodspot"));

    qmlRegisterType<MyType>     (uri, 1, 0, "MyType");
    qmlRegisterType<SpotConnect>(uri, 1, 0, "SpotConnect");
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}

