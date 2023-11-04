# Fetches an ability script by its ID.
# The script must be loaded with a `te$ability` key.
# @def ability_id: the ability ID, or its script name
# @determine the ability script, or 'null' if none exists
get_ability_by_id:
    type: procedure
    debug: false
    definitions: ability_id[The ability script ID]
    script:
    - determine <server.flag[abilities.<[ability_id]>].if_null[null]>

item_has_ability:
    type: procedure
    definitions: item[The equipment item] | ability_id[The ability script ID]
    script:
    - determine <[item].has_flag[ability].and[<[item].flag[ability.id].equals[<[ability_id]>]>]>

# item_get_ability_level:
#     type: procedure
#     debug: false
#     definitions: item[The equipment item] | ability_id[The ability script ID]
#     script:
#     - if <[item].has_flag[ability]> and <[item].flag[ability.id]> == <[ability_id]>:
#         - determine <[item].flag[ability.level]>
#     - determine null

# TODO this should probably be optimized
entity_get_ability_level:
    type: procedure
    debug: false
    definitions: entity[The living entity] | ability_id[The ability script ID]
    script:
    - define ability <[ability_id].proc[get_ability_by_id]>
    - define equipment <[entity].equipment_map.with[main_hand].as[<[entity].item_in_hand>].with[offhand].as[<[entity].item_in_offhand>]>
    - define items <[equipment].get[<[ability].data_key[slots]>].as[list]>
    - foreach <[items]> as:item:
        - define level <[item].proc[item_get_ability_level].context[<[ability_id]>]>
        - if <[level]> != null:
            - determine <[level]>
    - determine null
