_item_apply_ability_level:
    type: procedure
    definitions: item[The base item] | ability_id[The ability script ID] | level['base' or 'super']
    script:
    - define ability <[ability_id].proc[get_ability_by_id]>
    - adjust def:item lore:<[ability].proc[ability_get_lore].context[<[level]>]>
    - define proxies <[ability].proc[ability_get_proxies].context[<[level]>]>
    - if <[proxies]> != null:
        - adjust def:item enchantments:<[proxies]>
    - define glint_map <[item].material.name.equals[bow].if_true[protection=1].if_false[infinity=1]>
    - adjust def:item enchantments:<[glint_map]>
    - define ability_map <[item].flag[ability].if_null[<map>]>
    - adjust def:item flag:ability:<[ability].proc[ability_get_data_map].context[<[ability_id]>|<[level]>|<[ability_map]>]>
    - determine <[item]>

item_apply_ability_base:
    type: procedure
    debug: false
    definitions: item[The base item] | ability_id[The ability script ID]
    script:
    - adjust def:item hides:enchants
    - determine <[item].proc[_item_apply_ability_level].context[<[ability_id]>|base]>

item_apply_ability_super:
    type: procedure
    debug: false
    definitions: item[The item with an ability]
    script:
    - determine <[item].proc[_item_apply_ability_level].context[<[item].flag[ability.id]>|super]>

item_grant_ability:
    type: procedure
    debug: false
    definitions: item[The base item] | ability_id[The ability script ID] | level['base' or 'super']
    script:
    - define item <[item].proc[item_apply_ability_base].context[<[ability_id]>]>
    - if <[level]> == super:
        - define item <[item].proc[item_apply_ability_super]>
    - determine <[item]>
