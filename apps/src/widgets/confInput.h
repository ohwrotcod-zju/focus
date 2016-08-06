/*
 *  confInput.h
 *  2DX-Mod
 *
 *  Created by Bryant Gipson on 2/22/06.
 *  Copyright 2006 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef CONFINPUT_H
#define CONFINPUT_H

#include <QWidget>
#include <QEvent>
#include <QWhatsThis>
#include <QWhatsThisClickedEvent>
#include <QGridLayout>
#include <QLabel>
#include <QList>
#include <QLineEdit>
#include <QButtonGroup>
#include <QRadioButton>
#include <QPushButton>
#include <QCheckBox>
#include <QComboBox>
#include <QSpacerItem>
#include <QPalette>
#include <QProcess>
#include <QIcon>
#include <QColor>
#include <float.h>

#include "confData.h"
#include "graphicalButton.h"
#include "browser_widget.h"
#include "combo_input_widget.h"
#include "edit_set_widget.h"
#include "yesno_widget.h"

class confInput : public QWidget {
    Q_OBJECT

public:
    confInput(confData *conf, confElement *e, QWidget *parent = NULL);
    int userLevel();

public slots:
    void saveValue(const QString& value);
    void load();  
    void setReadOnlyState(int state);
    void show();

signals:
    void shown();
    void shouldLoadValue(const QString& value);

private:

    QWidget* setupDirWidget(bool isDir = false);
    QWidget* setupEditWidget();
    QWidget* setupBoolWidget();
    QWidget* setupDropDownWidget();

    confData *data;
    confElement *element;

    QGridLayout* layout_;
    graphicalButton* lockButton_;
    QWidget* inputWidget_;
};

#endif
