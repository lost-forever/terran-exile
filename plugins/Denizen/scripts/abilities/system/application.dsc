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
    - adjust def:item flag:ability:<map[id=<[ability_id]>;level=base;<[ability_id]>=true]>
    - determine <[item]>

item_supercharge:
    type: procedure
    definitions: item[The item with an ability]
    script:
    - define ability <[item].flag[ability.id].proc[get_ability_by_id]>
    - adjust def:item lore:<[ability].proc[ability_get_lore].context[super]>
    - define proxies <[ability].proc[ability_get_proxies].context[super]>
    - if <[proxies]> != null:
        - adjust def:item enchantments:<[item].enchantment_map.include[<[proxies]>]>
    - adjust def:item flag:ability.level:super
    - determine <[item]>

item_apply_ability:
    type: procedure
    definitions: item[The base item] | ability_id[The ability script ID] | level['base' or 'super']
    script:
    - define item <[item].proc[item_grant_ability].context[<[ability_id]>]>
    - if <[level]> == super:
        - define item <[item].proc[item_supercharge]>
    - determine <[item]>
