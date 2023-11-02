get_ability_by_id:
    type: procedure
    debug: false
    definitions: ability_id[The ability script ID]
    script:
    - determine <server.flag[abilities.<[ability_id]>].if_null[null]>

item_get_ability_level:
    type: procedure
    debug: false
    definitions: item[The equipment item] | ability_id[The ability script ID]
    script:
    - if <[item].has_flag[ability]> and <[item].flag[ability.id]> == <[ability_id]>:
        - determine <[item].flag[ability.level]>
    - determine null

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

ability_get_name:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | stage_id['base' or 'super']
    script:
    - define name <[ability].data_key[name]>
    - define format <[stage_id].equals[super].if_true[<bold>].if_false[<empty>]>
    - define gradient <[ability].data_key[<[stage_id]>.colors]>
    - determine <[format]><[name].color_gradient[<[gradient].with[style].as[hsb]>]>

ability_get_description:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | stage_id['base' or 'super']
    script:
    - define lines <[ability].data_key[<[stage_id]>.description]>
    - determine <[lines].parse_tag[<dark_gray><[parse_value]>]>

ability_get_lore:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | stage_id['base' or 'super']
    script:
    - define name <[ability].proc[ability_get_name].context[<[stage_id]>]>
    - define description <[ability].proc[ability_get_description].context[<[stage_id]>]>
    - determine <[name].as[list].include[<[description]>]>

ability_get_proxies:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | stage_id['base' or 'super']
    script:
    - determine <[ability].data_key[<[stage_id]>.proxies].if_null[null]>

item_grant_ability:
    type: procedure
    debug: false
    definitions: item[The base item] | ability_id[The ability script ID]
    script:
    - define ability <[ability_id].proc[get_ability_by_id]>
    - adjust def:item lore:<[ability].proc[ability_get_lore].context[base]>
    - define proxies <[ability].proc[ability_get_proxies].context[base]>
    - if <[proxies]> != null:
        - adjust def:item enchantments:<[proxies]>
    - adjust def:item hides:enchants
    - adjust def:item flag:ability:<map[id=<[ability_id]>;level=base]>
    - determine <[item]>

ability_supercharge:
    type: task
    definitions: item
    script:
    - define ability_id <[item].flag[ability.id]>
    - define ability <script[<[ability_id]>]>
