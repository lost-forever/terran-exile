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

ability_supercharge:
    type: task
    definitions: item
    script:
    - define ability_id <[item].flag[ability.id]>
    - define ability <script[<[ability_id]>]>
