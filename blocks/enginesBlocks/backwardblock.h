#pragma once

#include "blocks/abstractblock.h"

class BackwardBlock : public AbstractBlock
{
	Q_OBJECT
public:
	explicit BackwardBlock(QObject *parent = 0);
	BackwardBlock(QSharedPointer<AbstractBlock> n, QObject *parent = 0);
	virtual ~BackwardBlock();

	virtual QString toString(int indent = 0) const;

	int power() const;
	void setPower(int power);
	QString port() const;
	void setPort(const QString &port);

private:
	int mPower;
	QString mPort;
};