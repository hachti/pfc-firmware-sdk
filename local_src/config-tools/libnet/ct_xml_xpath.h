// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2018 WAGO Kontakttechnik GmbH & Co. KG

#ifndef __CT_XML_XPATH_H__
#define __CT_XML_XPATH_H__

#include <libxml/tree.h>
#include <glib.h>
#include <stdbool.h>

typedef struct xpathSession xpathSession_t;

int ct_xml_xpath_start_session(xmlDocPtr doc, xpathSession_t **session);
void ct_xml_xpath_finish_session(xpathSession_t *session);

int ct_xml_xpath_has_key(xpathSession_t *session, const xmlChar * xpathExpr, bool * const fHasKey);

int ct_xml_xpath_get_value(xpathSession_t *session, const xmlChar * xpathExpr, xmlChar *result, size_t resultLen);
int ct_xml_xpath_dup_value(xpathSession_t *session, const xmlChar *xpathExpr, xmlChar **result);
int ct_xml_xpath_set_value(xpathSession_t *session, const xmlChar * xpathExpr, const xmlChar *newVal);

int ct_xml_xpath_set_multiple_values(xpathSession_t *session, const xmlChar *xpathExpr, const char *value);
int ct_xml_xpath_add_value(xpathSession_t *session, const xmlChar * xpathExpr, const xmlChar *newVal);
int ct_xml_xpath_del_multiple_values(xpathSession_t *session, const xmlChar *xpathExpr);
int ct_xml_xpath_get_multiple_values(xpathSession_t *session, const xmlChar *xpathExpr, GString *result, const char *delim);
#endif
