/**************************************************************************
 * Project : Ocypus Nexus
 * File    : sqlite.sql
 * Version : 1.0.0
 * Database: SQLite 3.45+
 *
 * Description:
 * Official database schema for Ocypus Nexus PIM System.
 *
 * This file is the single source of truth for database creation.
 **************************************************************************/

PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;
PRAGMA temp_store = MEMORY;
PRAGMA cache_size = -200000;
PRAGMA busy_timeout = 5000;

BEGIN TRANSACTION;
TEXT(36)
id TEXT PRIMARY KEY,

created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

created_by TEXT,

updated_by TEXT,

version INTEGER NOT NULL DEFAULT 1,

status TEXT NOT NULL DEFAULT 'ACTIVE',

is_deleted INTEGER NOT NULL DEFAULT 0,

deleted_at DATETIME,

deleted_by TEXT
CREATE TABLE brand
(
    id              TEXT PRIMARY KEY,

    code            TEXT NOT NULL UNIQUE,

    name            TEXT NOT NULL,

    description     TEXT,

    website         TEXT,

    logo_asset_id   TEXT,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by      TEXT,

    updated_by      TEXT,

    version         INTEGER NOT NULL DEFAULT 1,

    status          TEXT NOT NULL DEFAULT 'ACTIVE',

    is_deleted      INTEGER NOT NULL DEFAULT 0,

    deleted_at      DATETIME,

    deleted_by      TEXT
);
CREATE TABLE category
(
    id              TEXT PRIMARY KEY,

    brand_id        TEXT NOT NULL,

    code            TEXT NOT NULL UNIQUE,

    name            TEXT NOT NULL,

    description     TEXT,

    display_order   INTEGER DEFAULT 0,

    icon            TEXT,

    active          INTEGER NOT NULL DEFAULT 1,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by      TEXT,

    updated_by      TEXT,

    version         INTEGER NOT NULL DEFAULT 1,

    status          TEXT NOT NULL DEFAULT 'ACTIVE',

    is_deleted      INTEGER NOT NULL DEFAULT 0,

    deleted_at      DATETIME,

    deleted_by      TEXT,

    FOREIGN KEY (brand_id)
        REFERENCES brand(id)
);
CREATE TABLE product_type
(
    id              TEXT PRIMARY KEY,

    category_id     TEXT NOT NULL,

    code            TEXT NOT NULL UNIQUE,

    name            TEXT NOT NULL,

    description     TEXT,

    display_order   INTEGER DEFAULT 0,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by      TEXT,

    updated_by      TEXT,

    version         INTEGER NOT NULL DEFAULT 1,

    status          TEXT NOT NULL DEFAULT 'ACTIVE',

    is_deleted      INTEGER NOT NULL DEFAULT 0,

    deleted_at      DATETIME,

    deleted_by      TEXT,

    FOREIGN KEY(category_id)
        REFERENCES category(id)
);
CREATE TABLE series
(
    id              TEXT PRIMARY KEY,

    product_type_id TEXT NOT NULL,

    code            TEXT NOT NULL UNIQUE,

    name            TEXT NOT NULL,

    display_order   INTEGER DEFAULT 0,

    description     TEXT,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by      TEXT,

    updated_by      TEXT,

    version         INTEGER NOT NULL DEFAULT 1,

    status          TEXT NOT NULL DEFAULT 'ACTIVE',

    is_deleted      INTEGER NOT NULL DEFAULT 0,

    deleted_at      DATETIME,

    deleted_by      TEXT,

    FOREIGN KEY(product_type_id)
        REFERENCES product_type(id)
);
CREATE TABLE unit
(
    id              TEXT PRIMARY KEY,

    code            TEXT NOT NULL UNIQUE,

    symbol          TEXT NOT NULL,

    quantity_type   TEXT NOT NULL,

    description     TEXT,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by      TEXT,

    updated_by      TEXT,

    version         INTEGER NOT NULL DEFAULT 1,

    status          TEXT NOT NULL DEFAULT 'ACTIVE',

    is_deleted      INTEGER NOT NULL DEFAULT 0,

    deleted_at      DATETIME,

    deleted_by      TEXT
);
CREATE TABLE language
(
    id              TEXT PRIMARY KEY,

    code            TEXT NOT NULL UNIQUE,

    name            TEXT NOT NULL,

    native_name     TEXT,

    locale          TEXT,

    is_default      INTEGER DEFAULT 0,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE translation
(
    id                  TEXT PRIMARY KEY,

    language_id         TEXT NOT NULL,

    entity_name         TEXT NOT NULL,

    entity_id           TEXT NOT NULL,

    field_name          TEXT NOT NULL,

    translated_value    TEXT NOT NULL,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(language_id)
        REFERENCES language(id)
);
CREATE TABLE user
(
    id                  TEXT PRIMARY KEY,

    username            TEXT NOT NULL UNIQUE,

    email               TEXT NOT NULL UNIQUE,

    password_hash       TEXT NOT NULL,

    display_name        TEXT NOT NULL,

    avatar              TEXT,

    phone               TEXT,

    is_active           INTEGER NOT NULL DEFAULT 1,

    last_login_at       DATETIME,

    password_changed_at DATETIME,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by          TEXT,

    updated_by          TEXT,

    version             INTEGER NOT NULL DEFAULT 1,

    status              TEXT NOT NULL DEFAULT 'ACTIVE',

    is_deleted          INTEGER NOT NULL DEFAULT 0,

    deleted_at          DATETIME,

    deleted_by          TEXT
);
CREATE TABLE role
(
    id              TEXT PRIMARY KEY,

    code            TEXT NOT NULL UNIQUE,

    name            TEXT NOT NULL,

    description     TEXT,

    is_system       INTEGER NOT NULL DEFAULT 0,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by      TEXT,

    updated_by      TEXT,

    version         INTEGER NOT NULL DEFAULT 1,

    status          TEXT NOT NULL DEFAULT 'ACTIVE',

    is_deleted      INTEGER NOT NULL DEFAULT 0,

    deleted_at      DATETIME,

    deleted_by      TEXT
);
CREATE TABLE permission
(
    id              TEXT PRIMARY KEY,

    module          TEXT NOT NULL,

    action          TEXT NOT NULL,

    code            TEXT NOT NULL UNIQUE,

    display_name    TEXT NOT NULL,

    description     TEXT,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE user_role
(
    id              TEXT PRIMARY KEY,

    user_id         TEXT NOT NULL,

    role_id         TEXT NOT NULL,

    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    UNIQUE(user_id, role_id),

    FOREIGN KEY(user_id) REFERENCES user(id),

    FOREIGN KEY(role_id) REFERENCES role(id)
);
CREATE TABLE role_permission
(
    id                  TEXT PRIMARY KEY,

    role_id             TEXT NOT NULL,

    permission_id       TEXT NOT NULL,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    UNIQUE(role_id, permission_id),

    FOREIGN KEY(role_id)
        REFERENCES role(id),

    FOREIGN KEY(permission_id)
        REFERENCES permission(id)
);
CREATE TABLE refresh_token
(
    id                  TEXT PRIMARY KEY,

    user_id             TEXT NOT NULL,

    token               TEXT NOT NULL,

    expires_at          DATETIME NOT NULL,

    revoked             INTEGER NOT NULL DEFAULT 0,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES user(id)
);
CREATE TABLE login_history
(
    id                  TEXT PRIMARY KEY,

    user_id             TEXT NOT NULL,

    username            TEXT NOT NULL,

    login_time          DATETIME NOT NULL,

    logout_time         DATETIME,

    ip_address          TEXT,

    browser             TEXT,

    operating_system    TEXT,

    device              TEXT,

    success             INTEGER NOT NULL,

    failure_reason      TEXT,

    FOREIGN KEY(user_id)
        REFERENCES user(id)
);
CREATE INDEX IDX_USER_USERNAME
ON user(username);

CREATE INDEX IDX_USER_EMAIL
ON user(email);

CREATE INDEX IDX_USER_ACTIVE
ON user(is_active);

CREATE INDEX IDX_ROLE_NAME
ON role(name);

CREATE INDEX IDX_PERMISSION_MODULE
ON permission(module);

CREATE INDEX IDX_LOGIN_USER
ON login_history(user_id);

CREATE INDEX IDX_LOGIN_TIME
ON login_history(login_time);

CREATE INDEX IDX_REFRESH_TOKEN
ON refresh_token(user_id);
INSERT INTO role
(id, code, name, is_system)

VALUES

('ROLE-0001','SUPER_ADMIN','Super Administrator',1),

('ROLE-0002','ADMIN','Administrator',1),

('ROLE-0003','PRODUCT_MANAGER','Product Manager',1),

('ROLE-0004','ENGINEER','Engineer',1),

('ROLE-0005','MARKETING','Marketing',1),

('ROLE-0006','VIEWER','Viewer',1);
INSERT INTO permission

(id,module,action,code,display_name)

VALUES

('PER-0001','product','view','product:view','View Product'),

('PER-0002','product','create','product:create','Create Product'),

('PER-0003','product','update','product:update','Update Product'),

('PER-0004','product','delete','product:delete','Delete Product'),

('PER-0005','excel','import','excel:import','Import Excel'),

('PER-0006','excel','export','excel:export','Export Excel'),

('PER-0007','metadata','update','metadata:update','Manage Metadata'),

('PER-0008','user','manage','user:manage','Manage User');
id              INTEGER PRIMARY KEY AUTOINCREMENT,
uuid            TEXT NOT NULL UNIQUE
CREATE TABLE product
(
    id                      TEXT PRIMARY KEY,

    series_id               TEXT NOT NULL,

    product_code            TEXT NOT NULL UNIQUE,

    product_name            TEXT NOT NULL,

    marketing_name          TEXT,

    description             TEXT,

    lifecycle_status        TEXT NOT NULL DEFAULT 'DEVELOPMENT',

    current_revision_id     TEXT,

    release_date            DATETIME,

    end_of_life_date        DATETIME,

    created_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by              TEXT,

    updated_by              TEXT,

    version                 INTEGER NOT NULL DEFAULT 1,

    status                  TEXT NOT NULL DEFAULT 'ACTIVE',

    is_deleted              INTEGER NOT NULL DEFAULT 0,

    deleted_at              DATETIME,

    deleted_by              TEXT,

    FOREIGN KEY(series_id)
        REFERENCES series(id)
);
CREATE TABLE product_revision
(
    id                      TEXT PRIMARY KEY,

    product_id              TEXT NOT NULL,

    revision_code           TEXT NOT NULL,

    template_id             TEXT,

    template_version_id     TEXT,

    released_at             DATETIME,

    released_by             TEXT,

    change_log              TEXT,

    is_current              INTEGER NOT NULL DEFAULT 0,

    created_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    version                 INTEGER NOT NULL DEFAULT 1,

    FOREIGN KEY(product_id)
        REFERENCES product(id)
);
CREATE UNIQUE INDEX UK_PRODUCT_REVISION

ON product_revision

(product_id, revision_code);
CREATE TABLE sku
(
    id                      TEXT PRIMARY KEY,

    revision_id             TEXT NOT NULL,

    sku_code                TEXT NOT NULL UNIQUE,

    part_number             TEXT,

    barcode                 TEXT,

    color                   TEXT,

    region                  TEXT,

    upc                     TEXT,

    ean                     TEXT,

    weight                  REAL,

    package_weight          REAL,

    active                  INTEGER DEFAULT 1,

    created_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(revision_id)
        REFERENCES product_revision(id)
);
CREATE TABLE product_relation
(
    id                      TEXT PRIMARY KEY,

    source_product_id        TEXT NOT NULL,

    target_product_id        TEXT NOT NULL,

    relation_type            TEXT NOT NULL,

    created_at               DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(source_product_id)
        REFERENCES product(id),

    FOREIGN KEY(target_product_id)
        REFERENCES product(id)
);
CREATE TABLE asset
(
    id                      TEXT PRIMARY KEY,

    file_name               TEXT NOT NULL,

    original_name           TEXT,

    file_extension          TEXT,

    mime_type               TEXT,

    file_size               INTEGER,

    sha256                  TEXT,

    storage_path            TEXT NOT NULL,

    width                   INTEGER,

    height                  INTEGER,

    duration                INTEGER,

    created_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE product_asset
(
    id                      TEXT PRIMARY KEY,

    product_revision_id      TEXT NOT NULL,

    asset_id                TEXT NOT NULL,

    asset_type              TEXT NOT NULL,

    display_order           INTEGER DEFAULT 0,

    created_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(product_revision_id)
        REFERENCES product_revision(id),

    FOREIGN KEY(asset_id)
        REFERENCES asset(id)
);
CREATE INDEX IDX_PRODUCT_CODE
ON product(product_code);

CREATE INDEX IDX_PRODUCT_NAME
ON product(product_name);

CREATE INDEX IDX_PRODUCT_SERIES
ON product(series_id);

CREATE INDEX IDX_PRODUCT_STATUS
ON product(lifecycle_status);

CREATE INDEX IDX_REVISION_PRODUCT
ON product_revision(product_id);

CREATE INDEX IDX_REVISION_CURRENT
ON product_revision(is_current);

CREATE INDEX IDX_SKU_CODE
ON sku(sku_code);

CREATE INDEX IDX_SKU_REGION
ON sku(region);

CREATE INDEX IDX_ASSET_SHA256
ON asset(sha256);

CREATE INDEX IDX_PRODUCT_ASSET
ON product_asset(product_revision_id);
CREATE TABLE metadata_template
(
    id                  TEXT PRIMARY KEY,

    category_id         TEXT NOT NULL,

    code                TEXT NOT NULL UNIQUE,

    name                TEXT NOT NULL,

    version             TEXT NOT NULL,

    description         TEXT,

    is_active           INTEGER NOT NULL DEFAULT 1,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(category_id)
        REFERENCES category(id)
);
CREATE TABLE template_group
(
    id                  TEXT PRIMARY KEY,

    template_id         TEXT NOT NULL,

    group_name          TEXT NOT NULL,

    display_order       INTEGER DEFAULT 0,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(template_id)
        REFERENCES metadata_template(id)
);
CREATE TABLE attribute_group
(
    id                  TEXT PRIMARY KEY,

    template_group_id   TEXT NOT NULL,

    code                TEXT NOT NULL,

    name                TEXT NOT NULL,

    display_order       INTEGER DEFAULT 0,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(template_group_id)
        REFERENCES template_group(id)
);
CREATE TABLE attribute
(
    id                      TEXT PRIMARY KEY,

    attribute_group_id      TEXT NOT NULL,

    code                    TEXT NOT NULL UNIQUE,

    name                    TEXT NOT NULL,

    description             TEXT,

    data_type               TEXT NOT NULL,

    unit_id                 TEXT,

    default_value           TEXT,

    required                INTEGER DEFAULT 0,

    searchable              INTEGER DEFAULT 1,

    exportable              INTEGER DEFAULT 1,

    editable                INTEGER DEFAULT 1,

    display_order           INTEGER DEFAULT 0,

    created_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(attribute_group_id)
        REFERENCES attribute_group(id),

    FOREIGN KEY(unit_id)
        REFERENCES unit(id)
);
CREATE TABLE attribute_option
(
    id                  TEXT PRIMARY KEY,

    attribute_id        TEXT NOT NULL,

    option_value        TEXT NOT NULL,

    display_text        TEXT NOT NULL,

    display_order       INTEGER DEFAULT 0,

    is_default          INTEGER DEFAULT 0,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(attribute_id)
        REFERENCES attribute(id)
);
CREATE TABLE validation_rule
(
    id                  TEXT PRIMARY KEY,

    attribute_id        TEXT NOT NULL,

    rule_type           TEXT NOT NULL,

    rule_value          TEXT,

    error_message       TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(attribute_id)
        REFERENCES attribute(id)
);
CREATE TABLE product_attribute_value
(
    id                      TEXT PRIMARY KEY,

    revision_id             TEXT NOT NULL,

    attribute_id            TEXT NOT NULL,

    value_text              TEXT,

    value_number            REAL,

    value_boolean           INTEGER,

    value_datetime          DATETIME,

    value_json              TEXT,

    display_value           TEXT,

    created_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(revision_id)
        REFERENCES product_revision(id),

    FOREIGN KEY(attribute_id)
        REFERENCES attribute(id)
);
value_hash TEXT
CREATE INDEX IDX_TEMPLATE_CATEGORY
ON metadata_template(category_id);

CREATE INDEX IDX_ATTRIBUTE_GROUP
ON attribute(attribute_group_id);

CREATE INDEX IDX_ATTRIBUTE_CODE
ON attribute(code);

CREATE INDEX IDX_ATTRIBUTE_TYPE
ON attribute(data_type);

CREATE INDEX IDX_OPTION_ATTRIBUTE
ON attribute_option(attribute_id);

CREATE INDEX IDX_RULE_ATTRIBUTE
ON validation_rule(attribute_id);

CREATE INDEX IDX_VALUE_REVISION
ON product_attribute_value(revision_id);

CREATE INDEX IDX_VALUE_ATTRIBUTE
ON product_attribute_value(attribute_id);

CREATE INDEX IDX_VALUE_TEXT
ON product_attribute_value(value_text);

CREATE INDEX IDX_VALUE_NUMBER
ON product_attribute_value(value_number);
CHECK (
    (
        value_text IS NOT NULL
    ) +
    (
        value_number IS NOT NULL
    ) +
    (
        value_boolean IS NOT NULL
    ) +
    (
        value_datetime IS NOT NULL
    ) +
    (
        value_json IS NOT NULL
    ) <= 1
)
CREATE TRIGGER trg_product_attribute_value_updated
AFTER UPDATE
ON product_attribute_value
BEGIN
    UPDATE product_attribute_value
    SET updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.id;
END;
CREATE TABLE excel_template
(
    id                  TEXT PRIMARY KEY,

    category_id         TEXT NOT NULL,

    code                TEXT NOT NULL UNIQUE,

    name                TEXT NOT NULL,

    description         TEXT,

    current_version_id  TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(category_id)
        REFERENCES category(id)
);
CREATE TABLE excel_template_version
(
    id                  TEXT PRIMARY KEY,

    template_id         TEXT NOT NULL,

    version             TEXT NOT NULL,

    file_name           TEXT NOT NULL,

    file_hash           TEXT NOT NULL,

    asset_id            TEXT,

    published_by        TEXT,

    published_at        DATETIME,

    is_active           INTEGER DEFAULT 1,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(template_id)
        REFERENCES excel_template(id),

    FOREIGN KEY(asset_id)
        REFERENCES asset(id)
);
CREATE TABLE excel_sheet
(
    id                  TEXT PRIMARY KEY,

    template_version_id TEXT NOT NULL,

    sheet_name          TEXT NOT NULL,

    display_order       INTEGER DEFAULT 0,

    is_hidden           INTEGER DEFAULT 0,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(template_version_id)
        REFERENCES excel_template_version(id)
);
CREATE TABLE excel_style
(
    id                  TEXT PRIMARY KEY,

    template_version_id TEXT NOT NULL,

    style_name          TEXT NOT NULL,

    style_json          TEXT NOT NULL,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(template_version_id)
        REFERENCES excel_template_version(id)
);
CREATE TABLE excel_cell
(
    id                  TEXT PRIMARY KEY,

    sheet_id            TEXT NOT NULL,

    cell_address        TEXT NOT NULL,

    merged_range        TEXT,

    style_id            TEXT,

    default_value       TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(sheet_id)
        REFERENCES excel_sheet(id),

    FOREIGN KEY(style_id)
        REFERENCES excel_style(id)
);
CREATE TABLE excel_mapping
(
    id                  TEXT PRIMARY KEY,

    sheet_id            TEXT NOT NULL,

    attribute_id        TEXT NOT NULL,

    cell_address        TEXT NOT NULL,

    formatter           TEXT,

    default_value       TEXT,

    is_required         INTEGER DEFAULT 0,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(sheet_id)
        REFERENCES excel_sheet(id),

    FOREIGN KEY(attribute_id)
        REFERENCES attribute(id)
);
CREATE TABLE excel_image
(
    id                  TEXT PRIMARY KEY,

    sheet_id            TEXT NOT NULL,

    asset_id            TEXT NOT NULL,

    anchor_cell         TEXT NOT NULL,

    width               INTEGER,

    height              INTEGER,

    image_type          TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(sheet_id)
        REFERENCES excel_sheet(id),

    FOREIGN KEY(asset_id)
        REFERENCES asset(id)
);
CREATE TABLE excel_formula
(
    id                  TEXT PRIMARY KEY,

    sheet_id            TEXT NOT NULL,

    cell_address        TEXT NOT NULL,

    formula             TEXT NOT NULL,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(sheet_id)
        REFERENCES excel_sheet(id)
);
CREATE TABLE excel_print_setting
(
    id                  TEXT PRIMARY KEY,

    template_version_id TEXT NOT NULL,

    paper_size          TEXT,

    orientation         TEXT,

    fit_to_page         INTEGER DEFAULT 1,

    margin_top          REAL,

    margin_bottom       REAL,

    margin_left         REAL,

    margin_right        REAL,

    print_area          TEXT,

    repeat_rows         TEXT,

    repeat_columns      TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(template_version_id)
        REFERENCES excel_template_version(id)
);
CREATE INDEX IDX_EXCEL_TEMPLATE_CATEGORY
ON excel_template(category_id);

CREATE INDEX IDX_TEMPLATE_VERSION
ON excel_template_version(template_id);

CREATE INDEX IDX_SHEET_TEMPLATE
ON excel_sheet(template_version_id);

CREATE INDEX IDX_MAPPING_ATTRIBUTE
ON excel_mapping(attribute_id);

CREATE INDEX IDX_MAPPING_SHEET
ON excel_mapping(sheet_id);

CREATE INDEX IDX_CELL_SHEET
ON excel_cell(sheet_id);

CREATE INDEX IDX_FORMULA_SHEET
ON excel_formula(sheet_id);

CREATE INDEX IDX_IMAGE_SHEET
ON excel_image(sheet_id);
INSERT INTO excel_template
(id, category_id, code, name)
VALUES
(
'TEMPLATE-0001',
'CATEGORY-CASE',
'CASE_STANDARD',
'Case Standard Template'
);
CREATE TABLE excel_validation
(
    id                  TEXT PRIMARY KEY,

    template_version_id TEXT NOT NULL,

    validation_type     TEXT NOT NULL,

    validation_rule     TEXT NOT NULL,

    error_message       TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE audit_log
(
    id                  TEXT PRIMARY KEY,

    module              TEXT NOT NULL,

    entity_name         TEXT NOT NULL,

    entity_id           TEXT NOT NULL,

    operation           TEXT NOT NULL,

    operator_id         TEXT,

    operator_name       TEXT,

    ip_address          TEXT,

    user_agent          TEXT,

    request_id          TEXT,

    result              TEXT NOT NULL,

    operated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    remarks             TEXT
);
CREATE TABLE change_history
(
    id                  TEXT PRIMARY KEY,

    audit_log_id        TEXT NOT NULL,

    field_name          TEXT NOT NULL,

    display_name        TEXT,

    old_value           TEXT,

    new_value           TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(audit_log_id)
        REFERENCES audit_log(id)
);
CREATE TABLE import_history
(
    id                  TEXT PRIMARY KEY,

    template_id         TEXT,

    template_version_id TEXT,

    filename            TEXT NOT NULL,

    imported_by         TEXT,

    total_rows          INTEGER DEFAULT 0,

    success_rows        INTEGER DEFAULT 0,

    failed_rows         INTEGER DEFAULT 0,

    duration_ms         INTEGER,

    status              TEXT,

    error_report_asset  TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE export_history
(
    id                  TEXT PRIMARY KEY,

    template_id         TEXT,

    template_version_id TEXT,

    exported_by         TEXT,

    exported_rows       INTEGER,

    duration_ms         INTEGER,

    file_hash           TEXT,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE approval_flow
(
    id                  TEXT PRIMARY KEY,

    flow_code           TEXT NOT NULL UNIQUE,

    flow_name           TEXT NOT NULL,

    description         TEXT,

    enabled             INTEGER DEFAULT 1,

    created_at          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE approval_task
(
    id                  TEXT PRIMARY KEY,

    flow_id             TEXT NOT NULL,

    revision_id         TEXT NOT NULL,

    current_step        INTEGER NOT NULL,

    current_approver    TEXT,

    status              TEXT NOT NULL,

    submitted_at        DATETIME,

    completed_at        DATETIME,

    FOREIGN KEY(flow_id)
        REFERENCES approval_flow(id),

    FOREIGN KEY(revision_id)
        REFERENCES product_revision(id)
);
CREATE TABLE approval_record
(
    id                  TEXT PRIMARY KEY,

    task_id             TEXT NOT NULL,

    approver_id         TEXT,

    action              TEXT NOT NULL,

    comment             TEXT,

    approved_at         DATETIME,

    FOREIGN KEY(task_id)
        REFERENCES approval_task(id)
);
CREATE TABLE product_timeline
(
    id                  TEXT PRIMARY KEY,

    product_id          TEXT NOT NULL,

    revision_id         TEXT,

    event_type          TEXT NOT NULL,

    event_title         TEXT NOT NULL,

    event_description   TEXT,

    operator_id         TEXT,

    occurred_at         DATETIME NOT NULL,

    FOREIGN KEY(product_id)
        REFERENCES product(id),

    FOREIGN KEY(revision_id)
        REFERENCES product_revision(id)
);
CREATE INDEX IDX_AUDIT_ENTITY
ON audit_log(entity_name, entity_id);

CREATE INDEX IDX_AUDIT_OPERATOR
ON audit_log(operator_id);

CREATE INDEX IDX_AUDIT_TIME
ON audit_log(operated_at);

CREATE INDEX IDX_CHANGE_AUDIT
ON change_history(audit_log_id);

CREATE INDEX IDX_IMPORT_TIME
ON import_history(created_at);

CREATE INDEX IDX_EXPORT_TIME
ON export_history(created_at);

CREATE INDEX IDX_APPROVAL_STATUS
ON approval_task(status);

CREATE INDEX IDX_APPROVAL_FLOW
ON approval_task(flow_id);

CREATE INDEX IDX_TIMELINE_PRODUCT
ON product_timeline(product_id);

CREATE INDEX IDX_TIMELINE_TIME
ON product_timeline(occurred_at);
CREATE TRIGGER trg_product_created
AFTER INSERT
ON product
BEGIN

INSERT INTO product_timeline
(
    id,
    product_id,
    event_type,
    event_title,
    occurred_at
)

VALUES
(
    lower(hex(randomblob(16))),
    NEW.id,
    'PRODUCT_CREATED',
    'Product Created',
    CURRENT_TIMESTAMP
);

END;
CREATE TRIGGER trg_revision_release
AFTER UPDATE OF is_current
ON product_revision
WHEN NEW.is_current = 1
BEGIN

INSERT INTO product_timeline
(
    id,
    product_id,
    revision_id,
    event_type,
    event_title,
    occurred_at
)

VALUES
(
    lower(hex(randomblob(16))),
    NEW.product_id,
    NEW.id,
    'PRODUCT_RELEASED',
    'Revision Released',
    CURRENT_TIMESTAMP
);

END;
CREATE TABLE schema_version
(
    id              INTEGER PRIMARY KEY AUTOINCREMENT,

    version         TEXT NOT NULL UNIQUE,

    description     TEXT,

    installed_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO schema_version
(
version,
description
)

VALUES
(
'1.0.0',
'Initial Release'
);
CREATE VIEW vw_current_product AS

SELECT

p.id,

p.product_code,

p.product_name,

r.id AS revision_id,

r.revision_code,

r.released_at

FROM product p

JOIN product_revision r

ON p.current_revision_id = r.id;
CREATE VIEW vw_product_sku AS

SELECT

p.product_code,

p.product_name,

s.sku_code,

s.color,

s.region

FROM product p

JOIN product_revision r

ON p.current_revision_id = r.id

JOIN sku s

ON s.revision_id = r.id;
CREATE VIEW vw_product_asset AS

SELECT

p.product_code,

a.file_name,

pa.asset_type,

pa.display_order

FROM product_asset pa

JOIN asset a

ON pa.asset_id = a.id

JOIN product_revision pr

ON pa.product_revision_id = pr.id

JOIN product p

ON pr.product_id = p.id;
CREATE TRIGGER trg_update_product_timestamp

AFTER UPDATE

ON product

BEGIN

UPDATE product

SET updated_at = CURRENT_TIMESTAMP

WHERE id = NEW.id;

END;
CREATE TRIGGER trg_revision_version

AFTER UPDATE

ON product_revision

BEGIN

UPDATE product_revision

SET version = version + 1

WHERE id = NEW.id;

END;
-- 示例（建议由应用层统一写入）

INSERT INTO audit_log
(
module,
entity_name,
entity_id,
operation
)

VALUES
(
'product',
'product',
NEW.id,
'UPDATE'
);
PRAGMA foreign_keys = ON;

PRAGMA journal_mode = WAL;

PRAGMA synchronous = NORMAL;

PRAGMA cache_size = -200000;

PRAGMA temp_store = MEMORY;

PRAGMA mmap_size = 268435456;

PRAGMA busy_timeout = 5000;
CREATE INDEX IDX_PRODUCT_RELEASE

ON product(release_date);

CREATE INDEX IDX_REVISION_RELEASE

ON product_revision(released_at);

CREATE INDEX IDX_TIMELINE_PRODUCT_TIME

ON product_timeline
(
product_id,
occurred_at DESC
);

CREATE INDEX IDX_TRANSLATION

ON translation
(
entity_name,
entity_id,
language_id
);
INSERT INTO language

(code,name,is_default)

VALUES

('en-US','English',1),

('zh-CN','简体中文',0),

('zh-TW','繁體中文',0),

('ja-JP','日本語',0),

('ko-KR','한국어',0);
INSERT INTO unit

(code,symbol)

VALUES

('MM','mm'),

('CM','cm'),

('M','m'),

('G','g'),

('KG','kg'),

('W','W'),

('RPM','RPM'),

('DBA','dBA');
COMMIT;
