ability_get_name:
    type: procedure
    definitions: ability[Ability data script] | stage_id['base' or 'super']
    script:
    - define name <[ability].data_key[name]>
    - define format <[stage_id].equals[super].if_true[<bold>].if_false[<empty>]>
    - define gradient <[ability].data_key[<[stage_id]>.colors]>
    - determine <[format]><[name].color_gradient[<[gradient].with[style].as[hsb]>]>

ability_get_description:
    type: procedure
    definitions: ability[Ability data script] | stage_id['base' or 'super']
    script:
    - define lines <[ability].data_key[<[stage_id]>.description]>
    - determine <[lines].parse_tag[<dark_gray><[parse_value]>]>

ability_get_lore:
    type: procedure
    definitions: ability[Ability data script] | stage_id['base' or 'super']
    script:
    - define name <[ability].proc[ability_get_name].context[<[stage_id]>]>
    - define description <[ability].proc[ability_get_description].context[<[stage_id]>]>
    - determine <[name].as[list].include[<[description]>]>

ability_get_proxies:
    type: procedure
    definitions: ability[Ability data script] | stage_id['base' or 'super']
    script:
    - determine <[ability].data_key[<[stage_id]>.proxies]>

ability_grant:
    type: procedure
    definitions: item|ability_id
    script:
    - define ability <script[<[ability_id]>]>
    - adjust def:item lore:<[ability].proc[ability_get_lore].context[base]>
    - adjust def:item enchantments:<[ability].proc[ability_get_proxies].context[base]>
    - adjust def:item hides:enchants
    - determine <[item]>

ability_supercharge:
    type: task
    definitions: item
    script:
    - define ability_id <[item].flag[ability.id]>
    - define ability <script[<[ability_id]>]>
