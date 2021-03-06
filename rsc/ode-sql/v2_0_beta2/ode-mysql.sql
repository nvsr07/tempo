-- file:/Users/niko/projects/tempo/rsc/scripts/../../db-schema/mysql/workflow.deployment.sql
CREATE TABLE TEMPO_ITEM (id BIGINT NOT NULL, content_type VARCHAR(255), lastmodified DATETIME, payload BLOB, uri VARCHAR(255), PRIMARY KEY (id)) TYPE = innodb;
-- file:/Users/niko/projects/tempo/rsc/scripts/../../db-schema/mysql/workflow.tms.sql
CREATE TABLE tempo_acl (id BIGINT NOT NULL, action VARCHAR(255), DTYPE VARCHAR(255), PRIMARY KEY (id)) TYPE = innodb;
CREATE TABLE tempo_acl_map (TASK_ID BIGINT, ELEMENT_ID BIGINT) TYPE = innodb;
CREATE TABLE tempo_attachment (id BIGINT NOT NULL, payload_url VARCHAR(255), METADATA_ID BIGINT, PRIMARY KEY (id)) TYPE = innodb;
CREATE TABLE tempo_attachment_map (PATASK_ID BIGINT, ELEMENT_ID BIGINT) TYPE = innodb;
CREATE TABLE tempo_attachment_meta (id BIGINT NOT NULL, creation_date DATETIME, description VARCHAR(255), file_name VARCHAR(255), mime_type VARCHAR(255), title VARCHAR(255), widget VARCHAR(255), PRIMARY KEY (id)) TYPE = innodb;
CREATE TABLE tempo_notification (ID BIGINT NOT NULL, failure_code VARCHAR(255), failure_reason VARCHAR(255), input_xml TEXT, instanceId VARCHAR(255), priority INTEGER, process_id VARCHAR(255), state SMALLINT, PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE tempo_pa (ID BIGINT NOT NULL, complete_soap_action VARCHAR(255), deadline DATETIME, failure_code VARCHAR(255), failure_reason VARCHAR(255), input_xml TEXT, instance_id VARCHAR(255), is_chained_before BIT, output_xml TEXT, previous_task_id VARCHAR(255), priority INTEGER, process_id VARCHAR(255), state SMALLINT, PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE tempo_pipa (id BIGINT NOT NULL, init_message VARCHAR(255), init_soap VARCHAR(255), process_endpoint VARCHAR(255), PRIMARY KEY (id)) TYPE = innodb;
CREATE TABLE tempo_role (TASK_ID BIGINT, element VARCHAR(255), ACL_ID BIGINT) TYPE = innodb;
CREATE TABLE tempo_task (id BIGINT NOT NULL, creation_date DATETIME, description VARCHAR(255), form_url VARCHAR(255), taskid VARCHAR(255), internal_id INTEGER, PRIMARY KEY (id)) TYPE = innodb;
CREATE TABLE tempo_user (TASK_ID BIGINT, element VARCHAR(255), ACL_ID BIGINT) TYPE = innodb;
CREATE INDEX I_TMPO_CL_DTYPE ON tempo_acl (DTYPE);
CREATE INDEX I_TMP__MP_ELEMENT ON tempo_acl_map (ELEMENT_ID);
CREATE INDEX I_TMP__MP_TASK_ID ON tempo_acl_map (TASK_ID);
CREATE INDEX I_TMP_MNT_METADATA ON tempo_attachment (METADATA_ID);
CREATE INDEX I_TMP__MP_ELEMENT1 ON tempo_attachment_map (ELEMENT_ID);
CREATE INDEX I_TMP__MP_PATASK_ID ON tempo_attachment_map (PATASK_ID);
CREATE INDEX I_TMP_ROL_ACL_ID ON tempo_role (ACL_ID);
CREATE INDEX I_TMP_ROL_TASK_ID ON tempo_role (TASK_ID);
CREATE INDEX I_TMP_USR_ACL_ID ON tempo_user (ACL_ID);
CREATE INDEX I_TMP_USR_TASK_ID ON tempo_user (TASK_ID);
-- file:/Users/niko/projects/tempo/rsc/scripts/../../rsc/ode-sql/v2_0_beta2/ode-mysql.sql
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the License is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
-- KIND, either express or implied.  See the License for the
-- specific language governing permissions and limitations
-- under the License.
--
 
CREATE TABLE ODE_ACTIVITY_RECOVERY (ID BIGINT NOT NULL, ACTIONS VARCHAR(255), ACTIVITY_ID BIGINT, CHANNEL VARCHAR(255), DATE_TIME DATETIME, DETAILS TEXT, REASON VARCHAR(255), RETRIES INTEGER, INSTANCE_ID BIGINT, PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE ODE_CORRELATION_SET (CORRELATION_SET_ID BIGINT NOT NULL, CORRELATION_KEY VARCHAR(255), NAME VARCHAR(255), SCOPE_ID BIGINT, PRIMARY KEY (CORRELATION_SET_ID)) TYPE = innodb;
CREATE TABLE ODE_CORRELATOR (CORRELATOR_ID BIGINT NOT NULL, CORRELATOR_KEY VARCHAR(255), PROC_ID BIGINT, PRIMARY KEY (CORRELATOR_ID)) TYPE = innodb;
CREATE TABLE ODE_CORSET_PROP (ID BIGINT NOT NULL, PROP_KEY VARCHAR(255), PROP_VALUE VARCHAR(255), CORRSET_ID BIGINT, PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE ODE_EVENT (EVENT_ID BIGINT NOT NULL, DETAIL VARCHAR(255), DATA BLOB, SCOPE_ID BIGINT, TSTAMP DATETIME, TYPE VARCHAR(255), INSTANCE_ID BIGINT, PROCESS_ID BIGINT, PRIMARY KEY (EVENT_ID)) TYPE = innodb;
CREATE TABLE ODE_FAULT (FAULT_ID BIGINT NOT NULL, ACTIVITY_ID INTEGER, DATA TEXT, MESSAGE VARCHAR(4000), LINE_NUMBER INTEGER, NAME VARCHAR(255), PRIMARY KEY (FAULT_ID)) TYPE = innodb;
CREATE TABLE ODE_MESSAGE (MESSAGE_ID BIGINT NOT NULL, DATA TEXT, HEADER TEXT, TYPE VARCHAR(255), PRIMARY KEY (MESSAGE_ID)) TYPE = innodb;
CREATE TABLE ODE_MESSAGE_EXCHANGE (MESSAGE_EXCHANGE_ID VARCHAR(255) NOT NULL, ACK_TYPE VARCHAR(255), CALLEE VARCHAR(255), CHANNEL VARCHAR(255), CORRELATION_ID VARCHAR(255), CORRELATION_KEYS VARCHAR(255), CORRELATION_STATUS VARCHAR(255), CREATE_TIME DATETIME NOT NULL, DIRECTION INTEGER NOT NULL, EPR TEXT, FAILURE_TYPE VARCHAR(255), FAULT VARCHAR(255), FAULT_EXPLANATION VARCHAR(255), ISTYLE VARCHAR(255), OPERATION VARCHAR(255) NOT NULL, PARTNER_LINK_MODEL_ID INTEGER NOT NULL, PATTERN VARCHAR(255) NOT NULL, PIPED_ID VARCHAR(255), PIPED_PID VARCHAR(255), PORT_TYPE VARCHAR(255), PROPAGATE_TRANS BIT, STATUS VARCHAR(255), TIMEOUT BIGINT, CORRELATOR BIGINT, PLINK BIGINT, PROCESS BIGINT, INSTANCE BIGINT, REQUEST BIGINT, RESPONSE BIGINT, PRIMARY KEY (MESSAGE_EXCHANGE_ID)) TYPE = innodb;
CREATE TABLE ODE_MESSAGE_ROUTE (MESSAGE_ROUTE_ID BIGINT NOT NULL, CORRELATION_KEY VARCHAR(255), GROUP_ID VARCHAR(255), ROUTE_INDEX INTEGER, CORR_ID BIGINT, PROCESS_INSTANCE_ID BIGINT, PRIMARY KEY (MESSAGE_ROUTE_ID)) TYPE = innodb;
CREATE TABLE ODE_MEX_PROP (ID BIGINT NOT NULL, PROP_KEY VARCHAR(255), PROP_VALUE VARCHAR(2000), MEX_ID VARCHAR(255), PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE ODE_PARTNER_LINK (PARTNER_LINK_ID BIGINT NOT NULL, MY_EPR TEXT, MY_ROLE_NAME VARCHAR(255), MY_ROLE_SERVICE_NAME VARCHAR(255), MY_SESSION_ID VARCHAR(255), PARTNER_EPR TEXT, PARTNER_LINK_MODEL_ID INTEGER, PARTNER_LINK_NAME VARCHAR(255), PARTNER_ROLE_NAME VARCHAR(255), PARTNER_SESSION_ID VARCHAR(255), SCOPE_ID BIGINT, PRIMARY KEY (PARTNER_LINK_ID)) TYPE = innodb;
CREATE TABLE ODE_PROCESS (ID BIGINT NOT NULL, GUID VARCHAR(255), PROCESS_ID VARCHAR(255), PROCESS_TYPE VARCHAR(255), VERSION BIGINT, PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE ODE_PROCESS_INSTANCE (ID BIGINT NOT NULL, DATE_CREATED DATETIME, EXEC_STATE_COUNTER INTEGER, EXECUTION_STATE BLOB, LAST_ACTIVE_TIME DATETIME, LAST_RECOVERY_DATE DATETIME, PREVIOUS_STATE SMALLINT, SEQUENCE BIGINT, INSTANCE_STATE SMALLINT, FAULT_ID BIGINT, INSTANTIATING_CORRELATOR_ID BIGINT, PROCESS_ID BIGINT, ROOT_SCOPE_ID BIGINT, PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE ODE_SCOPE (SCOPE_ID BIGINT NOT NULL, MODEL_ID INTEGER, SCOPE_NAME VARCHAR(255), SCOPE_STATE VARCHAR(255), PARENT_SCOPE_ID BIGINT, PROCESS_INSTANCE_ID BIGINT, PRIMARY KEY (SCOPE_ID)) TYPE = innodb;
CREATE TABLE ODE_XML_DATA (XML_DATA_ID BIGINT NOT NULL, DATA TEXT, IS_SIMPLE_TYPE BIT, NAME VARCHAR(255), SCOPE_ID BIGINT, PRIMARY KEY (XML_DATA_ID)) TYPE = innodb;
CREATE TABLE ODE_XML_DATA_PROP (ID BIGINT NOT NULL, PROP_KEY VARCHAR(255), PROP_VALUE VARCHAR(255), XML_DATA_ID BIGINT, PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE OPENJPA_SEQUENCE_TABLE (ID TINYINT NOT NULL, SEQUENCE_VALUE BIGINT, PRIMARY KEY (ID)) TYPE = innodb;
CREATE TABLE STORE_DU (NAME VARCHAR(255) NOT NULL, DEPLOYDT DATETIME, DEPLOYER VARCHAR(255), DIR VARCHAR(255), PRIMARY KEY (NAME)) TYPE = innodb;
CREATE TABLE STORE_PROCESS (PID VARCHAR(255) NOT NULL, STATE VARCHAR(255), TYPE VARCHAR(255), VERSION BIGINT, DU VARCHAR(255), PRIMARY KEY (PID)) TYPE = innodb;
CREATE TABLE STORE_PROCESS_PROP (id BIGINT NOT NULL, PROP_KEY VARCHAR(255), PROP_VAL VARCHAR(255), PRIMARY KEY (id)) TYPE = innodb;
CREATE TABLE STORE_PROC_TO_PROP (ProcessConfDaoImpl_PID VARCHAR(255), element_id BIGINT) TYPE = innodb;
CREATE TABLE STORE_VERSIONS (id BIGINT NOT NULL, VERSION BIGINT, PRIMARY KEY (id)) TYPE = innodb;
CREATE INDEX I_D_CTVRY_INSTANCE ON ODE_ACTIVITY_RECOVERY (INSTANCE_ID);
CREATE INDEX I_D_CR_ST_SCOPE ON ODE_CORRELATION_SET (SCOPE_ID);
CREATE INDEX I_D_CRLTR_PROCESS ON ODE_CORRELATOR (PROC_ID);
CREATE INDEX I_D_CRPRP_CORRSET ON ODE_CORSET_PROP (CORRSET_ID);
CREATE INDEX I_OD_VENT_INSTANCE ON ODE_EVENT (INSTANCE_ID);
CREATE INDEX I_OD_VENT_PROCESS ON ODE_EVENT (PROCESS_ID);
CREATE INDEX I_D_MSHNG_CORRELATOR ON ODE_MESSAGE_EXCHANGE (CORRELATOR);
CREATE INDEX I_D_MSHNG_PARTNERLINK ON ODE_MESSAGE_EXCHANGE (PLINK);
CREATE INDEX I_D_MSHNG_PROCESS ON ODE_MESSAGE_EXCHANGE (PROCESS);
CREATE INDEX I_D_MSHNG_PROCESSINST ON ODE_MESSAGE_EXCHANGE (INSTANCE);
CREATE INDEX I_D_MSHNG_REQUEST ON ODE_MESSAGE_EXCHANGE (REQUEST);
CREATE INDEX I_D_MSHNG_RESPONSE ON ODE_MESSAGE_EXCHANGE (RESPONSE);
CREATE INDEX I_D_MS_RT_CORRELATOR ON ODE_MESSAGE_ROUTE (CORR_ID);
CREATE INDEX I_D_MS_RT_PROCESSINST ON ODE_MESSAGE_ROUTE (PROCESS_INSTANCE_ID);
CREATE INDEX I_D_MXPRP_MEX ON ODE_MEX_PROP (MEX_ID);
CREATE INDEX I_D_PRLNK_SCOPE ON ODE_PARTNER_LINK (SCOPE_ID);
CREATE INDEX I_D_PRTNC_FAULT ON ODE_PROCESS_INSTANCE (FAULT_ID);
CREATE INDEX I_D_PRTNC_INSTANTIATINGCORRELATOR ON ODE_PROCESS_INSTANCE (INSTANTIATING_CORRELATOR_ID);
CREATE INDEX I_D_PRTNC_PROCESS ON ODE_PROCESS_INSTANCE (PROCESS_ID);
CREATE INDEX I_D_PRTNC_ROOTSCOPE ON ODE_PROCESS_INSTANCE (ROOT_SCOPE_ID);
CREATE INDEX I_OD_SCOP_PARENTSCOPE ON ODE_SCOPE (PARENT_SCOPE_ID);
CREATE INDEX I_OD_SCOP_PROCESSINSTANCE ON ODE_SCOPE (PROCESS_INSTANCE_ID);
CREATE INDEX I_D_XM_DT_SCOPE ON ODE_XML_DATA (SCOPE_ID);
CREATE INDEX I_D_XMPRP_XMLDATA ON ODE_XML_DATA_PROP (XML_DATA_ID);
CREATE INDEX I_STR_CSS_DU ON STORE_PROCESS (DU);
CREATE INDEX I_STR_PRP_ELEMENT ON STORE_PROC_TO_PROP (element_id);
CREATE INDEX I_STR_PRP_PROCESSCONFDAOIMPL_PID ON STORE_PROC_TO_PROP (ProcessConfDaoImpl_PID);
-- Apache ODE - SimpleScheduler Database Schema
-- 
-- MySQL scripts by Maciej Szefler.
-- 
-- 
DROP TABLE IF EXISTS ODE_JOB;

CREATE TABLE ODE_JOB (
  jobid CHAR(64)  NOT NULL DEFAULT '',
  ts BIGINT  NOT NULL DEFAULT 0,
  nodeid char(64)  NULL,
  scheduled int  NOT NULL DEFAULT 0,
  transacted int  NOT NULL DEFAULT 0,
  details blob(4096)  NULL,
  PRIMARY KEY(jobid),
  INDEX IDX_ODE_JOB_TS(ts),
  INDEX IDX_ODE_JOB_NODEID(nodeid)
)
TYPE=InnoDB;

COMMIT;

