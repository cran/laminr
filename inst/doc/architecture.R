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
##     %% Use #emsp; to create indents in the rendered diagram when necessary
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
##         +initialize(
##           #emsp;InstanceSettings Instance_settings, API api,
##           #emsp;Map<String, any> schema
##         ): Instance
##         +get_modules(): Module[]
##         +get_module(String module_name): Module
##         +get_module_names(): String[]
##     }
##     class InstanceAPI{
##         +initialize(InstanceSettings Instance_settings)
##         +get_schema(): Map<String, Any>
##         +get_record(...): Map<String, Any>
##     }
##     class Module{
##         +initialize(
##           #emsp;Instance Instance, API api, String module_name,
##           #emsp;Map<String, any> module_schema
##         ): Module
##         +name: String
##         +get_registries(): Registry[]
##         +get_registry(String registry_name): Registry
##         +get_registry_names(): String[]
##     }
##     class Registry{
##         +initialize(
##           #emsp;Instance Instance, Module module, API api,
##           #emsp;String registry_name, Map<String, Any> registry_schema
##         ): Registry
##         +name: String
##         +class_name: String
##         +is_link_table: Bool
##         +get_fields(): Field[]
##         +get_field(String field_name): Field
##         +get_field_names(): String[]
##         +get(String id_or_uid, Bool include_foreign_keys, List~String~ select, Bool verbose): RichRecord
##         +get_registry_class(): RichRecordClass
##         +df(Integer limit, Bool verbose): DataFrame
##     }
##     class Field{
##         +initialize(
##           #emsp;String type, String through, String field_name, String registry_name,
##           #emsp;String column_name, String module_name, Bool is_link_table, String relation_type,
##           #emsp;String related_field_name, String related_registry_name, String related_module_name
##         ): Field
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
##         +initialize(Instance Instance, Registry registry, API api, Map<String, Any> data): Record
##         +get_value(String field_name): Any
##     }
##     class RelatedRecords{
##         +initialize(
##           #emsp;Instance instance, Registry registry, Field field,
##           #emsp;String related_to, API api
##         ): RelatedRecords
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
##     RichRecord --|> Record
##     Registry --> Artifact
##     Artifact --|> Record
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
##         +initialize(
##           #emsp;InstanceSettings Instance_settings, API api,
##           #emsp;Map<String, any> schema
##         ): Instance
##         +get_modules(): Module[]
##         +get_module(String module_name): Module
##         +get_module_names(): String[]
##     }
##     class InstanceAPI{
##         +initialize(InstanceSettings Instance_settings)
##         +get_schema(): Map<String, Any>
##         +get_record(...): Map<String, Any>
##     }
##     class Module{
##         +initialize(
##           #emsp;Instance Instance, API api, String module_name,
##           #emsp;Map<String, any> module_schema
##         ): Module
##         +name: String
##         +get_registries(): Registry[]
##         +get_registry(String registry_name): Registry
##         +get_registry_names(): String[]
##     }
##     class Registry{
##         +initialize(
##           #emsp;Instance Instance, Module module, API api,
##           #emsp;String registry_name, Map<String, Any> registry_schema
##         ): Registry
##         +name: String
##         +class_name: String
##         +is_link_table: Bool
##         +get_fields(): Field[]
##         +get_field(String field_name): Field
##         +get_field_names(): String[]
##         +get(String id_or_uid, Bool include_foreign_keys, List~String~ select, Bool verbose): RichRecord
##         +get_registry_class(): RichRecordClass
##         +df(Integer limit, Bool verbose): DataFrame
##     }
##     class Field{
##         +initialize(
##           #emsp;String type, String through, String field_name, String registry_name,
##           #emsp;String column_name, String module_name, Bool is_link_table, String relation_type,
##           #emsp;String related_field_name, String related_registry_name, String related_module_name
##         ): Field
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
##         +initialize(Instance Instance, Registry registry, API api, Map<String, Any> data): Record
##         +get_value(String field_name): Any
##     }
##     class RelatedRecords{
##         +initialize(
##           #emsp;Instance instance, Registry registry, Field field,
##           #emsp;String related_to, API api
##         ): RelatedRecords
##         +df(): DataFrame
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
##     class Artifact{
##         +...field value accessors...
##         +cache(): String
##         +load(): AnnData | DataFrame | ...
##         +describe(): NULL
##     }
##     style Artifact fill:#ffe1c9
##     %% -------------------------------------------------------------------------
## %% # nolint end
