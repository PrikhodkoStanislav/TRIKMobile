#pragma once

#include <QtNetwork/QTcpSocket>
#include <QtCore/QTimer>

#include "connectorhandler.h"

/// Class that handles connection to robot and sends commands to it.
class Connector : public QObject
{
	Q_OBJECT
public:
	/// Constructor.
	/// @param serverIpSettingsKey - where to find server ip setting in a registry.
	explicit Connector(const QString &serverIpSettingsKey);
	~Connector();

	/// Changes server ip.
	void changeServerIP(const QString &newServerIP);

	/// Reads generated program from a file and uploads it to a robot using "file" command.
	bool uploadProgram(const QString &programName);

	/// Uploads program script to a robot.
	bool uploadProgram(const QString &programName, const QString programScript);

	/// Sends a command to run previously uploaded file in a robot.
	bool runProgram(const QString &programName);

	/// Sends a script to be executed directly, without a need for a file.
	/// @param asScript - if true, the state of a robot will be reset before command evalutation.
	bool runDirectCommand(const QString &directCommand, bool asScript = false);

	/// Sends a command to remotely abort script execution and stop robot.
	bool stopRobot();

	void requestData(const QString &sensor);

	/// Establishes connection and initializes socket.
	/// If connection fails, leaves socket in invalid state.
	void connect();

	/// Disconnects from robot.
	void disconnect();

signals:
	/// Emitted when tcp socket with robot was opened or failed to open.
	/// @param errorString contains fail reason in that case.
	void connected(bool result, const QString &errorString);

	/// Emitted each time when connection with robot was aborted.
	void disconnected();

	void newScalarSensorData(const QString &port, int data);
	void newVectorSensorData(const QString &port, QVector<int> const &data);

private slots:
	void processControlMessage(const QString &message);
	void processTelemetryMessage(const QString &message);

	void versionTimeOut();

private:
	/// Sends message using message length protocol (message is in form "<data length in bytes>:<data>").
	void send(const QString &data, QTcpSocket &socket);

	/// Sends version request and starts version timer.
	void versionRequest();

	/// Socket that holds connection.
	QTcpSocket mSocket;

	QString mCurrentIP;

	ConnectorHandler mControlConnection;
	ConnectorHandler mTelemetryConnection;

	/// Is connected to the robot?
	bool mIsConnected;

	/// Timer for version request.
	QTimer mVersionTimer;

	/// Read all data from given file.
	/// @param fileName - name of the file to be read.
	/// @returns All contents of a file.
	static QString readAll(QString const &fileName);

	QString mServerIpSettingsKey;
};
