## classDiagram
## %% # nolint start
##     laminr --> Instance
##     laminr --> UserSettings
##     laminr --> InstanceSettings
##     Instance --> InstanceAPI
##     Instance --> Module
##     Module --> Registry
##     Registry --> Field
##     Registry --> Record
##     Field --> RelatedRecords
##     Record --> RelatedRecords
##     UserSettings --> InstanceSettings
##     InstanceSettings --> Instance
##     InstanceAPI --> Module
##     Instance --> Registry
##     InstanceAPI --> Registry
##     Instance --> Record
##     InstanceAPI --> Record
##     Instance --> RelatedRecords
##     InstanceAPI --> RelatedRecords
## 
##     %% Methods must be on one line to be shown in the right diagram section
##     %% Use \n for newlines and #emsp; to create indents in the rendered
##     %% diagram when necessary
## 
##     class laminr{
##         +connect(String slug): RichInstance
##     }
##     class UserSettings{
##         +initialize(...): UserSettings
##         +email: String
##         +access_token: String
##         +uid: String
##         +uuid: String
##         +handle: String
##         +name: String
##     }
##     class InstanceSettings{
##         +initialize(...): InstanceSettings
##         +owner: String
##         +name: String
##         +id: String
##         +schema_id: String
##         +api_url: String
##     }
##     class Instance{
##         +initialize(\n#emsp;InstanceSettings Instance_settings, API api, \n#emsp;Map<String, any> schema\n): Instance
##         +get_modules(): Module[]
##         +get_module(String module_name): Module
##         +get_module_names(): String[]
##         +get_api(): InstanceAPI
##         +get_settings(): InstanceSettings
##         +get_py_lamin(Boolean check, String what): PythonModule
##         +track(String path, String transform): NULL
##         +finish(): NULL
##         +is_default: Boolean
##     }
##     class InstanceAPI{
##         +initialize(InstanceSettings Instance_settings)
##         +get_schema(): Map<String, Any>
##         +get_record(...): Map<String, Any>
##         +get_records(...): Map<String, Any>
##         +delete_record(...): NULL
##     }
##     class Module{
##         +initialize(\n#emsp;Instance Instance, API api, String module_name,\n#emsp;Map<String, any> module_schema\n): Module
##         +name: String
##         +get_registries(): Registry[]
##         +get_registry(String registry_name): Registry
##         +get_registry_names(): String[]
##     }
##     class Registry{
##         +initialize(\n#emsp;Instance Instance, Module module, API api,\n#emsp;String registry_name, Map<String, Any> registry_schema\n): Registry
##         +name: String
##         +class_name: String
##         +is_link_table: Bool
##         +get_fields(): Field[]
##         +get_field(String field_name): Field
##         +get_field_names(): String[]
##         +get(\n#emsp;String id_or_uid, Bool include_foreign_keys,\n#emsp;List~String~ select, Bool verbose\n): RichRecord
##         +get_record_class(): RichRecordClass
##         +get_temporary_record_class(): TemporaryRecordClass
##         +df(Integer limit, Bool verbose): DataFrame
##         +from_df(\n#emsp;DataFrame dataframe, String key,\n#emsp;String description, String run\n): TemporaryRecord
##         +from_path(\n#emsp;Path path, String key, String description, String run\n): TemporaryRecord
##         +from_anndata(\n#emsp;AnnData adata, String key, String description, String run\n): TemporaryRecord
##     }
##     class Field{
##         +initialize(\n#emsp;String type, String through, String field_name,\n#emsp;String registry_name, String column_name, String module_name,\n#emsp;Bool is_link_table, String relation_type, String related_field_name,\n#emsp;String related_registry_name, String related_module_name\n): Field
##         +type: String
##         +through: Map
##         +field_name: String
##         +registry_name: String
##         +column_name: String
##         +module_name: String
##         +is_link_table: Bool
##         +relation_type: String
##         +related_field_name: String
##         +related_registry_name: String
##         +related_module_name: String
##     }
##     class Record{
##         +initialize(\n#emsp;Instance Instance, Registry registry,\n#emsp;API api, Map<String, Any> data\n): Record
##         +get_value(String field_name): Any
##         +delete(): NULL
##     }
##     class RelatedRecords{
##         +initialize(\n#emsp;Instance instance, Registry registry, Field field,\n#emsp;String related_to, API api\n): RelatedRecords
##         +df(): DataFrame
##         +field: Field
##     }
## %% # nolint end

