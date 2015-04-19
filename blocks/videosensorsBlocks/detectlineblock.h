#pragma once

#include "blocks/abstractblock.h"

class DetectLineBlock : public AbstractBlock
{
	Q_OBJECT
public:
	explicit DetectLineBlock(QObject *parent = 0);
	DetectLineBlock(QSharedPointer<AbstractBlock> n, QObject *parent = 0);
	virtual ~DetectLineBlock();

	virtual QString toString(int indent = 0) const;
};
