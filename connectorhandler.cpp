#include "connectorhandler.h"

#include <QtNetwork/QHostAddress>
#include <QtCore/QFileInfo>
#include <QtCore/QDebug>

ConnectorHandler::ConnectorHandler(int port)
	:mPort(port)
{
	QObject::connect(&mSocket, SIGNAL(readyRead()), this, SLOT(onIncomingData()), Qt::DirectConnection);
}

bool ConnectorHandler::connect(const QHostAddress &serverAddress)
{
	if (mSocket.state() == QTcpSocket::ConnectedState || mSocket.state() == QTcpSocket::ConnectingState)
	{
		return true;
	}
	mSocket.connectToHost(serverAddress, static_cast<quint16>(mPort));
	const bool result = mSocket.waitForConnected(3000);

	if (!result)
	{
		qDebug() << mSocket.errorString();
	}

	mBuffer.clear();
	mExpectedBytes = 0;
	return result;
}
bool ConnectorHandler::isConnected()
{
	return mSocket.state() == QTcpSocket::ConnectedState;
}
void ConnectorHandler::disconnect()
{
	if (mSocket.state() == QTcpSocket::ConnectedState)
	{
		mSocket.disconnectFromHost();
		mSocket.waitForDisconnected(3000);
	}
}
void ConnectorHandler::send(const QString &data)
{
	QByteArray dataByteArray = data.toUtf8();
	dataByteArray = QByteArray::number(dataByteArray.size()) + ':' + dataByteArray;
	mSocket.write(dataByteArray);

	if (!mSocket.waitForBytesWritten(3000))
	{
		qDebug() << "Unable to send data" << data << "to" << mSocket.peerAddress();
	}
}
void ConnectorHandler::onIncomingData()
{
	if (!mSocket.isValid())
	{
		return;
	}
	const QByteArray &data = mSocket.readAll();
	mBuffer.append(data);
	while (!mBuffer.isEmpty())
	{
		if (mExpectedBytes == 0)
		{
			// Determining the length of a message.
			const int delimiterIndex = mBuffer.indexOf(':');
			if (delimiterIndex == -1)
			{
				// We did not receive full message length yet.
				return;
			}
			else
			{
				const QByteArray length = mBuffer.left(delimiterIndex);
				mBuffer = mBuffer.mid(delimiterIndex + 1);
				bool ok = false;
				mExpectedBytes = length.toInt(&ok);
				if (!ok)
				{
					qDebug() << "Malformed message, can not determine message length from this:" << length;
					mExpectedBytes = 0;
				}
			}
		}
		else
		{
			if (mBuffer.size() >= mExpectedBytes)
			{
				const QByteArray message = mBuffer.left(mExpectedBytes);
				mBuffer = mBuffer.mid(mExpectedBytes);
				emit messageReceived(message);
				mExpectedBytes = 0;
			}
			else
			{
				// We don't have all message yet.
				return;
			}
		}
	}
}