## classDiagram
## %% # nolint start
##     %% --- Copied from base diagram --------------------------------------------
##     laminr --> UserSettings
##     laminr --> InstanceSettings
##     Instance --> InstanceAPI
##     Instance --> Module
##     Module --> Registry
##     Registry --> Field
##     Field --> RelatedRecords
##     Record --> RelatedRecords
##     UserSettings --> InstanceSettings
##     InstanceSettings --> Instance
##     InstanceAPI --> Module
##     Instance --> Registry
##     InstanceAPI --> Registry
##     Instance --> Record
##     InstanceAPI --> Record
##     Instance --> RelatedRecords
##     InstanceAPI --> RelatedRecords
##     %% -------------------------------------------------------------------------
## 
##     %% --- New links for Rich classes ------------------------------------------
##     RichInstance --|> Instance
##     laminr --> RichInstance
##     Core --|> Module
##     RichInstance --> Core
##     Bionty --|> Module
##     RichInstance --> Bionty
##     Registry --> RichRecord
##     Registry --> TemporaryRecord
##     RichRecord --|> Record
##     TemporaryRecord --|> RichRecord
##     Registry --> Artifact
##     Artifact --|> RichRecord
##     %% -------------------------------------------------------------------------
## 
##     %% --- Copied from base diagram --------------------------------------------
##     class laminr{
##         +connect(String slug): RichInstance
##     }
##     class UserSettings{
##         +initialize(...): UserSettings
##         +email: String
##         +access_token: String
##         +uid: String
##         +uuid: String
##         +handle: String
##         +name: String
##     }
##     class InstanceSettings{
##         +initialize(...): InstanceSettings
##         +owner: String
##         +name: String
##         +id: String
##         +schema_id: String
##         +api_url: String
##     }
##     class Instance{
##         +initialize(\n#emsp;InstanceSettings Instance_settings, API api, \n#emsp;Map<String, any> schema\n): Instance
##         +get_modules(): Module[]
##         +get_module(String module_name): Module
##         +get_module_names(): String[]
##         +get_api(): InstanceAPI
##         +get_settings(): InstanceSettings
##         +get_py_lamin(Boolean check, String what): PythonModule
##         +track(String path, String transform): NULL
##         +finish(): NULL
##         +is_default: Boolean
##     }
##     class InstanceAPI{
##         +initialize(InstanceSettings Instance_settings)
##         +get_schema(): Map<String, Any>
##         +get_record(...): Map<String, Any>
##         +get_records(...): Map<String, Any>
##         +delete_record(...): NULL
##     }
##     class Module{
##         +initialize(\n#emsp;Instance Instance, API api, String module_name,\n#emsp;Map<String, any> module_schema\n): Module
##         +name: String
##         +get_registries(): Registry[]
##         +get_registry(String registry_name): Registry
##         +get_registry_names(): String[]
##     }
##     class Registry{
##         +initialize(\n#emsp;Instance Instance, Module module, API api,\n#emsp;String registry_name, Map<String, Any> registry_schema\n): Registry
##         +name: String
##         +class_name: String
##         +is_link_table: Bool
##         +get_fields(): Field[]
##         +get_field(String field_name): Field
##         +get_field_names(): String[]
##         +get(\n#emsp;String id_or_uid, Bool include_foreign_keys,\n#emsp;List~String~ select, Bool verbose\n): RichRecord
##         +get_record_class(): RichRecordClass
##         +get_temporary_record_class(): TemporaryRecordClass
##         +df(Integer limit, Bool verbose): DataFrame
##         +from_df(\n#emsp;DataFrame dataframe, String key,\n#emsp;String description, String run\n): TemporaryRecord
##         +from_path(\n#emsp;Path path, String key, String description, String run\n): TemporaryRecord
##         +from_anndata(\n#emsp;AnnData adata, String key, String description, String run\n): TemporaryRecord
##     }
##     class Field{
##         +initialize(\n#emsp;String type, String through, String field_name,\n#emsp;String registry_name, String column_name, String module_name,\n#emsp;Bool is_link_table, String relation_type, String related_field_name,\n#emsp;String related_registry_name, String related_module_name\n): Field
##         +type: String
##         +through: Map
##         +field_name: String
##         +registry_name: String
##         +column_name: String
##         +module_name: String
##         +is_link_table: Bool
##         +relation_type: String
##         +related_field_name: String
##         +related_registry_name: String
##         +related_module_name: String
##     }
##     class Record{
##         +initialize(\n#emsp;Instance Instance, Registry registry,\n#emsp;API api, Map<String, Any> data\n): Record
##         +get_value(String field_name): Any
##         +delete(): NULL
##     }
##     class RelatedRecords{
##         +initialize(\n#emsp;Instance instance, Registry registry, Field field,\n#emsp;String related_to, API api\n): RelatedRecords
##         +df(): DataFrame
##         +field: Field
##     }
##     %% -------------------------------------------------------------------------
## 
##     %% --- New Rich classes ----------------------------------------------------
##     class RichInstance{
##         +initialize(
##           #emsp;InstanceSettings Instance_settings, API api,
##           #emsp;Map<String, any> schema
##         ): RichInstance
##         +Registry Artifact
##         +Registry Collection
##         +...registry accessors...
##         +Registry User
##         +Bionty bionty
##     }
##     style RichInstance fill:#ffe1c9
##     class Core{
##         +Registry Artifact
##         +Registry Collection
##         +...registry accessors...
##         +Registry User
##     }
##     style Core fill:#ffe1c9
##     class Bionty{
##         +Registry CellLine
##         +Registry CellMarker
##         +...registry accessors...
##         +Registry Tissue
##     }
##     style Bionty fill:#ffe1c9
##     class RichRecord{
##         +...field value accessors...
##     }
##     style RichRecord fill:#ffe1c9
##     class TemporaryRecord{
##         +save(): NULL
##     }
##     style TemporaryRecord fill:#ffe1c9
##     class Artifact{
##         +...field value accessors...
##         +cache(): String
##         +load(): AnnData | DataFrame | ...
##         +describe(): NULL
##     }
##     style Artifact fill:#ffe1c9
##     %% -------------------------------------------------------------------------
## %% # nolint end
